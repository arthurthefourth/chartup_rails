class UsabilitySurvey < ActiveRecord::Base
  has_many :feature_requests
  has_many :features, through: :feature_requests

  validates :useful_now, presence: true
  validates :useful_eventually, presence: true

  accepts_nested_attributes_for :feature_requests

end
