class @Ranking
  constructor: (selector, marketCode) ->
    @$target = $ selector
    @activeContent = ($ "\#tab-#{marketCode}-content")

    @activeContent.addClass 'active'
    ($ "\#tab-#{marketCode}").addClass 'active'

  loadRankingData: (start, end) ->

  generateRanking: () ->
    rankings = @rankings
    $rankingTable = $ '<table/>', {class: 'table table-hover'}

$(document).on 'ready page:load', ->
  ($ document).scrollTop window.position if window.position?
  ranking = new Ranking '.ranking-content', gon.market_code.toLowerCase()

$(document).on 'page:before-change', ->
  window.position = ($ document).scrollTop() 
