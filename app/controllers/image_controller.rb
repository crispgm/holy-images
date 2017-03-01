class ImageController < ApplicationController
  def upload
  end

  def create
    @image = Image.new(params.require(:image).permit(:title, :url))

    @image.user = User.find(1)

    if @image.save
      flash[:info] = "上传成功"
    else
      flash[:warning] = @image.errors.messages
    end

    redirect_to root_url
  end
end
