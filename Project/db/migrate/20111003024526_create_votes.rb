class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :micropost_id
      t.integer :voter_id

      t.timestamps
    end
  end
end
