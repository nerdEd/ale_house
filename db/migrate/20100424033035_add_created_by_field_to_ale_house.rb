class AddCreatedByFieldToAleHouse < ActiveRecord::Migration
  def self.up
    add_column :ale_houses, :created_by, :string
  end

  def self.down
    remove_column :ale_houses, :created_by
  end
end
