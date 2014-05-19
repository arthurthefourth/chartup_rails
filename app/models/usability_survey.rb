class UsabilitySurvey < ActiveRecord::Base
  has_many :feature_requests
  has_many :features, through: :feature_requests

  validates_inclusion_of :useful_now, in: [true, false]
  validates_inclusion_of :useful_eventually, in: [true, false]


  #accepts_nested_attributes_for :feature_requests

end
