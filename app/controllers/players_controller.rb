class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update]
  def create
    @player = Player.new(player_params)

    if @player.save
      render json: @player
    else
      render json: {error: 'Unable to save player.'}
    end
  end

  def edit
    if params[:game_id]
      game = Game.find_by(id: params[:game_id])
      current_player = game.get_current_player
      if current_player.id == @player.id
          render json: {"hand" => @player.hand, "table" => game.on_table}.to_json
      else
        render json: "Not your turn!"
      end
    end
  end

  def index
    render json: Player.all
  end

  def show
    if params[:game_id]
      game = Game.find_by(id: params[:game_id])
      current_player = game.get_current_player
      if current_player.id == @player.id
        render json: {"player_id" => @player.id, "name" => @player.name, "turn" => true}.to_json
      else
        render json: {"player_id" => @player.id, "name" => @player.name, "turn" => false}.to_json
      end
    else
      render json: @player
    end
  end

  def update
    if params[:game_id]
      game = Game.find_by(id: params[:game_id])
      current_player = game.get_current_player
      if current_player.id == @player.id
        player_game = PlayerGame.find_by(player_id: @player.id, game_id: game.id)
        if player_game.play_move(params[:player][:play_hand], params[:player][:play_table])
          player_game.save
          game.save
          @player = game.players.select{|player| player.id != @player.id}.first
          render json: {"player_id" => @player.id, "name" => @player.name, "turn" => true}.to_json
        end
      else
        render json: {"player_id" => @player.id, "name" => @player.name, "turn" => false}.to_json
      end
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
