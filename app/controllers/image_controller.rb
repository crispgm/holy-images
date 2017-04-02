class ImageController < ApplicationController
  include UserHelper
  include ImageHelper

  before_action :require_login

  def item
    @image = Image.find(params[:id])
    @likes = Like.where(image_id: @image.id)

    @image.liked = false
    if logged_in?
      @likes.each do |like|
        @image.liked = true if like.user_id == current_user.id
      end
    end

    begin
      image_local_original = @image.img_file(:original).split("?").at(0)
      image_prefix = Rails.application.config.runtime_path

      exif = Exif::Data.new("#{image_prefix}/public#{image_local_original}")

      @image.exif = {}
      @image.exif[:model] = "#{exif.make} #{exif.model}"
      @image.exif[:focal_length] = "#{exif.focal_length_in_35mm_film}"
      @image.exif[:aperture] = exif.fnumber
      @image.exif[:shutter_speed] = exif.exposure_time
      @image.exif[:ISO] = exif.iso_speed_ratings
      @image.exif[:software] = exif.software
      @image.exif[:resolution] = "#{exif.pixel_x_dimension}x#{exif.pixel_y_dimension}"
    rescue
      @image.exif = nil
    end
  end

  def explore
    @explore = {}
    @explore[:weekly_top] = weekly_top_list
    render "image/explore"
  end

  def digest
    digest = weekly_digest_photos
    unless params[:email].blank?
      if params[:email] == "all"
        @users = User.all
        @user.each do |u|
          UserMailer.featured_photo(u, digest).deliver_now
        end
      else
        @user = current_user
        # @user.email = "crispgm@gmail.com"
        @user.email = "226225555@qq.com"
        UserMailer.featured_photo(@user, digest).deliver_now
      end

      render plain: "sent"
      return
    end
    render plain: "not mail address"
  end

  def upload
  end

  def create
    @image = Image.new(params.require(:image).permit(:title, :url, :img_file))
    @image.user = User.find(current_user.id)

    if @image.save
      flash[:info] = "上传成功。"
    else
      flash[:warning] = @image.errors.messages
    end

    redirect_to root_url
  end

  def like
    image_id = params[:id]
    user_id = current_user.id

    result = {
      :status => nil,
      :cur_num => nil
    }
    
    # check existence
    @like = Like.unscoped.find_by(image_id: image_id, user_id: user_id, status: [Like::STATUS_LIKE, Like::STATUS_UNLIKE])

    unless @like == nil
      if @like.status == Like::STATUS_LIKE
        @like.status = Like::STATUS_UNLIKE
        result[:status] = Like::STATUS_UNLIKE
      else
        @like.status = Like::STATUS_LIKE
        result[:status] = Like::STATUS_LIKE
      end
      
      if @like.save
        result[:cur_num] = get_likes_num(image_id)
      else
        result[:status] = -1
      end
    else
      if new_like(image_id, user_id)
        result[:status] = Like::STATUS_LIKE
        result[:cur_num] = get_likes_num(image_id)
      else
        result[:status] = -2
      end
    end

    # render
    respond_to do |format|
      format.json do
        render json: result
      end
    end
  end

  private
  def require_login
    unless logged_in?
      flash[:warning] = "请先登录用户。"
      redirect_to root_url
    end
  end

  def new_like(image_id, user_id)
    # add new
    @initial_like = Like.new
    @initial_like.user = User.find(user_id)
    @initial_like.image = Image.find(image_id)
    @initial_like.status = Like::STATUS_LIKE
    @initial_like.save
  end

  def get_likes_num(image_id)
    Like.unscoped.select("id").where(image_id: image_id, status: Like::STATUS_LIKE).count
  end

  def weekly_top_list
    Image.unscoped.joins(:likes).group("likes.image_id").order("count(likes.id) desc").limit(30)
  end

  def weekly_digest_photos
    Image.unscoped.where(url: "").joins(:likes).group("likes.image_id").order("created_at desc, count(likes.id) desc").limit(10)
  end
end
