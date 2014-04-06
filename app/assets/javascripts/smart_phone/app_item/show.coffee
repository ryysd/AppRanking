class @AppItemShow
  @registerCallback: () ->
    ($ '.reservation-btn').click -> (AuthDialog.show 'この機能を利用するにはログインが必要です。')

$(document).on 'ready page:load', ->
  if (URLHelper.isAppUrl location.href)
    AppItemShow.registerCallback()

    $frame = $("#effects")
    $wrap = $frame.parent()
    
    # Call Sly on frame
    $frame.sly
      horizontal: 1
      itemNav: "forceCentered"
      smart: 1
      activateMiddle: 1
      activateOn: "click"
      mouseDragging: 1
      touchDragging: 1
      releaseSwing: 1
      startAt: 0
      scrollBar: $wrap.find(".scrollbar")
      scrollBy: 1
      speed: 300
      elasticBounds: 1
      easing: "swing"
      dragHandle: 1
      dynamicHandle: 1
      clickBar: 1
