class Like < ActiveRecord::Base
  belongs_to :ale_house
  validates_presence_of :created_by
end
