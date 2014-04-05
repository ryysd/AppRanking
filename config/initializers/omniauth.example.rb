Rails.application.config.middleware.use OmniAuth::Builder do

  #provider :twitter,
  #  Settings.OmniAuth.twitter.consumer_key,
  #  Settings.OmniAuth.twitter.consumer_secret,
  #  display: 'popup'

  #provider :facebook,
  #  Settings.OmniAuth.facebook.app_id,
  #  Settings.OmniAuth.facebook.app_secret,
  #  display: 'popup'

  provider :google_oauth2,
    'client id',
    'secret key',
    {
      name: "google",
      scope: "userinfo.email,userinfo.profile",
      approval_prompt: 'auto'
    }
end
