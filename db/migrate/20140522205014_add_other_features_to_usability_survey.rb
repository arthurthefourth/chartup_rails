class AddOtherFeaturesToUsabilitySurvey < ActiveRecord::Migration
  def change
    add_column :usability_surveys, :other_feature1, :string
    add_column :usability_surveys, :other_feature2, :string
    add_column :usability_surveys, :other_feature3, :string
  end
end
