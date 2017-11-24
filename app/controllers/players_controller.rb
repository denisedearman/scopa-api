class PlayersController < ApplicationController

  def create
    @player = Player.new(player_params)

    if @player.save
      render json: @player.as_json
    else
      render json: {error: 'Unable to save player.'}
    end
  end

  def index
    @players = Player.all
    render json: @players.as_json
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end
end
