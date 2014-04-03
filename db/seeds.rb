# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create_all(table, records) 
  table.delete_all
  records.each do |record|
    table.create record
  end
end

markets = [
    {:id => '1', :code => 'GP' , :name => 'Google Play'},
    {:id => '2', :code => 'ITC', :name => 'iTunes Connect'},
    {:id => '3', :code => 'RSV', :name => 'Reservation'},
]
create_all Market, markets

categories = [
    # Google Play Categories
    {:id => '1', :market_id => '1', :code => 'overall'    , :name => 'Overall'},
    {:id => '2', :market_id => '1', :code => 'application', :name => 'Applications', :category_id => '1'},
    {:id => '3', :market_id => '1', :code => 'game'       , :name => 'Games', :category_id => '1'},
    # Google Play Applications >
    {:id => '10' , :market_id => '1', :code => 'books_and_reference', :name => 'Books & Reference', :category_id => '2'},
    {:id => '11' , :market_id => '1', :code => 'business'           , :name => 'Business', :category_id => '2'},
    {:id => '12' , :market_id => '1', :code => 'comics'             , :name => 'Comics', :category_id => '2'},
    {:id => '13' , :market_id => '1', :code => 'communication'      , :name => 'Communication', :category_id => '2'},
    {:id => '14' , :market_id => '1', :code => 'education'          , :name => 'Education', :category_id => '2'},
    {:id => '15' , :market_id => '1', :code => 'entertainment'      , :name => 'Entertainment', :category_id => '2'},
    {:id => '16', :market_id => '1', :code => 'finance'            , :name => 'Finance', :category_id => '2'},
    {:id => '17', :market_id => '1', :code => 'health_and_fitness' , :name => 'Health & Fitness', :category_id => '2'},
    {:id => '18', :market_id => '1', :code => 'libraries_and_demo' , :name => 'Libraries & Demo', :category_id => '2'},
    {:id => '19', :market_id => '1', :code => 'lifestyle'          , :name => 'Lifestyle', :category_id => '2'},
    {:id => '20', :market_id => '1', :code => 'live_wallpaper'     , :name => 'Live Wallpaper', :category_id => '2'},
    {:id => '21', :market_id => '1', :code => 'media_and_video'    , :name => 'Media & Video', :category_id => '2'},
    {:id => '22', :market_id => '1', :code => 'medical'            , :name => 'Medical', :category_id => '2'},
    {:id => '23', :market_id => '1', :code => 'music_and_audio'    , :name => 'Music & Audio', :category_id => '2'},
    {:id => '24', :market_id => '1', :code => 'news_and_magazines' , :name => 'News & Magazines', :category_id => '2'},
    {:id => '25', :market_id => '1', :code => 'personalization'    , :name => 'Personalization', :category_id => '2'},
    {:id => '26', :market_id => '1', :code => 'photography'        , :name => 'Photography', :category_id => '2'},
    {:id => '27', :market_id => '1', :code => 'productively'       , :name => 'Productivity', :category_id => '2'},
    {:id => '28', :market_id => '1', :code => 'shopping'           , :name => 'Shopping', :category_id => '2'},
    {:id => '29', :market_id => '1', :code => 'social'             , :name => 'Social', :category_id => '2'},
    {:id => '30', :market_id => '1', :code => 'sports'             , :name => 'Sports', :category_id => '2'},
    {:id => '31', :market_id => '1', :code => 'tools'              , :name => 'Tools', :category_id => '2'},
    {:id => '32', :market_id => '1', :code => 'transportation'     , :name => 'Transportation', :category_id => '2'},
    {:id => '33', :market_id => '1', :code => 'travel_and_local'   , :name => 'Travel & Local', :category_id => '2'},
    {:id => '34', :market_id => '1', :code => 'weather'            , :name => 'Weather', :category_id => '2'},
    {:id => '35', :market_id => '1', :code => 'widgets'            , :name => 'Widgets', :category_id => '2'},
    # Google Play Games >
    {:id => '50', :market_id => '1', :code => 'action'        , :name => 'Action'        , :category_id => '3'},
    {:id => '51', :market_id => '1', :code => 'adventure'     , :name => 'Adventure'     , :category_id => '3'},
    {:id => '52', :market_id => '1', :code => 'arcade'        , :name => 'Arcade'        , :category_id => '3'},
    {:id => '53', :market_id => '1', :code => 'board'         , :name => 'Board'         , :category_id => '3'},
    {:id => '54', :market_id => '1', :code => 'card'          , :name => 'Card'          , :category_id => '3'},
    {:id => '55', :market_id => '1', :code => 'casino'        , :name => 'Casino'        , :category_id => '3'},
    {:id => '56', :market_id => '1', :code => 'casual'        , :name => 'Casual'        , :category_id => '3'},
    {:id => '57', :market_id => '1', :code => 'educational'   , :name => 'Educational'   , :category_id => '3'},
    {:id => '58', :market_id => '1', :code => 'family'        , :name => 'Family'        , :category_id => '3'},
    {:id => '59', :market_id => '1', :code => 'live_wallpaper', :name => 'Live Wallpaper', :category_id => '3'},
    {:id => '60', :market_id => '1', :code => 'music'         , :name => 'Music'         , :category_id => '3'},
    {:id => '61', :market_id => '1', :code => 'puzzle'        , :name => 'Puzzle'        , :category_id => '3'},
    {:id => '62', :market_id => '1', :code => 'racing'        , :name => 'Racing'        , :category_id => '3'},
    {:id => '63', :market_id => '1', :code => 'role_playing'  , :name => 'Role Playing'  , :category_id => '3'},
    {:id => '64', :market_id => '1', :code => 'simulation'    , :name => 'Simulation'    , :category_id => '3'},
    {:id => '65', :market_id => '1', :code => 'sports'        , :name => 'Sports'        , :category_id => '3'},
    {:id => '66', :market_id => '1', :code => 'strategy'      , :name => 'Strategy'      , :category_id => '3'},
    {:id => '67', :market_id => '1', :code => 'trivia'        , :name => 'Trivia'        , :category_id => '3'},
    {:id => '68', :market_id => '1', :code => 'widgets'       , :name => 'Widgets'       , :category_id => '3'},
    {:id => '69', :market_id => '1', :code => 'word'          , :name => 'Word'          , :category_id => '3'},
    # iOS Categories
    {:id => '100', :market_id => '2', :code => '0000', :name => 'All'},
    {:id => '101', :market_id => '2', :code => '6018', :name => 'Book'             , :category_id => '100'},
    {:id => '102', :market_id => '2', :code => '6000', :name => 'Business'         , :category_id => '100'},
    {:id => '103', :market_id => '2', :code => '6017', :name => 'Education'        , :category_id => '100'},
    {:id => '104', :market_id => '2', :code => '6016', :name => 'Entertainment'    , :category_id => '100'},
    {:id => '105', :market_id => '2', :code => '6015', :name => 'Finance'          , :category_id => '100'},
    {:id => '106', :market_id => '2', :code => '6023', :name => 'Food & Drink'     , :category_id => '100'},
    {:id => '107', :market_id => '2', :code => '6014', :name => 'Games'            , :category_id => '100'},
    {:id => '108', :market_id => '2', :code => '6013', :name => 'Health & Fitness' , :category_id => '100'},
    {:id => '109', :market_id => '2', :code => '6012', :name => 'Lifestyle'        , :category_id => '100'},
    {:id => '110', :market_id => '2', :code => '6020', :name => 'Medical'          , :category_id => '100'},
    {:id => '111', :market_id => '2', :code => '6011', :name => 'Music'            , :category_id => '100'},
    {:id => '112', :market_id => '2', :code => '6010', :name => 'Navigation'       , :category_id => '100'},
    {:id => '113', :market_id => '2', :code => '6009', :name => 'News'             , :category_id => '100'},
    {:id => '114', :market_id => '2', :code => '6021', :name => 'Newsstand'        , :category_id => '100'},
    {:id => '115', :market_id => '2', :code => '6008', :name => 'Photo & Video'    , :category_id => '100'},
    {:id => '116', :market_id => '2', :code => '6007', :name => 'Productivity'     , :category_id => '100'},
    {:id => '117', :market_id => '2', :code => '6006', :name => 'Reference'        , :category_id => '100'},
    {:id => '118', :market_id => '2', :code => '6005', :name => 'Social Networking', :category_id => '100'},
    {:id => '119', :market_id => '2', :code => '6004', :name => 'Sports'           , :category_id => '100'},
    {:id => '120', :market_id => '2', :code => '6003', :name => 'Travel'           , :category_id => '100'},
    {:id => '121', :market_id => '2', :code => '6002', :name => 'Utilities'        , :category_id => '100'},
    {:id => '122', :market_id => '2', :code => '6001', :name => 'Weather'          , :category_id => '100'},
    {:id => '123', :market_id => '2', :code => '6022', :name => 'Catalogs'         , :category_id => '100'},
    # Reservation Categories
    {:id => '150', :market_id => '3', :code => 'overall', :name => 'Overall'},
]
create_all Category, categories

feeds = [
    # Google Play Feeds
    {:id => '1', :name => 'Free'    , :code => 'topselling_free'    , :market_id => '1'},
    {:id => '2', :name => 'Paid'    , :code => 'topselling_paid'    , :market_id => '1'},
    {:id => '3', :name => 'Grossing', :code => 'topgrossing'        , :market_id => '1'},
    {:id => '4', :name => 'New Free', :code => 'topselling_new_free', :market_id => '1'},
    {:id => '5', :name => 'New Paid', :code => 'topselling_new_paid', :market_id => '1'},
    # iOS Feeds
    {:id => '6',:name => 'Free'    , :code => 'topfreeapplications'    , :market_id => '2'},
    {:id => '7',:name => 'Paid'    , :code => 'toppaidapplications'    , :market_id => '2'},
    {:id => '8',:name => 'Grossing', :code => 'topgrossingapplications', :market_id => '2'},
    {:id => '9',:name => 'New Free', :code => 'newfreeapplications'    , :market_id => '2'},
    {:id => '10',:name => 'New Paid', :code => 'newpaidapplications'    , :market_id => '2'},
    # Reservation Feeds
    {:id => '11',:name => 'Daily'    , :code => 'daily'    , :market_id => '3'},
    {:id => '12',:name => 'Total'    , :code => 'total'    , :market_id => '3'},
    {:id => '13',:name => 'New'      , :code => 'new'      , :market_id => '3'},
]
create_all Feed, feeds

os_types = [
    {:id => '1', :name => 'android'},
    {:id => '2', :name => 'iOS'},
]
create_all OsType, os_types

devices = [
    {:id => '1', :code => 'android', :name => 'android', :market_id => '1', :os_type_id => '1'},
    {:id => '2', :code => 'iphone', :name => 'iPhone' , :market_id => '2', :os_type_id => '2'},
    {:id => '3', :code => 'ipad', :name => 'iPad'   , :market_id => '2', :os_type_id => '2'},
    {:id => '4', :code => 'mac', :name => 'mac'    , :market_id => '2', :os_type_id => '2'},
    # debug
    {:id => '5', :code => 'rsv_android', :name => 'android' , :market_id => '3', :os_type_id => '1'},
    {:id => '6', :code => 'rsv_iphone', :name => 'iPhone'  , :market_id => '3', :os_type_id => '2'},
]
create_all Device, devices

countries = [
  {:id => '1'  , :is_popular => '0', :code => 'AC', :name => 'Ascension Island'},
  {:id => '2'  , :is_popular => '0', :code => 'AD', :name => 'Andorra'},
  {:id => '3'  , :is_popular => '0', :code => 'AE', :name => 'United Arab Emirates'},
  {:id => '4'  , :is_popular => '0', :code => 'AF', :name => 'Afghanistan'},
  {:id => '5'  , :is_popular => '0', :code => 'AG', :name => 'Antigua And Barbuda'},
  {:id => '6'  , :is_popular => '0', :code => 'AI', :name => 'Anguilla'},
  {:id => '7'  , :is_popular => '0', :code => 'AL', :name => 'Albania'},
  {:id => '8'  , :is_popular => '0', :code => 'AM', :name => 'Armenia'},
  {:id => '9'  , :is_popular => '0', :code => 'AN', :name => 'Netherlands Antilles'},
  {:id => '10'  , :is_popular => '0', :code => 'AO', :name => 'Angola'},
  {:id => '11' , :is_popular => '0', :code => 'AP', :name => 'Asia Pacific'},
  {:id => '12' , :is_popular => '0', :code => 'AQ', :name => 'Antarctica'},
  {:id => '13' , :is_popular => '0', :code => 'AR', :name => 'Argentina'},
  {:id => '14' , :is_popular => '0', :code => 'AS', :name => 'American Samoa'},
  {:id => '15' , :is_popular => '0', :code => 'AT', :name => 'Austria'},
  {:id => '16' , :is_popular => '0', :code => 'AU', :name => 'Australia'},
  {:id => '17' , :is_popular => '0', :code => 'AW', :name => 'Aruba'},
  {:id => '18' , :is_popular => '0', :code => 'AZ', :name => 'Azerbaijan'},
  {:id => '19' , :is_popular => '0', :code => 'BA', :name => 'Bosnia And Herzegowina'},
  {:id => '20' , :is_popular => '0', :code => 'BB', :name => 'Barbados'},
  {:id => '21' , :is_popular => '0', :code => 'BD', :name => 'Bangladesh'},
  {:id => '22' , :is_popular => '0', :code => 'BE', :name => 'Belgium'},
  {:id => '23' , :is_popular => '0', :code => 'BF', :name => 'Burkina Faso'},
  {:id => '24' , :is_popular => '0', :code => 'BG', :name => 'Bulgaria'},
  {:id => '25' , :is_popular => '0', :code => 'BH', :name => 'Bahrain'},
  {:id => '26' , :is_popular => '0', :code => 'BI', :name => 'Burundi'},
  {:id => '27' , :is_popular => '0', :code => 'BJ', :name => 'Benin'},
  {:id => '28' , :is_popular => '0', :code => 'BM', :name => 'Bermuda'},
  {:id => '29' , :is_popular => '0', :code => 'BN', :name => 'Brunei Darussalam'},
  {:id => '30' , :is_popular => '0', :code => 'BO', :name => 'Bolivia'},
  {:id => '31' , :is_popular => '0', :code => 'BR', :name => 'Brazil'},
  {:id => '32' , :is_popular => '0', :code => 'BS', :name => 'Bahamas'},
  {:id => '33' , :is_popular => '0', :code => 'BT', :name => 'Bhutan'},
  {:id => '34' , :is_popular => '0', :code => 'BV', :name => 'Bouvet Island'},
  {:id => '35' , :is_popular => '0', :code => 'BW', :name => 'Botswana'},
  {:id => '36' , :is_popular => '0', :code => 'BY', :name => 'Belarus'},
  {:id => '37' , :is_popular => '0', :code => 'BZ', :name => 'Belize'},
  {:id => '38' , :is_popular => '1', :code => 'CA', :name => 'Canada'},
  {:id => '39' , :is_popular => '0', :code => 'CC', :name => 'Cocos (Keeling) Islands'},
  {:id => '40' , :is_popular => '0', :code => 'CF', :name => 'Central African Republic'},
  {:id => '41' , :is_popular => '0', :code => 'CG', :name => 'Congo'},
  {:id => '42' , :is_popular => '0', :code => 'CH', :name => 'Switzerland'},
  {:id => '43' , :is_popular => '0', :code => 'CK', :name => 'Cook Islands'},
  {:id => '44' , :is_popular => '0', :code => 'CL', :name => 'Chile'},
  {:id => '45' , :is_popular => '0', :code => 'CM', :name => 'Cameroon'},
  {:id => '46' , :is_popular => '0', :code => 'CN', :name => 'China'},
  {:id => '47' , :is_popular => '0', :code => 'CO', :name => 'Colombia'},
  {:id => '48' , :is_popular => '0', :code => 'CR', :name => 'Costa Rica'},
  {:id => '49' , :is_popular => '0', :code => 'CS', :name => 'Czechoslovakia (former)'},
  {:id => '50' , :is_popular => '0', :code => 'CU', :name => 'Cuba'},
  {:id => '51' , :is_popular => '0', :code => 'CV', :name => 'Cape Verde'},
  {:id => '52' , :is_popular => '0', :code => 'CX', :name => 'Christmas Island'},
  {:id => '53' , :is_popular => '0', :code => 'CY', :name => 'Cyprus'},
  {:id => '54' , :is_popular => '0', :code => 'CZ', :name => 'Czech Republic'},
  {:id => '55' , :is_popular => '1', :code => 'DE', :name => 'Germany'},
  {:id => '56' , :is_popular => '0', :code => 'DJ', :name => 'Djibouti'},
  {:id => '57' , :is_popular => '0', :code => 'DK', :name => 'Denmark'},
  {:id => '58' , :is_popular => '0', :code => 'DM', :name => 'Dominica'},
  {:id => '59' , :is_popular => '0', :code => 'DO', :name => 'Dominican Republic'},
  {:id => '60' , :is_popular => '0', :code => 'DZ', :name => 'Algeria'},
  {:id => '61' , :is_popular => '0', :code => 'EC', :name => 'Ecuador'},
  {:id => '62' , :is_popular => '0', :code => 'EE', :name => 'Estonia'},
  {:id => '63' , :is_popular => '0', :code => 'EG', :name => 'Egypt'},
  {:id => '64' , :is_popular => '0', :code => 'EH', :name => 'Western Sahara'},
  {:id => '65' , :is_popular => '0', :code => 'ER', :name => 'Eritrea'},
  {:id => '66' , :is_popular => '0', :code => 'ES', :name => 'Spain'},
  {:id => '67' , :is_popular => '0', :code => 'ET', :name => 'Ethiopia'},
  {:id => '68' , :is_popular => '0', :code => 'EU', :name => 'EU'},
  {:id => '69' , :is_popular => '0', :code => 'FI', :name => 'Finland'},
  {:id => '70' , :is_popular => '0', :code => 'FJ', :name => 'Fiji'},
  {:id => '71' , :is_popular => '0', :code => 'FK', :name => 'Falkland Islands (Malvinas)'},
  {:id => '72' , :is_popular => '0', :code => 'FM', :name => 'Micronesia, Federated States Of'},
  {:id => '73' , :is_popular => '0', :code => 'FO', :name => 'Faroe Islands'},
  {:id => '74' , :is_popular => '1', :code => 'FR', :name => 'France'},
  {:id => '75' , :is_popular => '0', :code => 'FX', :name => 'France, Metropolitan'},
  {:id => '76' , :is_popular => '0', :code => 'GA', :name => 'Gabon'},
  {:id => '77' , :is_popular => '0', :code => 'GB', :name => 'Great Britain(United Kingdom)'},
  {:id => '78' , :is_popular => '0', :code => 'GD', :name => 'Grenada'},
  {:id => '79' , :is_popular => '0', :code => 'GE', :name => 'Georgia'},
  {:id => '80' , :is_popular => '0', :code => 'GF', :name => 'French Guiana'},
  {:id => '81' , :is_popular => '0', :code => 'GH', :name => 'Ghana'},
  {:id => '82' , :is_popular => '0', :code => 'GI', :name => 'Gibraltar'},
  {:id => '83' , :is_popular => '0', :code => 'GL', :name => 'Greenland'},
  {:id => '84' , :is_popular => '0', :code => 'GM', :name => 'Gambia'},
  {:id => '85' , :is_popular => '0', :code => 'GN', :name => 'Guinea'},
  {:id => '86' , :is_popular => '0', :code => 'GP', :name => 'Guadeloupe'},
  {:id => '87' , :is_popular => '0', :code => 'GQ', :name => 'Equatorial Guinea'},
  {:id => '88' , :is_popular => '0', :code => 'GR', :name => 'Greece'},
  {:id => '89' , :is_popular => '0', :code => 'GS', :name => 'South Georgia And The South Sandwich Islands'},
  {:id => '90' , :is_popular => '0', :code => 'GT', :name => 'Guatemala'},
  {:id => '91' , :is_popular => '0', :code => 'GU', :name => 'Guam'},
  {:id => '92' , :is_popular => '0', :code => 'GW', :name => 'Guinea-Bissau'},
  {:id => '93' , :is_popular => '0', :code => 'GY', :name => 'Guyana'},
  {:id => '94' , :is_popular => '0', :code => 'HK', :name => 'Hong Kong'},
  {:id => '95' , :is_popular => '0', :code => 'HM', :name => 'Heard And Mc Donald Islands'},
  {:id => '96' , :is_popular => '0', :code => 'HN', :name => 'Honduras'},
  {:id => '97' , :is_popular => '0', :code => 'HR', :name => 'Croatia (Hrvatska)'},
  {:id => '98' , :is_popular => '0', :code => 'HT', :name => 'Haiti'},
  {:id => '99' , :is_popular => '0', :code => 'HU', :name => 'Hungary'},
  {:id => '100' , :is_popular => '0', :code => 'ID', :name => 'Indonesia'},
  {:id => '101', :is_popular => '0', :code => 'IE', :name => 'Ireland'},
  {:id => '102', :is_popular => '0', :code => 'IL', :name => 'Israel'},
  {:id => '103', :is_popular => '0', :code => 'IN', :name => 'India'},
  {:id => '104', :is_popular => '0', :code => 'IO', :name => 'British Indian Ocean Territory'},
  {:id => '105', :is_popular => '0', :code => 'IQ', :name => 'Iraq'},
  {:id => '106', :is_popular => '0', :code => 'IR', :name => 'Iran (Islamic Republic Of)'},
  {:id => '107', :is_popular => '0', :code => 'IS', :name => 'Iceland'},
  {:id => '108', :is_popular => '1', :code => 'IT', :name => 'Italy'},
  {:id => '109', :is_popular => '0', :code => 'JM', :name => 'Jamaica'},
  {:id => '110', :is_popular => '0', :code => 'JO', :name => 'Jordan'},
  {:id => '111', :is_popular => '1', :code => 'JP', :name => 'Japan'},
  {:id => '112', :is_popular => '0', :code => 'KE', :name => 'Kenya'},
  {:id => '113', :is_popular => '0', :code => 'KG', :name => 'Kyrgyzstan'},
  {:id => '114', :is_popular => '0', :code => 'KH', :name => 'Cambodia'},
  {:id => '115', :is_popular => '0', :code => 'KI', :name => 'Kiribati'},
  {:id => '116', :is_popular => '0', :code => 'KM', :name => 'Comoros'},
  {:id => '117', :is_popular => '0', :code => 'KN', :name => 'Saint Kitts And Nevis'},
  {:id => '118', :is_popular => '0', :code => 'KP', :name => 'Korea(North)'},
  {:id => '119', :is_popular => '0', :code => 'KR', :name => 'Korea, Republic Of'},
  {:id => '120', :is_popular => '0', :code => 'KW', :name => 'Kuwait'},
  {:id => '121', :is_popular => '0', :code => 'KY', :name => 'Cayman Islands'},
  {:id => '122', :is_popular => '0', :code => 'KZ', :name => 'Kazakhstan'},
  {:id => '123', :is_popular => '0', :code => 'LA', :name => 'Laos'},
  {:id => '124', :is_popular => '0', :code => 'LB', :name => 'Lebanon'},
  {:id => '125', :is_popular => '0', :code => 'LC', :name => 'Saint Lucia'},
  {:id => '126', :is_popular => '0', :code => 'LI', :name => 'Liechtenstein'},
  {:id => '127', :is_popular => '0', :code => 'LK', :name => 'Sri Lanka'},
  {:id => '128', :is_popular => '0', :code => 'LR', :name => 'Liberia'},
  {:id => '129', :is_popular => '0', :code => 'LS', :name => 'Lesotho'},
  {:id => '130', :is_popular => '0', :code => 'LT', :name => 'Lithuania'},
  {:id => '131', :is_popular => '0', :code => 'LU', :name => 'Luxembourg'},
  {:id => '132', :is_popular => '0', :code => 'LV', :name => 'Latvia'},
  {:id => '133', :is_popular => '0', :code => 'LY', :name => 'Libyan Arab Jamahiriya'},
  {:id => '134', :is_popular => '0', :code => 'MA', :name => 'Morocco'},
  {:id => '135', :is_popular => '0', :code => 'MC', :name => 'Monaco'},
  {:id => '136', :is_popular => '0', :code => 'MD', :name => 'Moldova, Republic Of'},
  {:id => '137', :is_popular => '0', :code => 'ME', :name => 'Montenegro'},
  {:id => '138', :is_popular => '0', :code => 'MG', :name => 'Madagascar'},
  {:id => '139', :is_popular => '0', :code => 'MH', :name => 'Marshall Islands'},
  {:id => '140', :is_popular => '0', :code => 'MK', :name => 'Macedonia, The Former Yugoslav Republic Of'},
  {:id => '141', :is_popular => '0', :code => 'ML', :name => 'Mali'},
  {:id => '142', :is_popular => '0', :code => 'MM', :name => 'Myanmar'},
  {:id => '143', :is_popular => '0', :code => 'MN', :name => 'Mongolia'},
  {:id => '144', :is_popular => '0', :code => 'MO', :name => 'Macau'},
  {:id => '145', :is_popular => '0', :code => 'MP', :name => 'Northern Mariana Islands'},
  {:id => '146', :is_popular => '0', :code => 'MQ', :name => 'Martinique'},
  {:id => '147', :is_popular => '0', :code => 'MR', :name => 'Mauritania'},
  {:id => '148', :is_popular => '0', :code => 'MS', :name => 'Montserrat'},
  {:id => '149', :is_popular => '0', :code => 'MT', :name => 'Malta'},
  {:id => '150', :is_popular => '0', :code => 'MU', :name => 'Mauritius'},
  {:id => '151', :is_popular => '0', :code => 'MV', :name => 'Maldives'},
  {:id => '152', :is_popular => '0', :code => 'MW', :name => 'Malawi'},
  {:id => '153', :is_popular => '0', :code => 'MX', :name => 'Mexico'},
  {:id => '154', :is_popular => '0', :code => 'MY', :name => 'Malaysia'},
  {:id => '155', :is_popular => '0', :code => 'MZ', :name => 'Mozambique'},
  {:id => '156', :is_popular => '0', :code => 'NA', :name => 'Namibia'},
  {:id => '157', :is_popular => '0', :code => 'NC', :name => 'New Caledonia'},
  {:id => '158', :is_popular => '0', :code => 'NE', :name => 'Niger'},
  {:id => '159', :is_popular => '0', :code => 'NF', :name => 'Norfolk Island'},
  {:id => '160', :is_popular => '0', :code => 'NG', :name => 'Nigeria'},
  {:id => '161', :is_popular => '0', :code => 'NI', :name => 'Nicaragua'},
  {:id => '162', :is_popular => '0', :code => 'NL', :name => 'Netherlands'},
  {:id => '163', :is_popular => '0', :code => 'NO', :name => 'Norway'},
  {:id => '164', :is_popular => '0', :code => 'NP', :name => 'Nepal'},
  {:id => '165', :is_popular => '0', :code => 'NR', :name => 'Nauru'},
  {:id => '166', :is_popular => '0', :code => 'NT', :name => 'Neutral Zone'},
  {:id => '167', :is_popular => '0', :code => 'NU', :name => 'Niue'},
  {:id => '168', :is_popular => '0', :code => 'NZ', :name => 'New Zealand'},
  {:id => '169', :is_popular => '0', :code => 'OM', :name => 'Oman'},
  {:id => '170', :is_popular => '0', :code => 'PA', :name => 'Panama'},
  {:id => '171', :is_popular => '0', :code => 'PE', :name => 'Peru'},
  {:id => '172', :is_popular => '0', :code => 'PF', :name => 'French Polynesia'},
  {:id => '173', :is_popular => '0', :code => 'PG', :name => 'Papua New Guinea'},
  {:id => '174', :is_popular => '0', :code => 'PH', :name => 'Philippines'},
  {:id => '175', :is_popular => '0', :code => 'PK', :name => 'Pakistan'},
  {:id => '176', :is_popular => '0', :code => 'PL', :name => 'Poland'},
  {:id => '177', :is_popular => '0', :code => 'PM', :name => 'St. Pierre And Miquelon'},
  {:id => '178', :is_popular => '0', :code => 'PN', :name => 'Pitcairn'},
  {:id => '179', :is_popular => '0', :code => 'PR', :name => 'Puerto Rico'},
  {:id => '180', :is_popular => '0', :code => 'PS', :name => 'Palestina'},
  {:id => '181', :is_popular => '0', :code => 'PT', :name => 'Portugal'},
  {:id => '182', :is_popular => '0', :code => 'PW', :name => 'Palau'},
  {:id => '183', :is_popular => '0', :code => 'PY', :name => 'Paraguay'},
  {:id => '184', :is_popular => '0', :code => 'QA', :name => 'Qatar'},
  {:id => '185', :is_popular => '0', :code => 'RE', :name => 'Reunion'},
  {:id => '186', :is_popular => '0', :code => 'RO', :name => 'Romania'},
  {:id => '187', :is_popular => '0', :code => 'RS', :name => 'Serbia'},
  {:id => '188', :is_popular => '0', :code => 'RU', :name => 'Russian Federation'},
  {:id => '189', :is_popular => '0', :code => 'RW', :name => 'Rwanda'},
  {:id => '190', :is_popular => '0', :code => 'SA', :name => 'Saudi Arabia'},
  {:id => '191', :is_popular => '0', :code => 'SB', :name => 'Solomon Islands'},
  {:id => '192', :is_popular => '0', :code => 'SC', :name => 'Seychelles'},
  {:id => '193', :is_popular => '0', :code => 'SD', :name => 'Sudan'},
  {:id => '194', :is_popular => '0', :code => 'SE', :name => 'Sweden'},
  {:id => '195', :is_popular => '0', :code => 'SG', :name => 'Singapore'},
  {:id => '196', :is_popular => '0', :code => 'SH', :name => 'St. Helena'},
  {:id => '197', :is_popular => '0', :code => 'SI', :name => 'Slovenia'},
  {:id => '198', :is_popular => '0', :code => 'SJ', :name => 'Svalbard And Jan Mayen Islands'},
  {:id => '199', :is_popular => '0', :code => 'SK', :name => 'Slovakia (Slovak Republic)'},
  {:id => '200', :is_popular => '0', :code => 'SL', :name => 'Sierra Leone'},
  {:id => '201', :is_popular => '0', :code => 'SM', :name => 'San Marino'},
  {:id => '202', :is_popular => '0', :code => 'SN', :name => 'Senegal'},
  {:id => '203', :is_popular => '0', :code => 'SO', :name => 'Somalia'},
  {:id => '204', :is_popular => '0', :code => 'SR', :name => 'Suriname'},
  {:id => '205', :is_popular => '0', :code => 'ST', :name => 'Sao Tome And Principe'},
  {:id => '206', :is_popular => '0', :code => 'SU', :name => 'USSR (former)'},
  {:id => '207', :is_popular => '0', :code => 'SV', :name => 'El Salvador'},
  {:id => '208', :is_popular => '0', :code => 'SY', :name => 'Syrian Arab Republic'},
  {:id => '209', :is_popular => '0', :code => 'SZ', :name => 'Swaziland'},
  {:id => '210', :is_popular => '0', :code => 'TC', :name => 'Turks And Caicos Islands'},
  {:id => '211', :is_popular => '0', :code => 'TD', :name => 'Chad'},
  {:id => '212', :is_popular => '0', :code => 'TF', :name => 'French Southern Territories'},
  {:id => '213', :is_popular => '0', :code => 'TG', :name => 'Togo'},
  {:id => '214', :is_popular => '0', :code => 'TH', :name => 'Thailand'},
  {:id => '215', :is_popular => '0', :code => 'TJ', :name => 'Tajikistan'},
  {:id => '216', :is_popular => '0', :code => 'TK', :name => 'Tokelau'},
  {:id => '217', :is_popular => '0', :code => 'TM', :name => 'Turkmenistan'},
  {:id => '218', :is_popular => '0', :code => 'TN', :name => 'Tunisia'},
  {:id => '219', :is_popular => '0', :code => 'TO', :name => 'Tonga'},
  {:id => '220', :is_popular => '0', :code => 'TP', :name => 'East Timor'},
  {:id => '221', :is_popular => '0', :code => 'TR', :name => 'Turkey'},
  {:id => '222', :is_popular => '0', :code => 'TT', :name => 'Trinidad And Tobago'},
  {:id => '223', :is_popular => '0', :code => 'TV', :name => 'Tuvalu'},
  {:id => '224', :is_popular => '0', :code => 'TW', :name => 'Taiwan, Province Of China'},
  {:id => '225', :is_popular => '0', :code => 'TZ', :name => 'Tanzania, United Republic Of'},
  {:id => '226', :is_popular => '0', :code => 'UA', :name => 'Ukraine'},
  {:id => '227', :is_popular => '0', :code => 'UG', :name => 'Uganda'},
  {:id => '228', :is_popular => '1', :code => 'UK', :name => 'United Kingdom'},
  {:id => '229', :is_popular => '0', :code => 'UM', :name => 'United States Minor Outlying Islands'},
  {:id => '230', :is_popular => '1', :code => 'US', :name => 'United States'},
  {:id => '231', :is_popular => '0', :code => 'UY', :name => 'Uruguay'},
  {:id => '232', :is_popular => '0', :code => 'UZ', :name => 'Uzbekistan'},
  {:id => '233', :is_popular => '0', :code => 'VA', :name => 'Vatican City State (Holy See)'},
  {:id => '234', :is_popular => '0', :code => 'VC', :name => 'Saint Vincent And The Grenadines'},
  {:id => '235', :is_popular => '0', :code => 'VE', :name => 'Venezuela'},
  {:id => '236', :is_popular => '0', :code => 'VG', :name => 'Virgin Islands (British)'},
  {:id => '237', :is_popular => '0', :code => 'VI', :name => 'Virgin Islands (U.S.)'},
  {:id => '238', :is_popular => '0', :code => 'VN', :name => 'Viet Nam'},
  {:id => '239', :is_popular => '0', :code => 'VU', :name => 'Vanuatu'},
  {:id => '240', :is_popular => '0', :code => 'WF', :name => 'Wallis And Futuna Islands'},
  {:id => '241', :is_popular => '0', :code => 'WS', :name => 'Samoa'},
  {:id => '242', :is_popular => '0', :code => 'YE', :name => 'Yemen'},
  {:id => '243', :is_popular => '0', :code => 'YT', :name => 'Mayotte'},
  {:id => '244', :is_popular => '0', :code => 'YU', :name => 'Yugoslavia'},
  {:id => '245', :is_popular => '0', :code => 'ZA', :name => 'South Africa'},
  {:id => '246', :is_popular => '0', :code => 'ZM', :name => 'Zambia'},
  {:id => '247', :is_popular => '0', :code => 'ZR', :name => 'Zaire'},
  {:id => '248', :is_popular => '0', :code => 'ZW', :name => 'Zimbabwe'},
  {:id => '249', :is_popular => '0', :code => 'ZZ', :name => 'Unknown'}
]
create_all Country, countries

languages = [
    # {:id => '1', :code => 'EN', :name => 'English' , :country_id => '1'},
    # {:id => '2', :code => 'JA', :name => 'Japanese', :country_id => '2'},
]
create_all Language, languages

currencies = [
    # {:code => 'USD', :symbol => '$', :name => 'United States Dollar', :country_id => '1'},
    # {:code => 'JPY', :symbol => '(J\(B', :name => 'Japanese Yen'        , :country_id => '2'}
]
create_all Currency, currencies

protocols = [
  {:id => '1', :name => 'http'},
  {:id => '2', :name => 'https'},
  {:id => '3', :name => 'socks4'},
  {:id => '4', :name => 'socks5'},
  {:id => '5', :name => 'socks4/5'},
]
create_all Protocol, protocols
