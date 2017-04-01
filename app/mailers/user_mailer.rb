class UserMailer < ApplicationMailer
  def welcome(user, url)
    @user = user
    @url = url
    mail(to: @user.email, subject: t("mail.welcome.title"))
  end

  def featured_photo(user, featured)
    @user = user
    @featured = featured
    mail(to: @user.email, subject: t("mail.featured.title"))
  end
end
