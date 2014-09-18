json.array!(@delivery_men) do |delivery_man|
  json.extract! delivery_man, :id
  json.url delivery_man_url(delivery_man, format: :json)
end
