// Generated by CoffeeScript 1.6.3
(function() {
  this.Ranking = (function() {
    function Ranking(selector, marketCode) {
      this.$target = $(selector);
      this.$activeContent = this.$target;
      console.log(this.$activeContent);
      this.$activeContent.addClass('active');
      ($("\#tab-" + marketCode)).addClass('active');
    }

    Ranking.prototype.isRankingPage = function() {
      return this.$activeContent != null;
    };

    Ranking.prototype.isUpdatable = function() {
      return true;
    };

    Ranking.prototype.loadRankingData = function(callback, options) {
      if (this.isUpdatable()) {
        return $.get("" + window.location.href + ".json", callback);
      } else {

      }
    };

    Ranking.prototype.generateHeader = function(title) {
      var $categorySelector, $categorySelectorContainer, $categorySelectorTitle, $countrySelector, $countrySelectorContainer, $countrySelectorTitle, $deviceSelector, $deviceSelectorContainer, $deviceSelectorTitle, $header, $title, categories, category, countries, country, device, devices;
      $header = $('<div/>', {
        "class": 'ranking-header'
      });
      $title = ($('<div/>', {
        "class": 'ranking-title col-md-5'
      })).text(title);
      $deviceSelectorContainer = $('<div/>', {
        "class": 'col-md-2 selector-container'
      });
      $countrySelectorContainer = $('<div/>', {
        "class": 'col-md-2 selector-container'
      });
      $categorySelectorContainer = $('<div/>', {
        "class": 'col-md-2 selector-container'
      });
      $deviceSelectorTitle = ($('<div/>', {
        "class": 'selector-title'
      })).text('Device (don\'t work)');
      $countrySelectorTitle = ($('<div/>', {
        "class": 'selector-title'
      })).text('Country (Japan Only)');
      $categorySelectorTitle = ($('<div/>', {
        "class": 'selector-title'
      })).text('Category');
      $deviceSelector = $('<div/>', {
        "class": '',
        id: 'device-selector'
      });
      $countrySelector = $('<div/>', {
        "class": '',
        id: 'country-selector'
      });
      $categorySelector = $('<div/>', {
        "class": '',
        id: 'category-selector'
      });
      devices = (function() {
        var _i, _len, _ref, _results;
        _ref = gon.devices;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          device = _ref[_i];
          _results.push({
            name: device.name,
            opts: {
              id: device.code
            }
          });
        }
        return _results;
      })();
      countries = (function() {
        var _i, _len, _ref, _results;
        _ref = gon.countries;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          country = _ref[_i];
          _results.push({
            name: country.name,
            opts: {
              id: country.code,
              href: URLHelper.rankingUrl({
                country: country.code
              })
            }
          });
        }
        return _results;
      })();
      categories = (function() {
        var _i, _len, _ref, _results;
        _ref = gon.categories;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          category = _ref[_i];
          _results.push({
            name: category.name,
            opts: {
              id: category.code,
              href: URLHelper.rankingUrl({
                category: category.code
              })
            }
          });
        }
        return _results;
      })();
      ($countrySelectorContainer.append($countrySelectorTitle)).append($countrySelector);
      ($categorySelectorContainer.append($categorySelectorTitle)).append($categorySelector);
      if (devices.length > 1) {
        ($deviceSelectorContainer.append($deviceSelectorTitle)).append($deviceSelector);
      }
      $header.append($title);
      $header.append($deviceSelectorContainer);
      $header.append($categorySelectorContainer);
      $header.append($countrySelectorContainer);
      this.$target.append($header);
      DropdownSelector.insert('#device-selector', devices);
      DropdownSelector.insert('#country-selector', countries);
      DropdownSelector.insert('#category-selector', categories);
      ($("\#" + gon.device.code)).click();
      ($("\#" + gon.country.code)).click();
      return ($("\#" + gon.category.code)).click();
    };

    Ranking.prototype.generateAppIconImage = function(app_item) {
      var $image, dummy;
      dummy = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC';
      $image = app_item.banner_url != null ? $('<img/>', {
        "class": 'app-banner lazy',
        'data-original': app_item.banner_url,
        src: dummy
      }) : $('<img/>', {
        "class": 'app-icon lazy',
        'data-original': app_item.icon,
        src: dummy
      });
      return $image.lazyload({
        effect: 'fadeIn'
      });
    };

    Ranking.prototype.generateAppIcon = function(app_item) {
      var $a;
      $a = $('<a/>', {
        href: app_item.website_url
      });
      return $a.append(this.generateAppIconImage(app_item));
    };

    Ranking.prototype.generateAppTitle = function(app_item) {
      var $title;
      return $title = ($('<div/>', {
        "class": 'app-title'
      })).text(app_item.name);
    };

    Ranking.prototype.generateRankingTd = function(app_item) {
      var $div, $td;
      $td = $('<td/>');
      if (app_item != null) {
        $div = $('<div/>', {
          "class": 'app-info'
        });
        $div.append(this.generateAppIcon(app_item));
        $div.append(this.generateAppTitle(app_item));
        $td.append($div);
      }
      return $td;
    };

    Ranking.prototype.generateRankIndex = function(idx) {
      return ($('<td/>', {
        "class": 'rank-index'
      })).text(idx);
    };

    Ranking.prototype.generateRankingTbody = function(data) {
      var $tbody, $tbodyTr, app_item, idx, record, _i, _j, _len, _results;
      $tbody = $('<tbody/>');
      _results = [];
      for (idx = _i = 0; _i < 20; idx = ++_i) {
        $tbodyTr = ($('<tr/>')).append(this.generateRankIndex(idx + 1));
        for (_j = 0, _len = data.length; _j < _len; _j++) {
          record = data[_j];
          if (record.ranking.app_items != null) {
            app_item = record.ranking.app_items[idx];
            $tbodyTr.append(this.generateRankingTd(app_item));
          }
        }
        _results.push($tbody.append($tbodyTr));
      }
      return _results;
    };

    Ranking.prototype.generateFeedName = function(name, colSize) {
      return ($('<th/>', {
        "class": "col-md-" + colSize + " feed-name"
      })).text(name);
    };

    Ranking.prototype.generateRankCol = function() {
      return $('<th/>', {
        "class": 'col-md-1'
      });
    };

    Ranking.prototype.generateRankingTr = function(data) {
      var $th, $theadTr, bootColWidth, colSize, record, _i, _len, _results;
      bootColWidth = 12;
      colSize = parseInt((bootColWidth - 1) / data.length);
      $theadTr = $('<tr/>');
      $theadTr.append(this.generateRankCol());
      _results = [];
      for (_i = 0, _len = data.length; _i < _len; _i++) {
        record = data[_i];
        $th = this.generateFeedName(record.feed.name, colSize);
        _results.push($theadTr.append($th));
      }
      return _results;
    };

    Ranking.prototype.generateRankingThead = function(data) {
      return ($('<thead/>')).append(this.generateRankingTr(data));
    };

    Ranking.prototype.generateRanking = function() {
      var callback,
        _this = this;
      callback = function(data, status, xhr) {
        var $table, $tbody, $thead;
        $table = $('<table/>', {
          "class": 'table table-hover table-striped table-bordered app-table'
        });
        $thead = _this.generateRankingThead(data);
        $tbody = _this.generateRankingTbody(data);
        $table.append($thead);
        $table.append($tbody);
        $table.hide();
        _this.$activeContent.append($table);
        $table.fadeIn('slow');
        return ($(document)).scroll();
      };
      return this.loadRankingData(callback);
    };

    return Ranking;

  })();

  $(document).on('ready page:load', function() {
    var ranking;
    if (window.position != null) {
      ($(document)).scrollTop(window.position);
    }
    if (URLHelper.isRankingUrl(location.href)) {
      ranking = new Ranking('.ranking-content', gon.market.code.toLowerCase());
      ranking.generateHeader("" + gon.market.name + " Apps Ranking");
      return ranking.generateRanking();
    }
  });

  $(document).on('page:before-change', function() {
    return window.position = ($(document)).scrollTop();
  });

}).call(this);
