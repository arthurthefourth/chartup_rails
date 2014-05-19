class UsabilitySurveysController < ApplicationController

  def edit
      @survey = current_user.latest_survey
      @requests = @survey.feature_requests
      @features = Feature.all
  end

  def new
    if current_user && current_user.latest_survey
      edit
      render :edit
    else
      @survey = UsabilitySurvey.new
      @requests = FeatureRequest.none
      @features = Feature.all
    end
  end


  def update
    if current_user
      @survey = current_user.latest_survey
      @survey.assign_attributes(survey_params)
    else
      @survey = UsabilitySurvey.create(survey_params)
    end
    save_survey
  end

  
  def create
    if current_user
      @survey = current_user.usability_surveys.build(survey_params)
    else
      @survey = UsabilitySurvey.create(survey_params)
    end

    save_survey
  end


  private

  def save_survey
    # Feature Requests and Usability Survey should all save properly
    UsabilitySurvey.transaction do

      logger.debug "Begin transaction"
      if @survey.save
        feature_params.each do |feature_id, value|
          if value == 'true'
            @survey.feature_requests.find_or_create_by(feature_id: feature_id)
            logger.debug "Finding or creating #{feature_id}, #{value}"
          else
            request = @survey.feature_requests.find_by(feature_id: feature_id)
            request.destroy if request
            logger.debug "Destroying or missing #{feature_id}, #{value}"
          end
        end
      end
    end

    if @survey.persisted?
      flash[:notice] = "Thanks for your help!"
      redirect_to survey_path
    else
      flash[:alert] = "There was a problem with your submission. Your survey was not saved."
      redirect_to survey_path
    end
    
  end

  def survey_params
    params.require(:usability_survey).permit(:useful_now, :useful_eventually)
  end

  def feature_params
    params[:usability_survey][:features]
  end

end
