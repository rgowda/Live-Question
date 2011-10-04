class AddActivityIndexToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :activity, :integer
  end
end
