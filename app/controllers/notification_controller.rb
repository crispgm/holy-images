class NotificationController < ApplicationController
  include TimeHelper

  before_action :require_login

  def list
    @user = current_user
    @notifications = Notification.where(user_id: @user.id).last(20).reverse

    render "notification/list"
  end

  def read
    id = params[:id]
    user = current_user

    result = nil
    if id == "all"
      result = Notification.where(status: 0, user_id: user.id).update_all(status: 1)
      redirect_to notification_url
    else
      id = id.to_i
      result = Notification.where(status: 0, user_id: user.id, id: id).update(status: 1)
      redirect_to "/image/#{id}#comments"
    end
  end

  private
  def require_login
    unless logged_in?
      flash[:warning] = I18n.t(:login_required)
      redirect_to root_url
    end
  end
end
