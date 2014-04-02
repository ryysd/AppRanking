class @DropdownSelector
  @insert: (selector, data) ->
    $target = $ selector

    $dropdown = $ '<div/>', {class: 'dropdown dropdown-selector'}
    $dropdownToggle = ($ '<div/>', {class: 'dropdown-toggle', 'data-toggle': 'dropdown'})
    $dropdownToggle.append ($ '<div/>', {class: 'selected-text'}).text data[0]
    $dropdownToggle.append ($ '<b/>', {class: 'caret'})
    $menu = $ '<ul/>', {class: 'dropdown-menu', 'aria-labelledby': 'dropdownMenu', role: 'menu'}

    onClicked = () ->
      $toggle = $target.find '.selected-text'
      $toggle.text @text

    createMenu = ($menuTarget, menuList) ->
      if menuList.length > 0
        menu = menuList.shift()
        
        if (typeof menu) == 'object'
          for key of menu
            $subMenu = $ '<li/>', {class: 'dropdown-submenu'}
            $subMenu.append ($ '<a/>', {tabindex: -1}).text key
            $subUlMenu = $ '<ul/>', {class: 'dropdown-menu'}
            createMenu $subUlMenu, menu[key]
            $subMenu.append $subUlMenu
            $menuTarget.append $subMenu
        else
          $a = ($ '<a/>', {tabindex: -1}).text menu
          $a.click onClicked
          $menuTarget.append (($ '<li/>', ).append $a)
          createMenu $menuTarget, menuList

    createMenu $menu, data
    $dropdown.append $dropdownToggle
    $dropdown.append $menu

    $target.append $dropdown
