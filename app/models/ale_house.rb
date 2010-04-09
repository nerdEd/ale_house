class AleHouse < ActiveRecord::Base
  validates_presence_of :name, :address
  belongs_to :neighborhood
end