require 'test_helper'

class FeatureTest < ActiveSupport::TestCase

  test 'Feature should have a name' do
    f = Feature.new(category: 'Other')
    assert !f.valid?
  end
  
end