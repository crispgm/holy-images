class Image < ApplicationRecord
  attr_accessor :exif
  attr_accessor :liked

  belongs_to :user
  has_many :likes, -> { where status: Like::STATUS_LIKE }
  has_many :comments, -> { where status: Comment::STATUS_OK }

  validates :title, length: {minimum: 2}, presence: true
  validates :img_file, presence: true
  has_attached_file :img_file, styles: { thumbnail: "640x640#" }
  validates_attachment_content_type :img_file, :content_type => /\Aimage/
  validates_attachment_file_name :img_file, :matches => [/jpe?g\Z/, /JPE?G\Z/]
  do_not_validate_attachment_file_type :img_file
  validates :filter, numericality: {greater_than_or_equal_to: 0}

  default_scope do
    order(created_at: :desc)
  end

  def img_url(style = :thumbnail)
    img_file(style)
  end

  def exif
    exif = {}
    begin
      image_local_original = img_file(:original).split("?").at(0)

      image_prefix = Rails.application.config.runtime_path

      exif_data = Exif::Data.new("#{image_prefix}/public#{image_local_original}")

      exif[:model] = "#{exif_data.make} #{exif_data.model}"
      exif[:focal_length] = exif_data.focal_length_in_35mm_film
      exif[:aperture] = exif_data.fnumber
      exif[:shutter_speed] = exif_data.exposure_time
      exif[:ISO] = exif_data.iso_speed_ratings
      exif[:software] = exif_data.software
      exif[:resolution] = "#{exif_data.pixel_x_dimension}x#{exif_data.pixel_y_dimension}"
    rescue
      exif = nil
    end

    exif
  end

  INSTAGRAM_FILTERS = [
    '',
    '1977',
    'Aden',
    'Amaro',
    'Ashby',
    'Brannan',
    'Brooklyn',
    'Charmes',
    'Clarendon',
    'Crema',
    'Dogpatch',
    'Earlybird',
    'Gingham',
    'Ginza',
    'Hefe',
    'Helena',
    'Hudson',
    'Inkwell',
    'Kelvin',
    'Juno',
    'Lark',
    'Lo-Fi',
    'Ludwig',
    'Maven',
    'Mayfair',
    'Moon',
    'Nashville',
    'Perpetua',
    'Poprocket',
    'Reyes',
    'Rise',
    'Sierra',
    'Skyline',
    'Slumber',
    'Stinson',
    'Sutro',
    'Toaster',
    'Valencia',
    'Vesper',
    'Walden',
    'Willow',
    'X-Pro II',
  ]

  class << self
    def options_for_filter
      filter_for_options = {}
      INSTAGRAM_FILTERS.each_with_index do |f, i|
        filter_for_options[f] = i
      end
      filter_for_options
    end
  end

  def filter_name
    return '' if filter.nil? || filter < 0 || filter >= INSTAGRAM_FILTERS.size

    name = INSTAGRAM_FILTERS[filter]
    if name == 'Lo-Fi'
      'filter-lofi'
    elsif name == 'X-Pro II'
      'filter-xpro-ii'
    else
      'filter-' + name.downcase
    end
  end
end
