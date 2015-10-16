json.array!(@ad_positions) do |ad_position|
  json.extract! ad_position, :id, :name, :description
  json.url ad_position_url(ad_position, format: :json)
end
