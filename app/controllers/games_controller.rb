class GamesController < ApplicationController
  before_action :set_game, only: [:show, :play, :summary]
  def index
    render json: Game.all
  end

  def play
    if @game.deck.length == 0
      render json: "End of Round"
    else
      render json: @game.get_current_player
    end
  end

  def create
    @game = Game.new(game_params)
    @game.complete = false;
    if @game.save
      @game.deal
      render json: {"game_id" => @game.id,"player_1" => @game.players[0].name, "player_2" => @game.players[1].name, "cards" => @game.cards}.to_json
    else
      render json: {error: 'Unable to save Game.'}
    end
  end

  def show
    render json: {"game_id" => @game.id, "player_1" => @game.player_games[0].player.name, "player_1_points" => @game.player_games[0].points, "player_2" => @game.player_games[1].player.name, "player_2_points" => @game.player_games[1].points, "cards" => @game.cards}.to_json
  end

  def summary
    if @game.is_end_game?
      @game.award_points
      @game.save
      binding.pry
      render json: {"game_id" => @game.id,
        "status" => "end",
         "player_1" => @game.player_games[0].player.name,
         "player_1_points" => @game.player_games[0].points,
         "player_1_scopa" => @game.player_games[0].scopa_count,
         "player_1_captured" => @game.player_games[0].player.captures,
         "player_2" => @game.player_games[1].player.name,
         "player_2_points" => @game.player_games[1].points,
         "player_2_scopa" => @game.player_games[1].scopa_count,
         "player_2_captured" => @game.player_games[1].player.captures,
         "most_cards" => @game.player_with_most_cards,
         "most_coins" => @game.player_with_most_coins,
         "prime" => @game.prime_winner,
         "sette_bello" => @game.sette_bello,
         "table" => @game.on_table}.to_json
    else
      render json: {"game_id" => @game.id, "status" => "in_progress", "player_1" => @game.player_games[0].player.name, "player_1_points" => @game.player_games[0].points, "player_2" => @game.player_games[1].player.name, "player_2_points" => @game.player_games[1].points, "cards" => @game.cards}.to_json
    end
  end

  private

  def set_game
    @game = Game.find_by(id: params[:id])
  end

  def game_params
    params.require(:game).permit(:player_1, :player_2, cards: [])
  end

end
