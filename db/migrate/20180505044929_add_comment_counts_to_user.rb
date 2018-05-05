class AddCommentCountsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :comment_counts, :integer
  end
end
