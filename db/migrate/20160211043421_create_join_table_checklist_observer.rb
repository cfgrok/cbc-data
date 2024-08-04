# frozen_string_literal: true

class CreateJoinTableChecklistObserver < ActiveRecord::Migration
  def change
    create_join_table :checklists, :observers do |t|
      # t.index [:checklist_id, :observer_id]
      # t.index [:observer_id, :checklist_id]
    end
  end
end
