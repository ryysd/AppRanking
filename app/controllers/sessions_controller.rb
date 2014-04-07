class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = case auth.provider
	     when 'google' then User.find_for_google_oauth auth
	     when 'facebook' then User.find_for_facebook_oauth auth
	     when 'twitter' then User.find_for_twitter_oauth auth
	   end
    #user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)

    session[:user_id] = user.id
    redirect_to session[:last_url], :notice => "Signed In!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed Out!"
  end
end
