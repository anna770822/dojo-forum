class Viewcountdefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:posts, :view_counts, 0)
  end
end
