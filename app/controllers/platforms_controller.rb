class PlatformsController < ApplicationController
  before_action :set_game, only: %i[create]

  def create
    @game = Game.find(params[:game_id])
    @platform = Platform.find(params[:platform][:id])
    @game.platforms << @platform
    redirect_to game_path(@game)
  end

  def destroy
    @game = Game.find(params[:game_id])
    @platform = @game.platforms.find(params[:id])
    @game.platforms.destroy(@platform)
    redirect_to root_path, notice: "Genre was successfully destroyed."
  end

  def set_game
    @game = Game.find(params[:game_id])
  end
end
