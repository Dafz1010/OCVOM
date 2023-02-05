class UsersController < ApplicationController
  include Authentication
  skip_before_action :authenticate_user!, only: %i[ new create ]
  skip_before_action :approved_user!, only: %i[ new create ]
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
    @approved_users = @users.where(archived_at: nil).where.not(approved_at: nil)
    @unapproved_users = @users.where(archived_at: nil).where(approved_at: nil)
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    if !current_user
      @user = User.new
    else
      redirect_to dashboard_path, flash: {alert: "You are already Logged In"}
    end
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    if @user.valid? && @user.save
      session[:user_id] = @user.id
      @user.versions.create!(event: "Register User", whodunnit: "#{@user.username}")
      @user.versions.create!(event: "Login User", whodunnit: "#{@user.username}")
      redirect_to admin_approval_path , notice: "Registered Successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if @user.update(user_params)
      redirect_to (request.referrer || dashboard_path), notice: "Profile Image Updated"
    else
      redirect_to (request.referrer || dashboard_path), alert: "Image must be a JPEG or PNG"
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    unless current_user?(@user)
      @user.archive
      @user.versions.create!(event: "Archive User", whodunnit: "#{current_user.username}")
      redirect_to users_path, flash: { notice: "Successully Archive User" }
    else
      redirect_to users_path, flash: { alert: "Archive Yourself is not allowed" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :username, :password, :password_confirmation, :profile_image, :role_id)
    end
end
