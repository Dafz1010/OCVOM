class InventoriesController < ApplicationController
  include Authentication
  before_action :set_inventory, only: %i[ show edit update destroy ]
  before_action :set_all_params_downcase, only: %i[ create update ]

  # GET /inventories or /inventories.json
  def index
    @inventories = Inventory.where(archived_at: nil).sort_by(&:created_at).reverse
  end

  # GET /inventories/1 or /inventories/1.json
  def show
    fail
  end

  # GET /inventories/new
  def new
    # inventory new merge with inventory item new
    @inventory = Inventory.new
    @inventory.inventory_items.build
    @unique_names = Inventory.distinct.pluck(:name).compact
    @unique_categories = Inventory.distinct.pluck(:category).compact
    @unique_inventory_types = Inventory.distinct.pluck(:inventory_type).compact
    @prescription_selection = AgeList.pluck(:name,:id).compact
  end  

  # GET /inventories/1/edit
  def edit
    fail
  end

  # POST /inventories or /inventories.json
  def create
    # inventory params except inventory items
    inv_params = inventory_params.except(:inventory_items)
    inventory = Inventory.new(inv_params)
    is_new = inventory.new_record? ? true : false
    item = inventory.inventory_items.new(inventory_params[:inventory_items])

    # binding.pry_remote
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
      redirect_to new_inventory_path, alert: "Error: #{inventory.errors.full_messages.join(', ')}"
    end
  end

  # PATCH/PUT /inventories/1 or /inventories/1.json
  def update
    redirect_to inventory_index_path, alert: "Cannot update inventory"
  end

  # DELETE /inventories/1 or /inventories/1.json
  def destroy
    @inventory.archive
    # @inventory.versions.create!(event: "Archive Inventory", whodunnit: "#{current_user.username}")
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
        :manufacturer,
        inventory_items: [
          :id,
          :quantity,
          :price,
          :expiration_date,
          :age_list_id,
        ])
    end

    def set_all_params_downcase
      params[:inventory][:name].downcase!
      params[:inventory][:category].downcase!
      params[:inventory][:inventory_type].downcase!
      params[:inventory][:manufacturer].downcase!
    end

    
end
