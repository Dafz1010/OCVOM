class UsersController < ApplicationController
  include Authentication
  include ActionView::Helpers::UrlHelper
  skip_before_action :authenticate_user!, only: %i[ new create ]
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    all_logs = PaperTrail::Version.where.not(whodunnit: nil).order(created_at: :desc)
    @logs = sort_logs(all_logs)
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
      redirect_to users_path , notice: "Registered Successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    @user.skip_password_validation = true
    if @user.update(user_params)
      redirect_to (request.referrer || dashboard_path), notice: "Profile Image Updated"
    else
      redirect_to (request.referrer || dashboard_path), alert: "Image must be a JPEG or PNG"
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :username, :password, :password_confirmation, :profile_image)
    end

    def sort_logs(unsorted_logs)
      unsorted_logs.map do |record|
        case record[:event]
          when 'Login User'
            {log_text: "#{record.created_at.localtime.strftime('%b %d, %Y %I:%M %p')}: User #{record.whodunnit} Logged In"}
          when 'Logout User'
            {log_text: "#{record.created_at.localtime.strftime('%b %d, %Y %I:%M %p')}: User #{record.whodunnit} Logged Out"}
          when 'Register User'
            {log_text: "#{record.created_at.localtime.strftime('%b %d, %Y %I:%M %p')}: User #{record.whodunnit} was Registered"}
          when 'Create Dog'
            dog_data = Dog.find(record.item_id)
            log_string = ""
            if dog_data.archived?
              log_string = "<div class='d-inline-block'>#{dog_data.uuid}</div>"
            else
              log_string = "<div class='d-inline-block'>#{link_to dog_data.uuid, dog_path(dog_data.uuid)}</div>"
            end
            {log_text: "#{record.created_at.localtime.strftime('%b %d, %Y %I:%M %p')}: User #{record.whodunnit} created Dog Profile ID: #{log_string}"}
          when 'Archive Dog'
            dog_data = Dog.find(record.item_id)
            {log_text: "#{record.created_at.localtime.strftime('%b %d, %Y %I:%M %p')}: User #{record.whodunnit} archived Dog Profile ID: <div class='d-inline-block'>#{dog_data.uuid}</div>"}
          when 'Update Dog'
            dog_data = Dog.find(record.item_id)
            log_string = ""
            if dog_data.archived?
              log_string = "<div class='d-inline-block'>#{dog_data.uuid}</div>"
            else
              log_string = "<div class='d-inline-block'>#{link_to dog_data.uuid, dog_path(dog_data.uuid)}</div>"
            end
            {log_text: "#{record.created_at.localtime.strftime('%b %d, %Y %I:%M %p')}: User #{record.whodunnit} updated Dog Profile ID: #{log_string}"}
          else 
            {log_text: "Event: #{record[:event]}"}
        end
      end
    end
end
