class @Ranking
  constructor: (selector, marketCode) ->
    @$target = $ selector
    @$activeContent = @$target

    @$activeContent.addClass 'active'
    ($ "\#tab-#{marketCode}").addClass 'active'

  isRankingPage: () -> @$activeContent.length != 0
  isUpdatable: () -> true

  loadRankingData: (callback, options) ->
    if @isUpdatable()
      # fetch data from server
      $.get "#{URLHelper.rankingUrl({})}.json", callback
    else
      # load data from local strage

  generateFeedGroup: (feeds) ->
    $groupWrapper = $ '<div/>', {class: 'btn-group btn-group-justified feed-group'}
    width = 100 / feeds.length

    for feed in feeds
      $group = $ '<div/>', {class: 'btn-group', width: "#{width}%"}
      url = URLHelper.rankingUrl {feed: feed.code}
      $button = ($ '<button/>', {type: 'button', class: 'btn btn-default', id: "feed-#{feed.code}", onclick: "location.href = '#{url}'"}).text feed.name
      $groupWrapper.append ($group.append $button)

    $groupWrapper

  activateFeed: (feed) -> ($ "#feed-#{feed.code}").addClass 'selected'

  generateAppIconImage: (app_item) ->
    dummy = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC'
    $image = 
      if app_item.banner_url?
        $ '<img/>', {class: 'app-banner lazy', 'data-original': app_item.banner_url, src: dummy}
      else
        $ '<img/>', {class: 'app-icon lazy', 'data-original': app_item.icon, src: dummy}

    $image.lazyload(effect: 'fadeIn')

  generateAppIcon: (app_item) ->
    $a = $ '<a/>', {href: (URLHelper.appItemUrl app_item.id)}
    $a.append (@generateAppIconImage app_item)

  generateAppTitle: (app_item) -> $title = ($ '<div/>', {class: 'app-title'}).text app_item.name

  generateAppRank: (rank) -> ($ '<div/>', {class: 'app-rank'}).text rank

  generateAppInfoHeader: (app_item, rank) ->
    $div = ($ '<div/>', {class: 'app-info-header'})
    $div.append @generateAppRank rank
    $div.append @generateAppTitle app_item

  generateAppDetail: (app_item) -> @generateAppTitle app_item

  generateAppInfo: (app_item, rank) ->
    $div = ($ '<div/>', {class: 'app-info'})
    $div.append (@generateAppIcon app_item)
    $div.append (@generateAppDetail app_item)

  generateReleaseDate: (app_item) ->
    $div = ($ '<div/>', {class: 'app-release-date'})
    $div.text 'Release: xx月yy日 上旬頃'

  generateBonusInfo: (app_item) ->
    $div = ($ '<div/>', {class: 'app-bonus'})
    bonus = app_item.reservation_information.bonus

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

  generateFeedName: (name, width) -> (($ '<th/>').css display: 'none', width: width).text name

  generateRankCol: () -> $ '<th/>', {class: 'col-md-1'}

  generateRankingTr: (data) ->
    width = 100 / data.length

    $theadTr = $ '<tr/>'
    for record in data
      $th = @generateFeedName record.feed.name, width
      $th.css width: width
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
      @$activeContent.append (@generateFeedGroup gon.feeds)
      @activateFeed gon.feed
      @$activeContent.append $table
      $table.fadeIn 'slow'

      # fire lazyload event
      ($ document).scroll()

    @loadRankingData callback

$(document).on 'ready page:load', ->
  if (URLHelper.isRankingUrl location.href)
    ($ document).scrollTop window.position if window.position?
    ranking = new Ranking '.ranking-content', gon.market.code.toLowerCase()
    ranking.generateRanking()

$(document).on 'page:before-change', ->
  window.position = 0
  if (URLHelper.isRankingUrl location.href)
    window.position = ($ document).scrollTop() 
