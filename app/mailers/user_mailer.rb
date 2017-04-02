class UserMailer < ApplicationMailer
  def welcome(user, url)
    @user = user
    @url = url
    mail(to: @user.email, subject: t("mail.welcome.title"))
  end

  def featured_photo(user, featured)
    @user = user
    @featured = featured.take(4)
    # attach uploaded photos
    attach_inline_photos
    # send mail
    mail(to: @user.email, subject: t("mail.featured.title"))
  end

  private
  def attach_inline_photos
    @featured.each_with_index do |p, i|
      img_file_name = p.img_file(:thumbnail).split("?").at(0)
      app_path = Rails.application.config.runtime_path
      img_path = "#{app_path}/public/#{img_file_name}"

      attachments.inline["feature_#{i}"] = {
        :data => File.read(img_path),
        :mime_type => mime_type_of(img_file_name),
        # :encoding => "base64"
      }
    end
  end

  def mime_type_of(filename)
    if filename.end_with?("jpg", "jpeg", "JPG", "JPEG")
      "image/jpeg"
    elsif filename.end_with("png", "PNG")
      "image/png" 
    else
      nil
    end
  end
end
