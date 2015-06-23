json.array!(@wards) do |ward|
  json.extract! ward, :id, :name, :stake_id
  json.url ward_url(ward, format: :json)
end
