CREATE OR REPLACE FUNCTION delete_columns(schema_to_process TEXT, column_list TEXT[]) RETURNS VOID AS $BODY$
DECLARE
    column_record RECORD;
BEGIN
    FOR column_record IN
        SELECT * FROM information_schema.columns AS cinfo
        WHERE cinfo.table_schema = $1 AND cinfo.column_name = ANY($2)
    LOOP
        EXECUTE 'ALTER TABLE ' || $1 || '.' || column_record.table_name || ' DROP COLUMN IF EXISTS '
            || column_record.column_name || ' CASCADE;';
    END LOOP;
END;
$BODY$ LANGUAGE plpgsql;
