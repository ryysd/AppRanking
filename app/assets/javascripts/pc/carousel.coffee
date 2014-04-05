class @BootCarousel
  constructor: (selector) ->
    @$target = $ selector

  addContent: (content) ->
    $item = ($ '<div/>', {class: 'item'}).append($ content)
    $carousel = (@$target.find '.carousel-inner')

    $carousel.append $item
