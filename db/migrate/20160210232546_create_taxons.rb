# frozen_string_literal: true

class CreateTaxons < ActiveRecord::Migration
  def change
    create_table :taxons do |t|
      t.string :common_name
      t.string :cbc_name
      t.string :scientific_name
      t.integer :taxonomic_order
      t.boolean :generic
      t.boolean :active

      t.timestamps null: false
    end
    add_index :taxons, :taxonomic_order, unique: true
  end
end
