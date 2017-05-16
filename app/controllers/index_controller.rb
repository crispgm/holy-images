class IndexController < ApplicationController
  include UserHelper
  
  def index
    unless logged_in?
      image_list = Image.unscoped.select("likes.image_id,COUNT(likes.id) AS like_count").
        joins(:likes).group("likes.image_id,likes.id").order("like_count desc").limit(18)

      @images = []
      image_list.each do |item|
        @images << Image.find(item.image_id)
      end
      render "index/landing"
    else
      page = params[:p].to_i || 1
      page = 1 if page <= 0
      start = (page - 1) * 10
      total = Image.count
      @images = Image.limit(10).offset(start)

      @images.each do |img|
        img.liked = false
        img.likes.each do |like|
          img.liked = true if like.user_id == current_user.id
        end
      end

      @page = {
        :total => total,
        :cur_page => page,
        :total_page => (total.to_f/10.to_f).ceil
      }

      render "index/index"
    end
  end
end
