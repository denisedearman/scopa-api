class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.string :suit
      t.integer :value
      t.integer :points
      t.boolean :in_deck
      t.boolean :captured
      t.integer :player_id
      t.integer :game_id
    end
  end
end
