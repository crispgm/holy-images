class Image < ApplicationRecord
  attr_accessor :exif
  attr_accessor :liked

  belongs_to :user
  has_many :likes, -> { where status: Like::STATUS_LIKE }
  has_many :comments, -> { where status: Comment::STATUS_OK }

  validates :title, length: {minimum: 2}, presence: true
  has_attached_file :img_file, styles: { thumbnail: "640x640#" }
  validates_attachment_content_type :img_file, :content_type => /\Aimage/
  validates_attachment_file_name :img_file, :matches => [/jpe?g\Z/, /JPE?G\Z/]
  do_not_validate_attachment_file_type :img_file
  validate :url_or_file_presence

  default_scope do
    order(created_at: :desc)
  end

  def url_or_file_presence
    if url.blank? && img_file.blank?
      errors.add(:url, "can't be presense")
    end
  end

  def img_url(style = :thumbnail)
    url.blank? ? img_file(style) : url
  end

  def exif
    exif = {}
    begin
      image_local_original = img_file(:original).split("?").at(0)
      
      image_prefix = Rails.application.config.runtime_path

      exif_data = Exif::Data.new("#{image_prefix}/public#{image_local_original}")

      exif[:model] = "#{exif_data.make} #{exif_data.model}"
      exif[:focal_length] = "#{exif_data.focal_length_in_35mm_film}"
      exif[:aperture] = exif_data.fnumber
      exif[:shutter_speed] = exif_data.exposure_time
      exif[:ISO] = exif_data.iso_speed_ratings
      exif[:software] = exif_data.software
      exif[:resolution] = "#{exif_data.pixel_x_dimension}x#{exif_data.pixel_y_dimension}"
    rescue
      exif = nil
    end
    logger.info exif.inspect
    exif
  end
end
