class ChangeUserColumnDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:users, :role, "Normal")
  end
end
