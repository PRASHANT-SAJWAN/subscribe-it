class UsersController < ApplicationController

  def login
    return if request.get?
    current_user = User.find_by_name(params[:login][:name])
    raise "failed to fetch current user" if current_user.nil?

    session[:current_user_id] = current_user.id
    redirect_to '/products'
  end

  def signup
    return if request.get?
    name = params[:signup][:name]
    user = User.find_or_create_by!(name: name, email: name + "@test.com")
    
    raise "failed to create user" if user.nil?

    session[:current_user_id] = user.id
    redirect_to '/products'
  end
end
