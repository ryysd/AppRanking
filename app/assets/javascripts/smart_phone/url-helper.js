// Generated by CoffeeScript 1.6.3
(function() {
  this.URLHelper = (function() {
    function URLHelper() {}

    URLHelper.rankingUrl = function(args) {
      var category, country, device, market, urlParam;
      urlParam = URLHelper.parseRankingUrl(window.location);
      country = (args.country || urlParam.country).toLowerCase();
      market = (args.market || urlParam.market).toLowerCase();
      category = (args.category || urlParam.category).toLowerCase();
      device = (args.device || urlParam.device).toLowerCase();
      return "/countries/" + country + "/markets/" + market + "/categories/" + category + "/devices/" + device + "/rankings";
    };

    URLHelper.parseRankingUrl = function(url) {
      var match;
      match = /.*\/countries\/([a-z]+)\/markets\/([a-z]+)\/categories\/(\w+)\/devices\/(\w+)\/rankings/.exec(url);
      return {
        country: match[1],
        market: match[2],
        category: match[3],
        device: match[4]
      };
    };

    return URLHelper;

  })();

}).call(this);
