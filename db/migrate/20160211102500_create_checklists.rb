# frozen_string_literal: true

class CreateChecklists < ActiveRecord::Migration
  def change
    create_table :checklists do |t|
      t.references :survey, index: true, foreign_key: true
      t.references :sector, index: true, foreign_key: true
      t.references :area, index: true, foreign_key: true
      t.integer :max_parties
      t.integer :min_parties
      t.boolean :feeder_watch
      t.boolean :on_island
      t.string :location
      t.time :start_time
      t.time :end_time
      t.float :break_hours
      t.float :hours_foot
      t.float :hours_car
      t.float :hours_boat
      t.float :hours_owling
      t.float :hours_total
      t.float :miles_foot
      t.float :miles_car
      t.float :miles_boat
      t.float :miles_owling
      t.float :miles_total

      t.timestamps null: false
    end
  end
end
