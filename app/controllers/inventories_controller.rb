class InventoriesController < ApplicationController
  before_action :set_inventory, only: %i[ show edit update destroy ]

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
    @unique_types = Inventory.distinct.pluck(:type).compact
    @prescription_selection = Inventory::PRESCRIPTION_SELECTION
  end  

  # GET /inventories/1/edit
  def edit
  end

  # POST /inventories or /inventories.json
  def create
    inventory = Inventory.find_or_create_by(
      name: inventory_params[:name],
      category: inventory_params[:category],
      manufacturer: inventory_params[:manufacturer],
      prescription: inventory_params[:prescription]
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
    @inventory.destroy

    respond_to do |format|
      format.html { redirect_to inventories_url, notice: "Inventory was successfully destroyed." }
      format.json { head :no_content }
    end
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
        :type,
        :dosage,
        :manufacturer,
        :prescription,
        :quantity,
        :price,
        :expiration_date
      )
    end
end
