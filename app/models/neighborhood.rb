class Neighborhood < ActiveRecord::Base
  validates_presence_of :name
  has_many :ale_houses
  
  def self.new_ale_house(id)
    find(id).new_ale_house()
  end
  
  def new_ale_house()
    ale_houses().new()
  end
  
end