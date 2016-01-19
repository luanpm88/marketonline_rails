json.array!(@catgroups) do |catgroup|
  json.extract! catgroup, :id, :name, :cat_ids, :image
  json.url catgroup_url(catgroup, format: :json)
end
