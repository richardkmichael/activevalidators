require 'pry'

module ActiveModel
  module Validations
    binding.pry
    class ImageValidator < EachValidator

      # validates :foo, :image, :format => { :only => :jpg }
      # validates :foo, :image, :format => { :only => [ :jpg, :png ] }
      # validates :foo, :image, :format => { :except => :tiff }
      # validates :foo, :image, :format => { :except => [ :jpg, :png ] }
      # validates :foo, :image, :dimensions => '200x300'  # Pixels
      # validates :foo, :image, :width  => '150'          # Pixels
      # validates :foo, :image, :height => '300'          # Pixels
      # validates :foo, :image, :filesize => { :maximum => '1MB' }  # Better handled by the uploader?

      begin
        require 'mini_magick'
      rescue LoadError => e
        puts 'MiniMagick not available, falling back to byte header inspection.'
        # http://www.mikekunz.com/image_file_header.html
        USE_BYTE_HEADERS = true
      end

      def initialize(options)

      end

      # [10] pry(main)> i.identify
      # => "/tmp/file.jpg JPEG 200x200 200x200+0+0 8-bit DirectClass 6.78KB 0.000u 0:00.000\n"
      # filename, format, dimensions, geometry, depth, class, filesize, user_time, elapsed_time
      #
      # attributes
      #   format
      #   dimensions
      #   filesize
      #
      def validate_each(record, attribute, value)
        binding.pry
        # image = ImageMagick::Image.open(value)
      end

      def check_validity!

      end
    end
  end
end
