require 'mini_magick'

module ActiveModel
  module Validations
    class ImageValidator < EachValidator

      # validates :foo, :image, :format => { :only => :jpg }
      # validates :foo, :image, :format => { :only => [ :jpg, :png ] }
      # validates :foo, :image, :format => { :except => :tiff }
      # validates :foo, :image, :format => { :except => [ :jpg, :png ] }
      # validates :foo, :image, :dimensions => '200x300'  # Pixels
      # validates :foo, :image, :dimensions => '200 x 300'  # Pixels
      # validates :foo, :image, :dimensions => '200 X 300'  # Pixels
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

      # [10] pry(main)> i.identify
      # => "/tmp/file.jpg JPEG 200x200 200x200+0+0 8-bit DirectClass 6.78KB 0.000u 0:00.000\n"
      # filename, format, dimensions, geometry, depth, class, filesize, user_time, elapsed_time

      ATTRIBUTES = %q| format dimensions width height filesize |

      def validate_each(record, attribute, value)

        begin
          @image = MiniMagick::Image.open(value)
        rescue Exception => e
          # TODO: Properly handle any errors from ImageMagick:
          #   -file not found
          #   -file unreadable [corruption, etc.]
          raise "Could not process image: #{e.message}"
        end

        @format     = options[:format]
        @dimensions = options[:dimensions]
        @width      = options[:width]
        @height     = options[:height]

        if @format
          record.errors.add(attribute) unless image_is_required_format?
        end

        if @dimensions
          record.errors.add(attribute) unless image_is_required_dimensions?
        end

      end

      private

      def image_is_required_format?
        @image[:format].downcase == @format.to_s.downcase
      end

      def image_is_required_dimensions?
        @image[:dimensions] == @dimensions.split(/x|X/).map { |e| e.to_i }
      end

      # def validates_with
      #
      # end

      # def check_validity!
      #
      # end
    end
  end
end
