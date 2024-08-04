# frozen_string_literal: true

class CreateSectors < ActiveRecord::Migration
  def change
    create_table :sectors do |t|
      t.string :name
      t.string :code
      t.boolean :on_island

      t.timestamps null: false
    end
  end
end
