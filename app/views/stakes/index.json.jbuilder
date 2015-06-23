json.array!(@stakes) do |stake|
  json.extract! stake, :id, :name, :region_id
  json.url stake_url(stake, format: :json)
end
