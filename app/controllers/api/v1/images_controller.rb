module Api
  module V1
    class ImagesController < Api::V1::BaseController
      def show
        image = Image.find(params[:id])

        render json: format_image(image, with_exif: true, with_likes: true, with_comments: true)
      end

      def index
        images = Image.all
        result = images.map do |image|
          image = format_image(image)
        end
        render json: result
      end

      def create
        render json: "hello"
      end

      private
      def domain
        "#{request.protocol}#{request.host_with_port}"
      end

      def format_image(image, with_exif: true, with_likes: false, with_comments: false)
        if with_likes
          likes = []
          image.likes.each do |like|
            likes << {
              user_id: like.user.id,
              user_name: like.user.name,
              created_at: like.created_at.to_i,
              updated_at: like.updated_at.to_i,
            }
          end
        end

        if with_comments
          comments = []
          image.comments.each do |comment|
            comments << {
              user_id: comment.user.id,
              user_name: comment.user.name,
              content: comment.content,
              created_at: comment.created_at.to_i,
              updated_at: comment.updated_at.to_i,
            }
          end
        end

        if with_exif
          unless image.exif.blank?
            exif = image.exif.compact
            exif.delete(:model) if exif[:model] == " "
            exif.delete(:resolution) if exif[:resolution] == "x"
          else
            exif = {}
          end
        end

        {
          id: image.id,
          title: image.title,
          created_at: image.created_at.to_i,
          updated_at: image.updated_at.to_i,
          user_id: image.user.id,
          user_name: image.user.name,
          user_gravatar: image.user.gravatar_url,
          url: "#{domain}#{image.img_url(:original)}",
          thumbnails: "#{domain}#{image.img_url}",
          exif: with_exif ? exif : nil,
          like_num: image.likes.count,
          likes: with_likes ? likes : nil,
          comment_num: image.comments.count,
          comments: with_comments ? comments : nil
        }.compact
      end
    end
  end
end
