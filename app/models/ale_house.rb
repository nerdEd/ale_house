require 'uri'
class AleHouse < ActiveRecord::Base
  belongs_to :neighborhood
  default_scope :order => :name
  has_many :likes
  validates_presence_of :name, :address, :lat, :long, :description

  def neighborhood_name
    neighborhood.name
  end
  
  def liked_by?(username)
    !likes.count(:conditions => {:created_by => username}).zero?
  end

  def map_url()
    "http://maps.google.com/maps?z=16&q=#{lat}+#{long}+(#{escape_parameters()})&mrt=yp&sensor=false"
  end

  def escape_parameters()
    URI.escape("#{name.gsub('&', ' and ')} #{address}")
  end

end
