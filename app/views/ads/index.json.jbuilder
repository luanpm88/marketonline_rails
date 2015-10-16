json.array!(@ads) do |ad|
  json.extract! ad, :id, :name, :description, :ad_type_id, :url, :image, :user_id, :status
  json.url ad_url(ad, format: :json)
end
