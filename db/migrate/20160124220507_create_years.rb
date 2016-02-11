class CreateYears < ActiveRecord::Migration
  def change
    create_table :years do |t|
      t.integer :audubon_year
      t.integer :vashon_year

      t.timestamps null: false
    end
  end
end
