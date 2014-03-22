json.array!(@rankings) do |ranking|
  json.extract! ranking, :id
  json.url ranking_url(ranking, format: :json)
end
