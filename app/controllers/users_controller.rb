class UsersController < ApplicationController
  include Authentication
  before_action :set_user, only: %i[ show edit update destroy approval set_role]

  # GET /users or /users.json
  def index
    @users = User.all
    @roles = Role.pluck(:name,:id).sort
    @approved_users = @users.where(archived_at: nil).where.not(approved_at: nil)
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
      @user = User.new
      @roles = Role.pluck(:name,:id).sort
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @user.password = "Ormocanon"
    if @user.valid? && @user.save
      @user.approved_user!
      @user.versions.create!(event: "Create User", whodunnit: "#{@user.username}")

      redirect_to users_path , notice: "User Created Successully"
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

  def set_role
    if current_user.admin?
      @user.setrole(params[:user][:role_id])
      @user.versions.create!(event: "Set User Role,#{@user.type}", whodunnit: "#{current_user.username}")
      redirect_to users_path, flash: { notice: "Changed User Role" }
    else
      redirect_to users_path, flash: { alert: "Unauthorized Action" }
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
