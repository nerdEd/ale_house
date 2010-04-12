class CreateNeighborhood < ActiveRecord::Migration
  def self.up
    create_table :neighborhoods do |t|
      t.string :name
      t.text :description
      t.float :lat
      t.float :long
      
      t.timestamps
    end
  end

  def self.down
    drop_table :neighborhoods
  end
end
