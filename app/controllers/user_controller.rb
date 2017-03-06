class UserController < ApplicationController
  def sign_in
    render "user/sign-in"
  end

  def create
    @user = User.new(params.require(:user).permit(:email, :name, :password, :password_confirm))

    unless @user.password == @user.password_confirm
      flash[:warning] = "Password confirmation failed"
    else
      if @user.save
      	flash[:info] = "Register successfully"
      else
        flash[:warning] = @user.errors.messages
      end
    end

    redirect_to root_url
  end

end
