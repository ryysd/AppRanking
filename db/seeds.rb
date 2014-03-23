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
    {:id => '2', :market_id => '1', :code => 'application', :name => 'Applications'},
    {:id => '3', :market_id => '1', :code => 'game'       , :name => 'Games'},
    # Google Play Applications >
    {:id => '4', :market_id => '1', :code => 'books_and_reference', :name => 'Books & Reference', :category_id => '2'},
    {:id => '5', :market_id => '1', :code => 'business'           , :name => 'Business', :category_id => '2'},
    # Google Play Game >
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
    {:name => 'iPhone'},
    {:name => 'iPad'},
    {:name => 'mac'},
    {:name => 'android'},
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
