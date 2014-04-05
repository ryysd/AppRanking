class @URLHelper
  @rankingUrl: (args) ->
    urlParam = URLHelper.parseRankingUrl window.location

    country  = (args.country  || urlParam.country).toLowerCase()
    market   = (args.market   || urlParam.market).toLowerCase()
    category = (args.category || urlParam.category).toLowerCase()
    device   = (args.device   || urlParam.device).toLowerCase()

    "/countries/#{country}/markets/#{market}/categories/#{category}/devices/#{device}/rankings"

  @parseRankingUrl: (url) ->
    match = /.*\/countries\/([a-z]+)\/markets\/([a-z]+)\/categories\/(\w+)\/devices\/(\w+)\/rankings/.exec url
    {country: match[1], market: match[2], category: match[3], device: match[4]}
