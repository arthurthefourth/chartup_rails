class CreateFeatureRequests < ActiveRecord::Migration
  def change
    create_table :feature_requests do |t|
      t.integer :feature_id
      t.integer :usability_survey_id

      t.timestamps
    end

    add_index :feature_requests, :feature_id
    add_index :feature_requests, :usability_survey_id
    add_index :feature_requests, [:feature_id, :usability_survey_id], unique: true
  end
end
