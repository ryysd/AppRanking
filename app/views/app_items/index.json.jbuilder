json.array!(@app_items) do |app_item|
  json.extract! app_item, :id
  json.url app_item_url(app_item, format: :json)
end
