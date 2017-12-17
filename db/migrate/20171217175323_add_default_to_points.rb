class AddDefaultToPoints < ActiveRecord::Migration[5.1]
  def change
    change_column :player_games, :points, :integer, default: 0
  end
end
