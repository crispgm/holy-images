class ImageController < ApplicationController
  def upload
  end

  def create
    @image = Image.new(params.require(:image).permit(:title, :url))
    # TODO
    @image.user = User.find(1)

    if @image.save
      flash[:info] = "上传成功"
    else
      flash[:warning] = @image.errors.messages
    end

    redirect_to root_url
  end

  def like
    image_id = params[:id]
    # check existence
    begin
      @like = Like.find_by(image_id: image_id, user_id: 1) # TODO

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
    rescue ActiveRecord::RecordNotFound
      # add new
      @initial_like = Like.new
      # TODO
      @initial_like.user = User.find(1)
      @initial_like.image = Image.find(image_id)
      @initial_like.status = Like::STATUS_LIKE
      @initial_like.save
      respond_to do |format|
        format.json do
          render json: @initial_like
        end
      end
    end
  end
end
