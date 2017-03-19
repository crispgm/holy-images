class UserController < ApplicationController
  include UserHelper
  
  def sign_in
    render "user/sign-in"
  end

  def invite
    render "user/invite"
  end

  def create
    params[:user][:password] = encrypt_password(params[:user][:password])
    params[:user][:password_confirmation] = encrypt_password(params[:user][:password_confirmation])

    unless params[:user].has_key?(:invited_by)
      invited_by = 0
    else
      invited_by = User.find_by(name: params[:user][:invited_by]).id
    end

    @user = User.new(params.require(:user).permit(:email, :name, :password, :password_confirmation))
    @user.invited_by = invited_by
    if @user.save
      log_in(@user)
      flash[:info] = "注册成功。"
      UserMailer.welcome(@user, request.url).deliver_later
    else
      flash[:warning] = @user.errors.messages
    end

    redirect_to root_url
  end

  def info
    @user = User.find_by(name: params[:name])
    @images = Image.where(user: @user.id).limit(10)
    @invite_user = @user.invited_by == 0 ? nil : User.find(@user.invited_by)
    render "user/user"
  end

  def login
    email = params[:user][:email]
    password = encrypt_password(params[:user][:password])

    @user = User.find_by(email: email, password: password)

    if @user.blank?
      flash[:warning] = "登录失败。"
    else
      log_in(@user)
      flash[:info] = "登录成功。"
    end

    redirect_to root_url
  end

  def logout
    log_off(current_user)
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
