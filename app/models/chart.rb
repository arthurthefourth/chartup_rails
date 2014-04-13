class Chart < ActiveRecord::Base
  # attr_accessor :title, :chartup
  belongs_to :user
  validates :title, presence: true
  validates :chartup, presence: true
end
