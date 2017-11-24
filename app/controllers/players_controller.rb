class PlayersController < ApplicationController
  before_action :set_player, only: [:show]
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

  def show
    render json: @player.as_json
  end

  private

  def set_player
    @player = Player.find_by(id: params[:id])
  end

  def player_params
    params.require(:player).permit(:name)
  end
end
