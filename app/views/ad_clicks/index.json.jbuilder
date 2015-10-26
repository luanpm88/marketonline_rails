json.array!(@ad_clicks) do |ad_click|
  json.extract! ad_click, :id, :ad_id, :customer_code, :ip
  json.url ad_click_url(ad_click, format: :json)
end
