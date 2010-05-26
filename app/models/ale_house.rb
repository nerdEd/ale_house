class AleHouse < ActiveRecord::Base
  belongs_to :neighborhood
  default_scope :order => :name
  has_many :likes
  validates_presence_of :name, :address, :lat, :long, :description

  def neighborhood_name
    neighborhood.name
  end

  def map_url
    #http://maps.google.com/maps?q=koopers+tavern,Baltimore,Fells+Point,MD&sensor=false
    "http://maps.google.com/maps?q=#{name},#{neighborhood_name},Baltimore,MD&sensor=false"
  end
end
