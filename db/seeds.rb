# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create_all(table, records) 
    table.delete_all
    records.each do |val|
	table.create val
    end
end

markets = [
    {:id => '1', :code => 'GP' , :name => 'Google Play'},
    {:id => '2', :code => 'ITC', :name => 'iTunes Connect'},
]
create_all Market, markets

categories = [
    # Google Play Categories
    {:id => '1', :market_id => '1', :code => ''           , :name => 'Overall'},
    {:id => '2', :market_id => '1', :code => 'application', :name => 'Applications', :category_id => '1'},
    {:id => '3', :market_id => '1', :code => 'game'       , :name => 'Games', :category_id => '1'},
    # Google Play Applications >
    {:id => '4' , :market_id => '1', :code => 'books_and_reference', :name => 'Books & Reference', :category_id => '2'},
    {:id => '5' , :market_id => '1', :code => 'business'           , :name => 'Business', :category_id => '2'},
    {:id => '6' , :market_id => '1', :code => 'comics'             , :name => 'Comics', :category_id => '2'},
    {:id => '7' , :market_id => '1', :code => 'communication'      , :name => 'Communication', :category_id => '2'},
    {:id => '8' , :market_id => '1', :code => 'education'          , :name => 'Education', :category_id => '2'},
    {:id => '9' , :market_id => '1', :code => 'entertainment'      , :name => 'Entertainment', :category_id => '2'},
    {:id => '10', :market_id => '1', :code => 'finance'            , :name => 'Finance', :category_id => '2'},
    {:id => '11', :market_id => '1', :code => 'health_and_fitness' , :name => 'Health & Fitness', :category_id => '2'},
    {:id => '12', :market_id => '1', :code => 'libraries_and_demo' , :name => 'Libraries & Demo', :category_id => '2'},
    {:id => '13', :market_id => '1', :code => 'lifestyle'          , :name => 'Lifestyle', :category_id => '2'},
    {:id => '14', :market_id => '1', :code => 'live_wallpaper'     , :name => 'Live Wallpaper', :category_id => '2'},
    {:id => '15', :market_id => '1', :code => 'media_and_video'    , :name => 'Media & Video', :category_id => '2'},
    {:id => '16', :market_id => '1', :code => 'medical'            , :name => 'Medical', :category_id => '2'},
    {:id => '17', :market_id => '1', :code => 'music_and_audio'    , :name => 'Music & Audio', :category_id => '2'},
    {:id => '18', :market_id => '1', :code => 'news_and_magazines' , :name => 'News & Magazines', :category_id => '2'},
    {:id => '19', :market_id => '1', :code => 'personalization'    , :name => 'Personalization', :category_id => '2'},
    {:id => '20', :market_id => '1', :code => 'photography'        , :name => 'Photography', :category_id => '2'},
    {:id => '21', :market_id => '1', :code => 'productively'       , :name => 'Productively', :category_id => '2'},
    {:id => '22', :market_id => '1', :code => 'shopping'           , :name => 'Shopping', :category_id => '2'},
    {:id => '23', :market_id => '1', :code => 'social'             , :name => 'Social', :category_id => '2'},
    {:id => '24', :market_id => '1', :code => 'sports'             , :name => 'Sports', :category_id => '2'},
    {:id => '25', :market_id => '1', :code => 'tools'              , :name => 'Tools', :category_id => '2'},
    {:id => '26', :market_id => '1', :code => 'transportation'     , :name => 'Transportation', :category_id => '2'},
    {:id => '27', :market_id => '1', :code => 'travel_and_local'   , :name => 'Travel & Local', :category_id => '2'},
    {:id => '28', :market_id => '1', :code => 'weather'            , :name => 'Weather', :category_id => '2'},
    {:id => '29', :market_id => '1', :code => 'widgets'            , :name => 'Widgets', :category_id => '2'},
    # Google Play Ga1e >
    {:id => '30', :market_id => '1', :code => '', :name => 'Games'         , :category_id => '3'},
    {:id => '31', :market_id => '1', :code => '', :name => 'Action'        , :category_id => '3'},
    {:id => '32', :market_id => '1', :code => '', :name => 'Adventure'     , :category_id => '3'},
    {:id => '33', :market_id => '1', :code => '', :name => 'Arcade'        , :category_id => '3'},
    {:id => '34', :market_id => '1', :code => '', :name => 'Board'         , :category_id => '3'},
    {:id => '35', :market_id => '1', :code => '', :name => 'Card'          , :category_id => '3'},
    {:id => '36', :market_id => '1', :code => '', :name => 'Casino'        , :category_id => '3'},
    {:id => '37', :market_id => '1', :code => '', :name => 'Casual'        , :category_id => '3'},
    {:id => '38', :market_id => '1', :code => '', :name => 'Educational'   , :category_id => '3'},
    {:id => '39', :market_id => '1', :code => '', :name => 'Family'        , :category_id => '3'},
    {:id => '40', :market_id => '1', :code => '', :name => 'Live Wallpaper', :category_id => '3'},
    {:id => '41', :market_id => '1', :code => '', :name => 'Music'         , :category_id => '3'},
    {:id => '42', :market_id => '1', :code => '', :name => 'Puzzle'        , :category_id => '3'},
    {:id => '43', :market_id => '1', :code => '', :name => 'Racing'        , :category_id => '3'},
    {:id => '44', :market_id => '1', :code => '', :name => 'Role Playing'  , :category_id => '3'},
    {:id => '45', :market_id => '1', :code => '', :name => 'Simulation'    , :category_id => '3'},
    {:id => '46', :market_id => '1', :code => '', :name => 'Sports'        , :category_id => '3'},
    {:id => '47', :market_id => '1', :code => '', :name => 'Strategy'      , :category_id => '3'},
    {:id => '48', :market_id => '1', :code => '', :name => 'Trivia'        , :category_id => '3'},
    {:id => '49', :market_id => '1', :code => '', :name => 'Widgets'       , :category_id => '3'},
    {:id => '50', :market_id => '1', :code => '', :name => 'Word'          , :category_id => '3'},
    # iOS Categories
]
create_all Category, categories

feeds = [
    # Google Play Feeds
    {:name => 'Free'    , :code => 'topselling_free'    , :market_id => '1'},
    {:name => 'Paid'    , :code => 'topselling_new_paid', :market_id => '1'},
    {:name => 'Grossing', :code => 'topgrossing'        , :market_id => '1'},
    {:name => 'New Free', :code => 'topselling_new_free', :market_id => '1'},
    {:name => 'New Paid', :code => 'topselling_new_paid', :market_id => '1'},
    # iOS Feeds
]
create_all Feed, feeds

devices = [
    {:name => 'android', :market_id => '1'},
    {:name => 'iPhone' , :market_id => '2'},
    {:name => 'iPad'   , :market_id => '2'},
    {:name => 'mac'    , :market_id => '2'},
]
create_all Device, devices

countries = [
    {:code => 'US', :name => 'United States'},
    {:code => 'JP', :name => 'Japan'}
]
create_all Country, countries

languages = [
    {:id => '1', :code => 'EN', :name => 'English' , :country_id => '1'},
    {:id => '2', :code => 'JA', :name => 'Japanese', :country_id => '2'},
]
create_all Language, languages

currencies = [
    {:code => 'USD', :symbol => '$', :name => 'United States Dollar', :country_id => '1'},
    {:code => 'JPY', :symbol => '(J\(B', :name => 'Japanese Yen'        , :country_id => '2'}
]
create_all Currency, currencies
