class PostAuthorityDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:posts, :authority, "All")
  end
end
