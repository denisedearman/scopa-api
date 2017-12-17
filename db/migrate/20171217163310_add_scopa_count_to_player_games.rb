class AddScopaCountToPlayerGames < ActiveRecord::Migration[5.1]
  def change
    add_column :player_games, :scopa_count, :integer, :default => 0
  end
end
