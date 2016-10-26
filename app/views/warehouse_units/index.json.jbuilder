json.array!(@warehouse_units) do |warehouse_unit|
  json.extract! warehouse_unit, :id, :name, :sku, :count, :status
  json.url warehouse_unit_url(warehouse_unit, format: :json)
end
