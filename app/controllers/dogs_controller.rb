class DogsController < ApplicationController
  include Authentication
  before_action :set_dog, only: %i[ show edit update destroy ]

  # GET /dogs or /dogs.json
  def index
    redirect_to records_path
  end 

  # GET /dogs/1 or /dogs/1.json
  def show
    if @dog.archived?
      redirect_back fallback_location: records_path, flash: { alert: "Dog Profile was archived" }
    else
      @dog_images = @dog.dog_pictures.where(archived_at: nil) 
    end
  end

  # GET /dogs/new
  def new
    @dog = Dog.new
    @dog_images = @dog.dog_pictures.build
    @places = Place.pluck(:name,:id).sort
    @dog_states = DogState.pluck(:name,:id).sort
    @breeds = Breed.pluck(:name,:id).sort
    @conditions = Condition.pluck(:name,:id).sort
  end

  # GET /dogs/1/edit
  def edit
    @dog_images = @dog.dog_pictures.where(archived_at: nil)
    @places = Place.pluck(:name,:id).sort
    @dog_states = DogState.pluck(:name,:id).sort
    @breeds = Breed.pluck(:name,:id).sort
    @conditions = Condition.pluck(:name,:id).sort
  end

  # POST /dogs or /dogs.json
  def create
    @dog = Dog.new(dog_params)
    @dog.public_id = generate_public_id
    if @dog.valid? && @dog.save
      params[:dog_images]['image'].each do |a|
        @dog_image = @dog.dog_pictures.create!(:image => a,:dog_id => @dog.id) unless a.blank?
      end
      @dog.versions.create!(event: "Create Dog", whodunnit: "#{current_user.username}")
      @dog.reload
      redirect_to dog_path(@dog.uuid), flash: { notice: "Successully Added Dog Profile" }
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dogs/1 or /dogs/1.json
  def update
    if @dog.update(dog_params)
      dog_image = @dog.dog_pictures
      dog_image.each do |img|
        img.archive
      end
      params[:dog_images]['image'].each do |a|
        @dog_image = @dog.dog_pictures.create!(:image => a,:dog_id => @dog.id) unless a.blank?
      end
      @dog.versions.create!(event: "Update Dog", whodunnit: "#{current_user.username}")
      redirect_to dog_path(@dog.uuid), flash: { notice: "Successully Update Dog Profile" }
    else
      render :new, status: :unprocessable_entity
    end
  end 

  # DELETE /dogs/1 or /dogs/1.json
  def destroy
    @dog.archive
    @dog.versions.create!(event: "Archive Dog", whodunnit: "#{current_user.username}")
    redirect_to records_path, flash: { notice: "Successully Archive Dog Profile" }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dog
      @dog = Dog.find_by(uuid: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dog_params
      params.require(:dog).permit(:breed_id, :place_id, :age, :gender, :size, :neutered, dog_images_attributes: [:id, :dog_id, :image], condition_ids: [], dog_state_ids: [])
    end

    def generate_public_id
      Time.now.strftime("%b%d%y") + "_" + ((SecureRandom.random_number(9e2) + 1e2).to_i).to_s
    end
end
