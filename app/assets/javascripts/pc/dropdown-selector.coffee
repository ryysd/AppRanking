class @DropdownSelector
  @insert: (selector, data, options) ->
    $target = $ selector

    $dropdown = $ '<div/>', {class: 'dropdown dropdown-selector'}
    $dropdownToggle = ($ '<div/>', {class: 'dropdown-toggle', 'data-toggle': 'dropdown'})
    $dropdownToggle.append ($ '<div/>', {class: 'selected-text col-md-11'})
    $dropdownToggle.append ($ '<b/>', {class: 'caret'})
    $menu = $ '<ul/>', {class: 'dropdown-menu', 'aria-labelledby': 'dropdownMenu', role: 'menu'}

    onClicked = () ->
      $toggle = $target.find '.selected-text'
      $toggle.text @text
      options.onClicked @ if options? && options.onClicked?

    createMenu = ($menuTarget, menuList) ->
      if menuList.length > 0
        menu = menuList.shift()
        
        if (typeof menu) == 'object' && menu.child?
          $subMenu = $ '<li/>', {class: 'dropdown-submenu'}
          $subMenu.append ($ '<a/>', {tabindex: -1}).text menu.name
          $subUlMenu = $ '<ul/>', {class: 'dropdown-menu'}
          createMenu $subUlMenu, menu.child
          $subMenu.append $subUlMenu
          $menuTarget.append $subMenu
        else
          name = menu.name || menu
          opts = menu.opts || {}
          opts.tabindex = -1
          $a = ($ '<a/>', opts).text name
          $a.click onClicked
          $menuTarget.append (($ '<li/>', ).append $a)
          createMenu $menuTarget, menuList

    createMenu $menu, data

    $dropdown.append $dropdownToggle
    $dropdown.append $menu

    $target.append $dropdown
