class UserController < ApplicationController
  include TimeHelper
  
  def sign_in
    render "user/sign-in"
  end

  def invite
    render "user/invite"
  end

  def create
    params[:user][:password] = encrypt_password(params[:user][:password])
    params[:user][:password_confirmation] = encrypt_password(params[:user][:password_confirmation])

    if params[:user][:invited_by].blank?
      invited_by = 0
    else
      invited_by = User.find_by(name: params[:user][:invited_by]).id
    end

    @user = User.new(params.require(:user).permit(:email, :name, :password, :password_confirmation, :locale))
    @user.invited_by = invited_by
    if @user.save
      log_in(@user)
      flash[:info] = I18n.t("register_success")
      UserMailer.welcome(@user, "#{request.protocol}#{request.host_with_port}").deliver_now
    else
      flash[:warning] = @user.errors.messages
    end

    redirect_to root_url
  end

  def info
    @user = User.find_by(name: params[:name])
    @images = Image.where(user: @user.id).limit(9)
    @invite_user = @user.invited_by == 0 ? nil : User.find(@user.invited_by)
    render "user/user"
  end

  def login
    email = params[:user][:email]
    password = encrypt_password(params[:user][:password])

    @user = User.find_by(email: email, password: password)

    if @user.blank?
      flash[:warning] = I18n.t("login_failure")
    else
      log_in(@user)
      flash[:info] = I18n.t("login_success")
    end

    redirect_to root_url
  end

  def logout
    log_off(current_user)
  end

  def locale
    I18n.locale = params[:locale] || I18n.default_locale
    current_user.locale = I18n.locale
    current_user.save
  end

  private
  def valid_password?(raw_password)
    raw_password.length < 6 || raw_password.length > 20 ? false : true  
  end

  def encrypt_password(raw_password)
    Digest::MD5.hexdigest("#{md5_salt}|#{raw_password}")
  end

  def md5_salt
    ENV["MD5_SALT"] || "iLoveRuby0nRa1ls"
  end
end
