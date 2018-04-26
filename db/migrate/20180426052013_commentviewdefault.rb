class Commentviewdefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:posts, :comment_counts, 0)
  end
end
