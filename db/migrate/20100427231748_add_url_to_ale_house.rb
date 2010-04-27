class AddUrlToAleHouse < ActiveRecord::Migration
  def self.up
    add_column :ale_houses, :url, :string
  end

  def self.down
    remove_column :ale_houses, :url
  end
end
