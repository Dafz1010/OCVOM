class FirstLoginController < ApplicationController
  include Authentication
  skip_before_action :changed_password_user!, only: %i[ index update ]
  def index
    redirect_to dashboard_path if current_user && current_user.first_loggedin?
  end

  def update
    if current_user && current_user.first_loggedin?
      redirect_to dashboard_path 
    else
      @user = current_user
      if @user && !@user.archived? && @user.authenticate(params[:user][:old_password])
        if params[:user][:new_password] == params[:user][:new_password_confirmation]
          @user.update(password: params[:user][:new_password], first_login_at: Time.now)
          @user.versions.create!(event: "Login User", whodunnit: "#{@user.username}")
          redirect_to (session[:intended_url] || dashboard_path), flash: { notice: "Successully Logged In" }
        else
          flash.now[:alert] = "Password Confirmation not match"
          render :index, status: :unprocessable_entity
        end
      else
        flash.now[:alert] = "Incorrect Password"
        render :index, status: :unprocessable_entity
      end
    end
  end
end
