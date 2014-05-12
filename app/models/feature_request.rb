class FeatureRequest < ActiveRecord::Base
  belongs_to :feature
  belongs_to :usability_survey

  validates :feature, presence: true
  validates :usability_survey, presence: true
  
end
