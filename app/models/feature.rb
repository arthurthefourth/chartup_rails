class Feature < ActiveRecord::Base
  has_many :feature_requests

  validates :name, presence: true
end
