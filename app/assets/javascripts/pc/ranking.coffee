class @Ranking
  constructor: (selector, marketCode) ->
    @$target = $ selector
    @$activeContent = @$target
    console.log @$activeContent

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

  generateRankingTd: (app_item) ->
    $td = $ '<td/>'
    if app_item?
      $div = ($ '<div/>', {class: 'app-info'})
      $div.append (@generateAppIcon app_item)
      $div.append (@generateAppTitle app_item)
      $td.append $div
    $td

  generateRankIndex: (idx) -> ($ '<td/>', {class: 'rank-index'}).text (idx)

  generateRankingTbody: (data) ->
    $tbody = $ '<tbody/>'
    for idx in [0...20]
      $tbodyTr = ($ '<tr/>').append (@generateRankIndex (idx + 1))
      for record in data
        if record.ranking.app_items?
          app_item = record.ranking.app_items[idx]
          $tbodyTr.append @generateRankingTd app_item
      $tbody.append $tbodyTr

  generateFeedName: (name, colSize) -> ($ '<th/>', {class: "col-md-#{colSize} feed-name"}).text name
  generateRankCol: () -> $ '<th/>', {class: 'col-md-1'}

  generateRankingTr: (data) ->
    bootColWidth = 12
    colSize = parseInt ((bootColWidth - 1) / data.length)

    $theadTr = $ '<tr/>'
    $theadTr.append @generateRankCol()
    for record in data
      $th = @generateFeedName record.feed.name, colSize
      $theadTr.append $th

  generateRankingThead: (data) -> ($ '<thead/>').append (@generateRankingTr data)

  generateRanking: () ->
    callback = (data, status, xhr) =>
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

  if (URLHelper.isRankingUrl location.href)
    ranking = new Ranking '.ranking-content', gon.market.code.toLowerCase()
    ranking.generateHeader "#{gon.market.name} Apps Ranking"
    ranking.generateRanking()

$(document).on 'page:before-change', ->
  window.position = ($ document).scrollTop() 
