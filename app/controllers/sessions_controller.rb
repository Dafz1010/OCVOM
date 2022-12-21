class SessionsController < ApplicationController
  def new
    @user = User.new
    if current_user
      redirect_to users_path
    end
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      log_in @user
      redirect_to (session[:intended_url] || users_path), flash: { notice: "Successully Logged In" }
    else
      flash.now[:alert]= "Invalid Username/Password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_path, flash: { notice: "Successully Logged Out" }
  end
end
