class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def after_sign_in_path_for(resource_or_scope)
    courses_path
  end

  def after_sign_up_path_for(resource_or_scope)
    root_path
  end

  def is_login?
    unless current_user
      flash[:error] = "Please login"
      redirect_to '/'
    end
  end
  
end