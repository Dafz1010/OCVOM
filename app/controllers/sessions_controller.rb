class SessionsController < ApplicationController
  def new
    @user = User.new
    if current_user
      redirect_to dashboard_path
    end
  end

  def create
    @user = User.find_by(username: params[:username].downcase)
    if @user && @user.authenticate(params[:password]) && !@user.archived?
      log_in @user
      if @user.first_loggedin?
        redirect_to (session[:intended_url] || dashboard_path), flash: { notice: "Successully Logged In" }
      else
        redirect_to first_login_index_path, notice: "Required to change your password after first login" 
      end
    else
      flash.now[:alert] = "Invalid Username/Password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(session[:user_id])
    log_out(@user)
    redirect_to root_path, flash: { notice: "Successully Logged Out" }
  end
end