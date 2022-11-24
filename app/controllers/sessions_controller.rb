class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to users_path
    end
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to users_path
    else
      render :new, status: :unprocessable_entity
    end
  end
end
