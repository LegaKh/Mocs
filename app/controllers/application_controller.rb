class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :null_session

  private

  def authorize
    return (head :unauthorized) unless current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

end
