class AddLikeToPlayer < ActiveRecord::Migration[5.1]
  def change
    add_column :players, :like, :integer, default: 0
  end
end
