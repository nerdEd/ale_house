class AleHouse < ActiveRecord::Base
  validates_presence_of :name, :address, :lat, :long, :description
  belongs_to :neighborhood
  
  def neighborhood_name()
    neighborhood().name()
  end

  def map_url()

#http://maps.google.com/maps?q=koopers+tavern,Baltimore,Fells+Point,MD&sensor=false
    "http://maps.google.com/maps?q=#{name},#{neighborhood_name},Baltimore,MD&sensor=false"
  end
end
