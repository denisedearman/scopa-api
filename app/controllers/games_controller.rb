class GamesController < ApplicationController
  before_action :set_game, only: [:show]
  def index
    render json: Game.all
  end

  def create
    @game = Game.new(game_params)
    @game.complete = false;
    binding.pry
    if @game.save
      render json: {"game_id" => @game.id,"player_1" => @game.players[0].name, "player_2" => @game.players[1].name}.to_json
    else
      render json: {error: 'Unable to save Game.'}
    end
  end

  def show
    render json: {"game_id" => @game.id, "player_1" => @game.players[0].name, "player_2" => @game.players[1].name}.to_json
  end

  private

  def set_game
    @game = Game.find_by(id: params[:id])
  end

  def game_params
    params.require(:game).permit(:player_1, :player_2, cards: [])
  end

end
