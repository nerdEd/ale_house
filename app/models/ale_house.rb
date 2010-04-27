class AleHouse < ActiveRecord::Base
  validates_presence_of :name, :address, :lat, :long, :description
  belongs_to :neighborhood
  
  def neighborhood_name()
    neighborhood().name()
  end
  
end