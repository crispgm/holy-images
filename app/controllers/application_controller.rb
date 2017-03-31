class ApplicationController < ActionController::Base
  include UserHelper

  protect_from_forgery with: :exception

  before_action :set_locale

  def set_locale
    if logged_in?
      I18n.locale = params[:locale] || @current_user.locale || I18n.default_locale
    else
      I18n.locale = params[:locale] || I18n.default_locale
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
