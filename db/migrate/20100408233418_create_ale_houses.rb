class CreateAleHouses < ActiveRecord::Migration
  def self.up
    create_table :ale_houses do |t|
      t.string :name
      t.text :description
      t.integer :neighborhood_id
      t.string :address
      t.string :city
      t.string :zip
      t.float :lat
      t.float :long
      
      t.timestamps
    end
  end

  def self.down
    drop_table :ale_houses
  end
end
