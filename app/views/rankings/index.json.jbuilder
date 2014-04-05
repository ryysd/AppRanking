json.array!(@rankings) do |json, feeds_ranking|
  feed = feeds_ranking[0]
  ranking = feeds_ranking[1]

  json.feed do
    json.extract! feed, :name, :code
  end
  json.ranking do
    unless ranking.nil?
      json.extract! ranking, :id, :updated_at

      json.app_items ranking.app_items do |app_json, app_item|
	app_json.extract! app_item, :id, :name, :local_id, :website_url, :icon, :banner_url

	app_json.reservation_information do |reservation_information_json|
	  unless app_item.reservation_information.nil?
	    reservation_information_json.extract! app_item.reservation_information, :released_on
	    reservation_information_json.bonus do |bonus_json|
	      bonus_json.extract! app_item.reservation_information.bonus, :image_url, :description unless app_item.reservation_information.bonus.nil?
	    end
	  end
	end
      end
    end
  end
end
