class AddPointsAwardedToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :points_awarded, :boolean, default: false
  end
end
