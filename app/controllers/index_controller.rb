class IndexController < ApplicationController
  include UserHelper
  
  def index
    page = params[:p].to_i || 1
    page = 1 if page <= 0
    start = (page - 1) * 10
    total = Image.count
    @images = Image.limit(10).offset(start)

    @images.each do |img|
      img.liked = false
      if logged_in?
        img.likes.each do |like|
          img.liked = true if like.user_id == current_user.id
        end
      end
    end

    @page = {
      :total => total,
      :cur_page => page,
      :total_page => (total.to_f/10.to_f).ceil
    }
  end
end
