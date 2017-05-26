class ApplicationController < ActionController::Base
  include UserHelper

  protect_from_forgery with: :exception

  before_action :set_locale, :get_notification

  def get_notification
    @is_notified = false

    if logged_in?
      notif_count = Notification.where(user_id: @current_user.id, status: 0).last(20).count
      @is_notified = notif_count > 01
    end
  end

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
