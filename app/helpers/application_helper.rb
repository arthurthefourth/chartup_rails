module ApplicationHelper

  # For accessing devise variables outside of Devise-specific views
  # Via http://pupeno.com/2010/08/29/show-a-devise-log-in-form-in-another-page/
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
end
