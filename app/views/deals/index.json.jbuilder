json.array!(@deals) do |deal|
  json.extract! deal, :id, :pb_product_id, :pb_member_id, :start_at, :end_at, :quantity, :price, :status, :description
  json.url deal_url(deal, format: :json)
end
