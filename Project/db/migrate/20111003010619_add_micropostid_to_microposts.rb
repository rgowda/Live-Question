class AddMicropostidToMicroposts < ActiveRecord::Migration
  def self.up
    add_column :microposts, :micropost_id, :integer
  end

  def self.down
    remove_column :microposts, :micropost_id
  end
end
