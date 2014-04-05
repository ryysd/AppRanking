class @URLHelper
  @rankingUrl: (args) ->
    urlParam = URLHelper.parseRankingUrl window.location

    country  = (args.country  || urlParam.country).toLowerCase()
    market   = (args.market   || urlParam.market).toLowerCase()
    category = (args.category || urlParam.category).toLowerCase()
    device   = (args.device   || urlParam.device).toLowerCase()
    feed     = (args.feed     || urlParam.feed).toLowerCase()

    "/countries/#{country}/markets/#{market}/feeds/#{feed}/categories/#{category}/devices/#{device}/rankings"

  @parseRankingUrl: (url) ->
    match = /.*\/countries\/([a-z]+)\/markets\/([a-z]+)\/feeds\/([a-z]+)\/categories\/(\w+)\/devices\/(\w+)\/rankings/.exec url
    {country: match[1], market: match[2], feed: match[3], category: match[4], device: match[5]}
