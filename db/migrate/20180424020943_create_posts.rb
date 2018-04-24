class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :tittle
      t.text :content
      t.string :image
      t.string :authority
      t.integer :comment_counts
      t.integer :view_counts
      t.timestamps
    end
  end
end
