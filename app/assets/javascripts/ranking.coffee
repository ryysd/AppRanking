class @Ranking
  constructor: (selector) ->
    @$target = $ selector
    (@$target.find '.nav-tabs').bind 'click', @onTabClicked

  onTabClicked: (e) ->
    console.log e

