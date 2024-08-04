# frozen_string_literal: true

class CreateObservers < ActiveRecord::Migration
  def change
    create_table :observers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email

      t.timestamps null: false
    end
  end
end
