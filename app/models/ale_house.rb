class AleHouse < ActiveRecord::Base
  validates_presence_of :name, :address, :lat, :long, :description
  belongs_to :neighborhood
  default_scope :order => :name
  
  def neighborhood_name()
    neighborhood().name()
  end
  
end