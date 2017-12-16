class PlayersController < ApplicationController
  before_action :set_player, only: [:show]
  def create
    @player = Player.new(player_params)

    if @player.save
      render json: @player
    else
      render json: {error: 'Unable to save player.'}
    end
  end

  def index
    render json: Player.all
  end

  def show
    if params[:game_id]
      render json: {"player_id" => @player.id, "name" => @player.name}.to_json
    else
      render json: @player
    end
  end

  private

  def set_player
    @player = Player.find_by(id: params[:id])
  end

  def player_params
    params.require(:player).permit(:name)
  end
end
