class UserMailer < ApplicationMailer
  default from: "welcome@holyimage.baidu.com"
  layout "mailer"

  def welcome(user, url)
    @user = user
    @url = url
    mail(to: @user.email, subject: "欢迎加入 HolyImage")
  end

  def featured_photo(user, featured)
  end
end
