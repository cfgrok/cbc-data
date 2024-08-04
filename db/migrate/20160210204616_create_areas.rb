# frozen_string_literal: true

class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.boolean :on_island
      t.references :sector, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
