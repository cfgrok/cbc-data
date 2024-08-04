# frozen_string_literal: true

class CreateObservations < ActiveRecord::Migration
  def change
    create_table :observations do |t|
      t.integer :number
      t.references :taxon, index: true, foreign_key: true
      t.references :checklist, index: true, foreign_key: true
      t.boolean :count_week
      t.string :notes

      t.timestamps null: false
    end
  end
end
