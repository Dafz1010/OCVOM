class InventoryItemsController < ApplicationController
    before_action :set_inventory_item, only: [:show, :edit, :update, :destroy]
    before_action :set_inventory, only: [:new, :create]

    
    def new 
        @inventory_item = @inventory.inventory_items.new
        @prescription_selection = AgeList.pluck(:name, :id) 
    end

    def create
        @inventory_item = @inventory.inventory_items.new(inventory_item_params)
        if @inventory_item.save
            @inventory_item.versions.create!(event: "Create Inventory Item", whodunnit: "#{current_user.username}")
            redirect_to inventory_index_path, notice: "Inventory Item was successfully created."
        else
            redirect_to new_inventory_item_path, alert: "Error: #{@inventory_item.errors.full_messages.join(', ')}"
        end
    end

    def destroy
        @inventory_item.archive
        @inventory_item.versions.create!(event: "Archive Inventory Item", whodunnit: "#{current_user.username}")
        redirect_to inventory_index_path, notice: "Inventory Item was successfully archived." 
    end
    private

    def inventory_item_params
        params.require(:inventory_item).permit(:quantity, :price, :expiration_date, :age_list_id)
    end

    def set_inventory_item
        @inventory_item = InventoryItem.find(params[:id])
    end

    def set_inventory
        @inventory = Inventory.find_by(id: params[:inventory_id])
        return redirect_to inventory_index_path, alert: "Error: Inventory not found." unless @inventory
    end
end
