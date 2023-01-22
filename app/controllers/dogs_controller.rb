class DogsController < ApplicationController
  include Authentication
  before_action :set_dog, only: %i[ show edit update destroy ]

  # GET /dogs or /dogs.json
  def index
    @dogs = Dog.all
  end

  # GET /dogs/1 or /dogs/1.json
  def show
    @dog_images = @dog.dog_pictures
  end

  # GET /dogs/new
  def new
    @dog = Dog.new
    @dog_images = @dog.dog_pictures.build
    @places = Place.pluck(:name,:id).sort
    @dog_states = DogState.pluck(:name,:id).sort
    @breeds = Breed.pluck(:name,:id).sort
  end

  # GET /dogs/1/edit
  def edit
  end

  # POST /dogs or /dogs.json
  def create
    @dog = Dog.new(dog_params)
    @dog.public_id = generate_public_id
    if @dog.valid? && @dog.save
      params[:dog_images]['image'].each do |a|
        @dog_image = @dog.dog_pictures.create!(:image => a,:dog_id => @dog.id) unless a.blank?
      end
      @dog.versions.create!(event: params[:commit], whodunnit: "#{current_user.username}")
      @dog.reload
      redirect_to dog_path(@dog.uuid), flash: { notice: "Successully Added Dog Data" }
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dogs/1 or /dogs/1.json
  def update
    respond_to do |format|
      if @dog.update(dog_params)
        format.html { redirect_to dog_url(@dog), notice: "Dog was successfully updated." }
        format.json { render :show, status: :ok, location: @dog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dogs/1 or /dogs/1.json
  def destroy
    @dog.destroy

    respond_to do |format|
      format.html { redirect_to dogs_url, notice: "Dog was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dog
      @dog = Dog.find_by(uuid: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dog_params
      params.require(:dog).permit(:breed_id, :place_id, :dog_state_id, :age, :gender, :neutered, dog_images_attributes: 
        [:id, :dog_id, :image])
    end

    def generate_public_id
      Time.now.strftime("%b%d%y") + "_" + ((SecureRandom.random_number(9e2) + 1e2).to_i).to_s
    end
end
