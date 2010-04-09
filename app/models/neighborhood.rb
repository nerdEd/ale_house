class Neighborhood < ActiveRecord::Base
  validates_presence_of :name
  has_many :ale_houses
end