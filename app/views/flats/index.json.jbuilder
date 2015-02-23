json.array!(@flats) do |flat|
  json.extract! flat, :id, :name, :description, :price, :street, :city, :country, :zipcode
  json.url flat_url(flat, format: :json)
end
