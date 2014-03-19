json.array!(@scaftests) do |scaftest|
  json.extract! scaftest, :id, :name, :int
  json.url scaftest_url(scaftest, format: :json)
end
