class UsabilitySurveysController < ApplicationController

  def new
    @survey = UsabilitySurvey.find(1)
    @features = Feature.all
    @requests = current_user.feature_requests if current_user
  end

end
