class GenresController < ApplicationController
  before_action :set_game, only: %i[create]
  
  
  def create  
    @game = Game.find(params[ :game_id ])
    @genre = Genre.find(params[:genre][:id])
    @game.genres << @genre
    redirect_to game_path(@game)
  end

  def destroy
    @game = Game.find(params[:game_id])
    @genre = @game.genres.find(params[:id])
    @game.genres.destroy(@genre)
    redirect_to root_path, notice: "Genre was successfully destroyed."
  end


  def set_game
    @game = Game.find(params[:game_id])
  end
end