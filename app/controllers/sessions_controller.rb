class SessionsController < ApplicationController
  def new
    
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to (session[:intended_url] || user)
      session[:intended_url] = nil
    else
      render :new, status: :unprocessable_entity
    end
  end
end
