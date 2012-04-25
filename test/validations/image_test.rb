require 'pry'
require 'test_helper'

describe "Image Validation" do

  VALID_IMAGES = [ { :format => :jpeg,
                     :file   => '/Users/rmichael/Desktop/me.jpg' },
                   { :format => :tiff,
                     :file   => '/Users/rmichael/Desktop/me.tiff' },
                   { :format => :png,
                     :file   => '/Users/rmichael/Desktop/me.png' } ]

  VALID_IMAGES.each do |image|

    # Test single image type validations, ex. ":format => :jpeg".
    describe "format: #{image[:format]}" do
      it "accepts #{image[:format]} format" do
        subject = build_image_record(image[:format], { :image => image[:file] })
        subject.valid?.must_equal true
        subject.errors.size.must_equal 0
      end

      it "rejects other formats" do
        # Test rejection using an image which is NOT the type of the validation currently being tested.
        invalid_image = VALID_IMAGES.detect { |i| i[:format] != image[:format] }

        subject = build_image_record(image[:format], { :image => invalid_image[:file] })
        subject.valid?.must_equal false
        subject.errors.size.must_equal 1
      end
    end

    describe "format :any" do
      it "accepts any of the known image types" do
        subject = build_image_record(:any, { :image => image[:file] })
        subject.valid?.must_equal true
        subject.errors.size.must_equal 0
      end
    end

  end

  def build_image_record(format, attributes = {})
    # TODO: What are these doing?
    TestRecord.reset_callbacks(:validate)
    TestRecord.validates :image, :image => { :format => format }

    TestRecord.new attributes
  end
end
