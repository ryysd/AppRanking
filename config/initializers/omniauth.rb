Rails.application.config.middleware.use OmniAuth::Builder do

  #provider :twitter,
  #  Settings.OmniAuth.twitter.consumer_key,
  #  Settings.OmniAuth.twitter.consumer_secret,
  #  display: 'popup'

  provider :facebook,
    '275797699261355',
    'da5a469a6cad1981b838f3417128cf5a',
    display: 'popup'

  provider :google_oauth2,
    '1003802209241-rdocapn0c47alo7fu44c18flo86n3sei.apps.googleusercontent.com',
    'xyiMns4XOwzYEhTS47VC7IIj',
    {
      name: "google",
      scope: "userinfo.email,userinfo.profile",
      approval_prompt: 'auto'
    }
end
