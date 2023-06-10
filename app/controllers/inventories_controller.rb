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
    inventory = Inventory.find_or_initialize_by(
      name: inventory_params[:name],
      category: inventory_params[:category],
      manufacturer: inventory_params[:manufacturer],
      prescription: inventory_params[:prescription],
      inventory_type: inventory_params[:inventory_type]
    )
    is_new = inventory.new_record? ? true : false
    
    item = inventory.inventory_items.new(
      quantity: inventory_params[:quantity],
      price: inventory_params[:price],
      expiration_date: inventory_params[:expiration_date]
    )
    
    
    if inventory.save && item.save
      if is_new
        inventory.versions.create!(event: "Create Inventory", whodunnit: "#{current_user.username}")
        notice = "Inventory and Item was successfully created."
      else
        notice = "Item was successfully created."
      end
      
      item.versions.create!(event: "Create Inventory Item", whodunnit: "#{current_user.username}")
      
      redirect_to inventory_index_path, notice: notice
    else 
      
      # flash now
      flash.now[:alert] = "Error: #{inventory.errors.full_messages.join(', ')}"
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
    @inventory.archive
    @inventory.versions.create!(event: "Archive Inventory", whodunnit: "#{current_user.username}")
    redirect_to inventory_index_path, notice: "Inventory was successfully archived."
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
