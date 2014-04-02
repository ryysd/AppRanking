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
    $title = ($ '<div/>', {class: 'ranking-title col-md-7'}).text title
    $countrySelector = $ '<div/>', {class: 'col-md-2', id: 'country-selector'}
    $categorySelector = $ '<div/>', {class: 'col-md-2', id: 'category-selector'}

    $header.append $title
    $header.append $categorySelector
    $header.append $countrySelector

    @$target.append $header

    countries = ({name: country.name, opts: {id: country.code}} for country in gon.countries)
    categories = ({name: category.name, opts: {id: category.code}} for category in gon.categories)
    DropdownSelector.insert '#country-selector', countries
    DropdownSelector.insert '#category-selector', categories

    ($ "\##{gon.country.code}").click()
    ($ "\##{gon.category.code}").click()

  generateRanking: () ->
    bootColWidth = 12
    dummy = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC'
    callback = (data, status, xhr) =>
      $table = $ '<table/>', {class: 'table table-hover table-striped table-bordered app-table'}
      $thead = $ '<thead/>'
      $theadTr = $ '<tr/>'

      colSize = parseInt ((bootColWidth - 1) / data.length)

      $theadTr.append $ '<th/>', {class: 'col-md-1'}
      for record in data
        console.log record
        $th = ($ '<th/>', {class: "col-md-#{colSize} feed-name"}).text record.feed.name
        $theadTr.append $th

      $tbody = $ '<tbody/>'
      for idx in [0...20]
        $tbodyTr = $ '<tr/>'
        $tbodyTr.append (($ '<td/>', {class: 'rank-index'}).text (idx+1))
        for record in data
          if record.ranking.app_items?
            app_item = record.ranking.app_items[idx]
            $td = $ '<td/>'
            if app_item?
              $div = ($ '<div/>', {class: 'app-info'})
              $title = ($ '<div/>', {class: 'app-title'}).text app_item.name
              $a = $ '<a/>', {href: "https://play.google.com/store/apps/details?id=#{app_item.local_id}"}
              $image = $ '<img/>', {class: 'app-icon lazy', 'data-original': app_item.icon, src: dummy}
              $image.lazyload(effect: 'fadeIn')
              $a.append $image
              $div.append $a
              $div.append $title
              $td.append $div
            $tbodyTr.append $td

        $tbody.append $tbodyTr

      $thead.append $theadTr
      $table.append $thead
      $table.append $tbody

      @$activeContent.append $table

    @loadRankingData callback

$(document).on 'ready page:load', ->
  ($ document).scrollTop window.position if window.position?
  ranking = new Ranking '.ranking-content', gon.market.code.toLowerCase()
  if ranking.isRankingPage()
    ranking.generateHeader "#{gon.market.name} Apps Ranking"
    ranking.generateRanking()

$(document).on 'page:before-change', ->
  window.position = ($ document).scrollTop() 
