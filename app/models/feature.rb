class Feature < ActiveRecord::Base
  has_many :feature_requests

  validates :name, presence: true

  def category_description
    descriptions = { language: 'Language Features', website: 'Website Features', application: 'Application' }
    descriptions.default = 'Other'
    descriptions[category.to_sym]
  end
end
