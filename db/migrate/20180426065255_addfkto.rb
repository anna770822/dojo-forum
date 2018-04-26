class Addfkto < ActiveRecord::Migration[5.1]
  def change
    add_column :category_posts, :post_id, :integer
    add_column :category_posts, :category_id, :integer
  end
end
