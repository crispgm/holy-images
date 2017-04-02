# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def welcome
    UserMailer.welcome(User.first, "http://localhost:3000")
  end

  def featured_photo
    featured = Image.unscoped.where(url: "").joins(:likes).group("likes.image_id").order("created_at desc, count(likes.id) desc").limit(10)
    UserMailer.featured_photo(User.first, featured)
  end
end
