class @Ranking
  constructor: (selector, marketCode) ->
    @$target = $ selector
    @$activeContent = @$target

    @$activeContent.addClass 'active'
    ($ "\#tab-#{marketCode}").addClass 'active'

  isRankingPage: () -> @$activeContent?
  isUpdatable: () -> true

  loadRankingData: (callback, options) ->
    if @isUpdatable()
      # fetch data from server
      $.get "#{window.location.href}.json", callback
    else
      # load data from local strage

  generateHeader: (title) ->
    $header = $ '<div/>', {class: 'ranking-header'}
    $title = ($ '<div/>', {class: 'ranking-title col-md-5'}).text title

    $deviceSelectorContainer   = $ '<div/>', {class: 'col-md-2 selector-container'}
    $countrySelectorContainer  = $ '<div/>', {class: 'col-md-2 selector-container'}
    $categorySelectorContainer = $ '<div/>', {class: 'col-md-2 selector-container'}

    $deviceSelectorTitle   = ($ '<div/>', {class: 'selector-title'}).text 'Device (don\'t work)'
    $countrySelectorTitle  = ($ '<div/>', {class: 'selector-title'}).text 'Country (Japan Only)'
    $categorySelectorTitle = ($ '<div/>', {class: 'selector-title'}).text 'Category'

    $deviceSelector   = $ '<div/>', {class: '', id: 'device-selector'}
    $countrySelector  = $ '<div/>', {class: '', id: 'country-selector'}
    $categorySelector = $ '<div/>', {class: '', id: 'category-selector'}

    devices = ({name: device.name, opts: {id: device.code}} for device in gon.devices)
    countries = ({name: country.name, opts: {id: country.code, href: URLHelper.rankingUrl {country: country.code}}} for country in gon.countries)
    categories = ({name: category.name, opts: {id: category.code, href: URLHelper.rankingUrl {category: category.code}}} for category in gon.categories)
 
    ($countrySelectorContainer.append $countrySelectorTitle).append $countrySelector
    ($categorySelectorContainer.append $categorySelectorTitle).append $categorySelector
    ($deviceSelectorContainer.append $deviceSelectorTitle).append $deviceSelector if devices.length > 1

    $header.append $title
    $header.append $deviceSelectorContainer
    $header.append $categorySelectorContainer
    $header.append $countrySelectorContainer

    @$target.append $header
   
    DropdownSelector.insert '#device-selector', devices
    DropdownSelector.insert '#country-selector', countries
    DropdownSelector.insert '#category-selector', categories

    ($ "\##{gon.device.code}").click()
    ($ "\##{gon.country.code}").click()
    ($ "\##{gon.category.code}").click()

  generateAppIconImage: (app_item) ->
    dummy = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC'
    $image = 
      if app_item.banner_url?
        $ '<img/>', {class: 'app-banner lazy', 'data-original': app_item.banner_url, src: dummy}
      else
        $ '<img/>', {class: 'app-icon lazy', 'data-original': app_item.icon, src: dummy}

    $image.lazyload(effect: 'fadeIn')

  generateAppIcon: (app_item) ->
    $a = $ '<a/>', {href: app_item.website_url}
    $a.append (@generateAppIconImage app_item)

  generateAppTitle: (app_item) -> $title = ($ '<div/>', {class: 'app-title'}).text app_item.name

  generateAppRank: (rank) ->
    $div = ($ '<div/>', {class: 'app-rank'})
    $div.text rank

  generateAppInfoHeader: (app_item, rank) ->
    $div = ($ '<div/>', {class: 'app-info-header'})
    $div.append @generateAppRank rank
    $div.append @generateAppTitle app_item

  generateAppDetail: (app_item) ->
    @generateAppTitle app_item

  generateAppInfo: (app_item, rank) ->
    $div = ($ '<div/>', {class: 'app-info'})
    $div.append (@generateAppIcon app_item)
    $div.append (@generateAppDetail app_item)

  generateReleaseDate: (app_item) ->
    $div = ($ '<div/>', {class: 'app-release-date'})
    $div.text 'Release: xx月yy日 上旬頃'

  generateBonusInfo: (app_item) ->
    $div = ($ '<div/>', {class: 'app-bonus'})
    bonus = app_item.reservation.bonus

    if (Object.keys bonus).length != 0
      $div.addClass 'btn btn-bonus'
      $div.text '予約特典あり'
    
  generateOverlapInfoArea: (app_item) ->
    $div = ($ '<div/>', {class: 'overlap-app-info'})
    $div.append (@generateReleaseDate app_item)
    $div.append (@generateBonusInfo app_item)

  generateAppInfoLarge: (app_item, rank) ->
    $div = ($ '<div/>', {class: 'app-info'})
    $div.append (@generateAppInfoHeader app_item, rank)
    $div.append (@generateAppIcon app_item)
    $div.append (@generateOverlapInfoArea app_item)

  generateRankingTd: (app_item, idx) ->
    $td = $ '<td/>'
    if app_item?
      if !app_item.banner_url?
        $td.addClass 'app-data'
        $td.append (@generateAppInfo app_item, idx+1)
      else
        $td.addClass 'app-data-large'
        $td.append (@generateAppInfoLarge app_item, idx+1)
    $td

  generateRankIndex: (idx) -> ($ '<td/>', {class: 'rank-index'}).text (idx)

  generateRankingTbody: (data) ->
    $tbody = $ '<tbody/>'
    for idx in [0...20]
      $tbodyTr = ($ '<tr/>')
      for record in data
        if record.ranking.app_items?
          app_item = record.ranking.app_items[idx]
          $tbodyTr.append (@generateRankingTd app_item, idx)
      $tbody.append $tbodyTr

  generateFeedName: (name, colSize) -> ($ '<th/>', {class: "col-md-#{colSize} feed-name"}).text name
  generateRankCol: () -> $ '<th/>', {class: 'col-md-1'}

  generateRankingTr: (data) ->
    bootColWidth = 12
    colSize = parseInt ((bootColWidth - 1) / data.length)

    $theadTr = $ '<tr/>'
    for record in data
      $th = @generateFeedName record.feed.name, colSize
      $theadTr.append $th

  generateRankingThead: (data) -> ($ '<thead/>').append (@generateRankingTr data)

  generateRanking: () ->
    callback = (data, status, xhr) =>
      console.log data
      $table = $ '<table/>', {class: 'table table-hover table-striped table-bordered app-table'}

      $thead = @generateRankingThead data
      $tbody = @generateRankingTbody data

      $table.append $thead
      $table.append $tbody

      $table.hide()
      @$activeContent.append $table
      $table.fadeIn 'slow'

      # fire lazyload event
      ($ document).scroll()

    @loadRankingData callback

$(document).on 'ready page:load', ->
  ($ document).scrollTop window.position if window.position?
  ranking = new Ranking '.ranking-content', gon.market.code.toLowerCase()
  if ranking.isRankingPage()
    # ranking.generateHeader "#{gon.market.name} Apps Ranking"
    ranking.generateRanking()

$(document).on 'page:before-change', ->
  window.position = ($ document).scrollTop() 
