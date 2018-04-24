class RenamePostTittle < ActiveRecord::Migration[5.1]
  def change
    rename_column :posts, :tittle, :title
  end
end
