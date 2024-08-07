# frozen_string_literal: true

class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.date :date
      t.references :year, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
