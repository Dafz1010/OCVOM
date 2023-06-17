class VetRecordsController < ApplicationController
  include Authentication
  include ActiveStorage::SetCurrent
  before_action :set_vet_record, only: %i[ show edit update destroy ]
  after_action :set_image, only: %i[ create update ]

  # GET /vet_records or /vet_records.json
  def index
    @vet_records = VetRecord.all.sort_by(&:created_at).reverse
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
  end

  # POST /vet_records or /vet_records.json
  def create
    vet_params = vet_record_params.except(:medical_histories)
    @vet_record = VetRecord.new(vet_params)
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
      redirect_to new_vet_record_path, alert: "Error: #{vet_record.errors.full_messages.join(', ')}"
    end
  end 

  # PATCH/PUT /vet_records/1 or /vet_records/1.json
  def update
    respond_to do |format|
      if @vet_record.update(vet_record_params)
        format.html { redirect_to vet_record_url(@vet_record), notice: "Vet record was successfully updated." }
        format.json { render :show, status: :ok, location: @vet_record }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vet_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vet_records/1 or /vet_records/1.json
  def destroy
    @vet_record.destroy

    respond_to do |format|
      format.html { redirect_to vet_records_url, notice: "Vet record was successfully destroyed." }
      format.json { head :no_content }
    end
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
end
