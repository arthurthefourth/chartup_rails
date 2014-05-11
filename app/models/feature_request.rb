class FeatureRequest < ActiveRecord::Base
  belongs_to :feature
  belongs_to :usability_survey
end
