require 'rubygems'

# silence warnings
old_w, $-w = $-w, false

require 'minitest/spec'
require 'minitest/mock'
require 'minitest/autorun'

# unsilence warnings
$-w = old_w

require 'activevalidators'

%w(models).each do |directory|
  Dir["#{File.dirname(__FILE__)}/#{directory}/*.rb"].each {|f| require f}
end

class TestRecord

  include ActiveModel::Validations

  attr_accessor :ip, :url, :slug, :image, :responder, :global_condition,
    :local_condition, :phone, :email, :card, :password, :twitter_username,
    :postal_code, :carrier, :tracking_number, :start_date, :end_date

  def initialize(attrs = {})
    attrs.each_pair { |k,v| send("#{k}=", v) }
  end

end
