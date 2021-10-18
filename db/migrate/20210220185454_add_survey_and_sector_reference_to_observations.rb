class AddSurveyAndSectorReferenceToObservations < ActiveRecord::Migration
  def change
    add_reference :observations, :survey, index: true, foreign_key: true
    add_reference :observations, :sector, index: true, foreign_key: true
  end
end
