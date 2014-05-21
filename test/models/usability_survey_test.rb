require 'test_helper'

class UsabilitySurveyTest < ActiveSupport::TestCase

  test 'Survey should have a value for useful_now' do
    s = UsabilitySurvey.new(useful_eventually: true)
    assert !s.valid?    
  end

  test 'Survey should have a value for useful_eventually' do
    s = UsabilitySurvey.new(useful_now: true)
    assert !s.valid?    
  end
  
end
