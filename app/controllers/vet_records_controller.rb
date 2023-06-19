class VetRecordsController < ApplicationController
  include Authentication
  include ActiveStorage::SetCurrent
  before_action :allowed_edit, only: %i[ edit update ]
  before_action :allowed_delete, only: %i[ destroy ]
  before_action :allowed_create, only: %i[ new ]
  before_action :set_vet_record, only: %i[ show edit update destroy ]
  before_action :set_image, only: %i[ show ]
  after_action :set_image, only: %i[ create update ]
  
  # GET /vet_records or /vet_records.json
  def index
    @vet_records = VetRecord.where(archived_at: nil).sort_by(&:created_at).reverse    
  end

  # GET /vet_records/1 or /vet_records/1.json
  def show
  end

  # GET /vet_records/new
  def new
    @vet_record = VetRecord.new
    @age_list_options = AgeList.pluck(:name, :id)
    @place_list_options = Place.pluck(:name, :id)

  end

  # GET /vet_records/1/edit
  def edit
    @age_list_options = AgeList.pluck(:name, :id)
    @place_list_options = Place.pluck(:name, :id)
    @status_list_options = PetStatusCondition.where(status_or_condition: true).pluck(:name, :id)
    @condition_list_options = PetStatusCondition.where(status_or_condition: false).pluck(:name, :id)
  end

  # POST /vet_records or /vet_records.json
  def create
    vet_params = vet_record_params.except(:medical_histories)
    @vet_record = current_user.vet_records.new(vet_params)
    if vet_record_params[:medical_histories].present?
      medical_histories_params = vet_record_params[:medical_histories]
    end
    if @vet_record.save
      notice = "Vet record was successfully created."
      if medical_histories_params.present?
        notice = "Vet record with medical history(ies) were successfully created."
        medical_histories_params.each do |medical_history_params|
          medical_history = @vet_record.medical_histories.new(medical_history_params[1])
          if medical_history.save
            medical_history.versions.create!(event: "Create Medical History", whodunnit: "#{current_user.username}")
          end
        end
      end
      @vet_record.versions.create!(event: "Create Vet Record", whodunnit: "#{current_user.username}")
      redirect_to vet_records_path, notice: notice
    else
      redirect_to new_vet_record_path, alert: "Error: #{@vet_record.errors.full_messages.join(', ')}"
    end
  end 

  # PATCH/PUT /vet_records/1 or /vet_records/1.json
  def update
    vet_params = vet_record_params.except(:medical_histories)
    if vet_record_params[:medical_histories].present?
      medical_histories_params = vet_record_params[:medical_histories]
    end
    if vet_record_params[:pet_status_conditions].present?
      pet_status_conditions_params = vet_record_params[:pet_status_conditions]
    end
    if @vet_record.update(vet_params)
      notice = "Vet record was successfully updated."
      if medical_histories_params.present?
        notice = "Vet record with medical history(ies) were successfully updated."
        medical_histories_params.each do |medical_history_params|
          medical_history = @vet_record.medical_histories.new(medical_history_params[1])
          if medical_history.save
            medical_history.versions.create!(event: "Create Medical History", whodunnit: "#{current_user.username}")
          end
        end
      end
      @vet_record.versions.create!(event: "Update Vet Record", whodunnit: "#{current_user.username}")
      redirect_to vet_records_path, notice: notice
    else
      redirect_to edit_vet_record_path(@vet_record), alert: "Error: #{vet_record.errors.full_messages.join(', ')}"
    end
  end

  # DELETE /vet_records/1 or /vet_records/1.json
  def destroy
    @vet_record.archive
    @vet_record.versions.create!(event: "Archive Vet Record", whodunnit: "#{current_user.username}")
    redirect_to vet_records_path, notice: "Vet record was successfully archived."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vet_record
      @vet_record = VetRecord.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vet_record_params
      params.require(:vet_record).permit(
        :id, 
        :name, 
        :archived_at, 
        :species, 
        :picture, 
        :age_list_id, 
        :place_id, 
        :pet_owner, 
        :pet_owner_phone, 
        :breed, 
        :pet_gender, 
        :pet_neutered, 
        :status_id,
        :condition_id,
        medical_histories: [
          :id, 
          :name, 
          :description, 
          :vet_place, 
          :date_recorded, 
          :_destroy
        ]
      )
    end

    def set_image
      # attach dog_placeholder.png if no image is attached
      @vet_record.picture.attach(io: File.open("#{Rails.root}/app/assets/images/dog_placeholder.png"), filename: 'dog_placeholder.png', content_type: 'image/png') unless @vet_record.picture.attached?
    end

    def allowed_edit
      redirect_to vet_records_path, alert: "Error: You are not allowed to edit this vet record." unless current_user.admin? || current_user.doctor? || current_user == @vet_record.user
    end
    
    def allowed_archive
      redirect_to vet_records_path, alert: "Error: You are not allowed to archive this vet record." unless current_user.admin? || current_user.doctor? || @vet_record.user == current_user
    end

    def allowed_create
      redirect_to vet_records_path, alert: "Error: You are not allowed to create vet records." unless current_user.admin? || current_user.doctor? || current_user.frontliner?
    end

    
end
