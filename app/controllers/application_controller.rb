class ApplicationController < ActionController::Base
  def current_user
    session[:current_user_id] = session[:current_user_id] || User.first.id
    User.find(session[:current_user_id])
  rescue
    User.first
  end
end
