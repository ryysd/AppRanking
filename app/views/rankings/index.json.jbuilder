json.array!(@rankings) do |json, feeds_ranking|
  feed = feeds_ranking[0]
  ranking = feeds_ranking[1]

  json.feed do
    json.extract! feed, :name, :code
  end
  json.ranking do
    unless ranking.nil?
      json.extract! ranking, :id, :updated_at
      json.app_items ranking.app_items, :id, :name, :local_id, :website_url, :icon, :banner_url
    end
  end
end
