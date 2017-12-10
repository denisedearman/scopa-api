class GamesController < ApplicationController

  def index
  end

  def create
    @game = Game.new(game_params)
    @game.complete = false;

    if @game.save
      render json: @game
    else
      render json: {error: 'Unable to save Game.'}
    end
  end
  private

  def game_params
    params.require(:game).permit(:player_1, :player_2)
  end

end
