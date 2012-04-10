require 'test_helper.rb'

describe "Image Validation" do

  # describe "format: any" do

  # end

  describe "format: jpeg" do

    it "accepts jpeg format" do
      subject = build_image_record :image => '/Users/rmichael/Desktop/me.jpg'
      subject.valid?.must_equal true
      subject.errors.size.must_equal 0
    end

    # it "rejects other formats" do
    # end

  end

  # describe "format: tiff" do
  # end

  # describe "format: png" do
  # end

  def build_image_record(attrs = {}, opts = {})
    # TODO: What are these doing?
    TestRecord.reset_callbacks(:validate)
    TestRecord.validates :image, :image => { :format => :jpeg }

    TestRecord.new attrs
  end
end
