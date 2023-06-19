json.extract! sale, :id, :purchase_name, :item_description, :item_price, :purchase_count, :merchant_address, :merchant_name, :company_id, :created_at, :updated_at
json.url sale_url(sale, format: :json)
