class ApplicationController < ActionController::Base
  include Jpmobile::ViewSelector

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?

  before_filter :set_user_id
  before_filter do |controller|
    session[:last_url] = request.url unless request.url =~ %r!/auth/|.json$!
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    !session[:user_id].blank?
  end 

  def set_user_id
    gon.user_id = current_user.id if signed_in?
  end
end
