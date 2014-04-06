class @AuthDialog
  @show: (title) ->
    source = ""
    source += "<div class='signin-btn-container'>"
    source += "  <a class='zocial googleplus' href='/auth/google'>Sign in with Google</a>"
    source += "  <a class='zocial facebook' href='/auth/facebook'>Sign in with Facebook</a>"
    source += "  <a class='zocial twitter btn disabled' href='/auth/twitter'>Sign in with Twitter (disabled)</a>"
    source += "<div/>"

    bootbox.dialog 
      message: source
      title: title

$(document).on 'ready page:load', ->
  ($ '#sign-in').click -> AuthDialog.show 'Sign In'
