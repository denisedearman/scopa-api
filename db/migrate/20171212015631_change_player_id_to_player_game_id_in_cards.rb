class ChangePlayerIdToPlayerGameIdInCards < ActiveRecord::Migration[5.1]
  def change
    rename_column :cards, :player_id, :player_game_id
  end
end
