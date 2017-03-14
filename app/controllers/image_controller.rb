class ImageController < ApplicationController
  include UserHelper
  include ImageHelper

  before_action :require_login, only: [:upload, :create, :like]

  def item
    @image = Image.find(params[:id])
    @likes = Like.where(image_id: @image.id)

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

  def upload
  end

  def create
    @image = Image.new(params.require(:image).permit(:title, :url, :img_file))
    @image.user = User.find(current_user.id)

    if @image.save
      flash[:info] = "Upload successfully."
    else
      flash[:warning] = @image.errors.messages
    end

    redirect_to root_url
  end

  def like
    image_id = params[:id]
    user_id = current_user.id
    # check existence
    @like = Like.find_by(image_id: image_id, user_id: user_id)

    unless @like == nil
      if @like.status == Like::STATUS_LIKE
        @like.status = Like::STATUS_UNLIKE
      else
        @like.status = Like::STATUS_LIKE
      end
      respond_to do |format|
        if @like.save
          format.json do
            render json: @like
          end
        else
          format.json do
            render json: @like.errors
          end
        end
      end
    else
      new_like(image_id, user_id)
      respond_to do |format|
        format.json do
          render json: @initial_like
        end
      end
    end
  end

  private
  def require_login
    unless logged_in?
      flash[:warning] = "Please register an account."
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

  def weekly_top_list
    Image.unscoped.joins(:likes).group("likes.image_id").order("count(likes.id) desc")
  end
end
