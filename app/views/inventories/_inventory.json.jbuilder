json.extract! inventory, :id, :name, :quantity, :price, :description, :sku, :category, :manufacturer, :created_at, :updated_at
json.url inventory_url(inventory, format: :json)
