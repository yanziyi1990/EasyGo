json.array!(@orders) do |order|
  json.extract! order, :id, :order_number, :sku, :shipping_address, :latest_shipping_date, :order_status, :warehouse_status
  json.url order_url(order, format: :json)
end
