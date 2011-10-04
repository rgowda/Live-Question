class CreateSearchengines < ActiveRecord::Migration
  def change
    create_table :searchengines do |t|
      t.string :content

      t.timestamps
    end
  end
end
