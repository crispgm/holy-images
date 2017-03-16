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

    @user = User.new(params.require(:user).permit(:email, :name, :password, :password_confirmation))
    if @user.save
      log_in(@user)
      flash[:info] = "Register successfully"
    else
      flash[:warning] = @user.errors.messages
    end

    redirect_to root_url
  end

  def info
    @user = User.find_by(name: params[:name])
    @images = Image.where(user: @user.id).limit(10)
    render "user/user"
  end

  def login
    email = params[:user][:email]
    password = encrypt_password(params[:user][:password])

    @user = User.find_by(email: email, password: password)

    if @user.blank?
      flash[:warning] = "Login failed"
    else
      log_in(@user)
      flash[:info] = "Login successfully"
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
