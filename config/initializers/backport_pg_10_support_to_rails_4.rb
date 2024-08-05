# frozen_string_literal: true

require "active_record/connection_adapters/postgresql/schema_statements"

#
# Monkey-patch the refused Rails 4.2 patch at https://github.com/rails/rails/pull/31330
#
# Updates sequence logic to support PostgreSQL 10.
#

module ActiveRecord
  module ConnectionAdapters
    module PostgreSQL
      module SchemaStatements
        # Resets the sequence of a table's primary key to the maximum value.
        # rubocop:todo Metrics/AbcSize
        # rubocop:todo Metrics/CyclomaticComplexity
        # rubocop:todo Metrics/MethodLength
        # rubocop:todo Metrics/PerceivedComplexity
        # rubocop:todo Naming/MethodParameterName
        def reset_pk_sequence!(table, pk = nil, sequence = nil) # :nodoc:
          # rubocop:enable Naming/MethodParameterName
          unless pk && sequence
            default_pk, default_sequence = pk_and_sequence_for(table)

            pk ||= default_pk
            sequence ||= default_sequence
          end

          if @logger && pk && !sequence
            @logger.warn "#{table} has primary key #{pk} with no default sequence"
          end

          return unless pk && sequence

          quoted_sequence = quote_table_name(sequence)
          max_pk = select_value("SELECT MAX(#{quote_column_name pk}) FROM #{quote_table_name(table)}")
          if max_pk.nil?
            minvalue = if postgresql_version >= 100_000
              select_value("SELECT seqmin FROM pg_sequence WHERE seqrelid = #{quote(quoted_sequence)}::regclass")
            else
              select_value("SELECT min_value FROM #{quoted_sequence}")
            end
          end

          select_value <<-END_SQL, "SCHEMA"
              SELECT setval(#{quote(quoted_sequence)}, #{max_pk || minvalue}, #{max_pk ? true : false})
          END_SQL
        end
        # rubocop:enable Metrics/AbcSize
        # rubocop:enable Metrics/CyclomaticComplexity
        # rubocop:enable Metrics/MethodLength
        # rubocop:enable Metrics/PerceivedComplexity
      end
    end
  end
end
