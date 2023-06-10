class InventoriesController < ApplicationController
  before_action :set_inventory, only: %i[ show edit update destroy ]
  before_action :set_all_params_downcase, only: %i[ create update ]

  # GET /inventories or /inventories.json
  def index
    @inventories = Inventory.all
  end

  # GET /inventories/1 or /inventories/1.json
  def show
  end

  # GET /inventories/new
  def new
    @inventory = Inventory.new
    @unique_names = Inventory.distinct.pluck(:name).compact
    @unique_categories = Inventory.distinct.pluck(:category).compact
    @unique_inventory_types = Inventory.distinct.pluck(:inventory_type).compact
    @prescription_selection = Inventory::PRESCRIPTION_SELECTION
  end  

  # GET /inventories/1/edit
  def edit
  end

  # POST /inventories or /inventories.json
  def create
    # fail
    
    inventory = Inventory.find_or_create_by(
      name: inventory_params[:name],
      category: inventory_params[:category],
      manufacturer: inventory_params[:manufacturer],
      prescription: inventory_params[:prescription],
      inventory_type: inventory_params[:inventory_type]
    ) do |inventory|
      inventory.inventory_items.new(
        quantity: inventory_params[:quantity],
        price: inventory_params[:price],
        expiration_date: inventory_params[:expiration_date]
      )
    end
  
    if inventory.save
      redirect_to inventory_index_path, notice: "Inventory was successfully created."
    else 
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /inventories/1 or /inventories/1.json
  def update
    respond_to do |format|
      if @inventory.update(inventory_params)
        format.html { redirect_to inventory_url(@inventory), notice: "Inventory was successfully updated." }
        format.json { render :show, status: :ok, location: @inventory }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventories/1 or /inventories/1.json
  def destroy
    # fail
    @inventory.destroy
    redirect_to inventory_index_path, notice: "Inventory was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventory
      @inventory = Inventory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def inventory_params
      params.require(:inventory).permit(
        :name,
        :category,
        :inventory_type,
        :dosage,
        :manufacturer,
        :prescription,
        :quantity,
        :price,
        :expiration_date
      )
    end

    def set_all_params_downcase
      inventory_params.each do |key, value|
        inventory_params[key] = value.downcase
      end
    end
end
