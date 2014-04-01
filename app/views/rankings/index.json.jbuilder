json.array!(@rankings) do |json, feeds_ranking|
  feed = feeds_ranking[0]
  ranking = feeds_ranking[1]

  json.extract! feed, :name, :code
  json.ranking do
    unless ranking.nil?
      json.extract! ranking, :id, :updated_at
      json.app_items ranking.app_items, :id, :name, :local_id, :icon
    end
  end
end
