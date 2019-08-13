class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    return nil if session[:user_id].nil?
    User.friendly.find(session[:user_id])
  end
end
