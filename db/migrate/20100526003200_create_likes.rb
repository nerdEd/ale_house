class CreateLikes < ActiveRecord::Migration
  def self.up
    create_table :likes do |t|
      t.integer :ale_house_id
      t.string :created_by
      t.timestamps
    end
  end

  def self.down
    drop_table :likes
  end
end
