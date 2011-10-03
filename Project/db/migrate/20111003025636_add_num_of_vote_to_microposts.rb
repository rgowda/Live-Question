class AddNumOfVoteToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :no_of_vote, :integer
  end
end
