class @Ranking
  constructor: (selector) ->
    @$target = $ selector
    (@$target.find '.nav-tabs').bind 'click', @onTabClicked

  onTabClicked: (e) ->
    console.log e

$(document).on 'ready page:load', ->
  ($ document).scrollTop window.position if window.position?

  code = gon.market_code.toLowerCase()
  $active =  $ "\#tab-#{code}"
  $active.addClass 'active'

$(document).on 'page:before-change', ->
  window.position = ($ document).scrollTop() 
