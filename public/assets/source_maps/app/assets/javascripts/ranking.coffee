class @Ranking
  constructor: (selector, marketCode) ->
    @$target = $ selector
    @$activeContent = ($ "\#tab-#{marketCode}-content")
    console.log @$activeContent

    @$activeContent.addClass 'active'
    ($ "\#tab-#{marketCode}").addClass 'active'

  is_updatable: () -> true

  loadRankingData: (callback, options) ->
    if @is_updatable()
      # fetch data from server
      $.get "#{window.location.href}.json", callback
    else
      # load data from local strage

  generateRanking: () ->
    bootColWidth = 12
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
            if app_item?
              $td = $ '<td/>'
              $div = ($ '<div/>', {class: 'app-info'})
              $title = ($ '<div/>', {class: 'app-title'}).text app_item.name
              $a = $ '<a/>', {href: "https://play.google.com/store/apps/details?id=#{app_item.local_id}"}
              $image = $ '<img/>', {class: 'app-icon', src: app_item.icon}
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
  window.ranking = new Ranking '.ranking-content', gon.market_code.toLowerCase()

$(document).on 'page:before-change', ->
  window.position = ($ document).scrollTop() 
