json.extract! hotel, :id, :name, :description, :address, :owner, :rating, :created_at, :updated_at
json.url hotel_url(hotel, format: :json)
