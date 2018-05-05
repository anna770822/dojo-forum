class ChangeCommentCountsDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:users, :comment_counts, 0)
  end
end
