module Api
  module V1
    class ImagesController < Api::V1::BaseController
      def show
        @image = Image.find(params[:id])

        render json: @image
      end

      def index
        render json: Image.find(20)
      end

      def create
        render json: "hello"
      end
    end
  end
end
