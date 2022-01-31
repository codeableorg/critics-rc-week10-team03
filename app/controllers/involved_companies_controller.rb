class InvolvedCompaniesController < ApplicationController
  before_action :set_game, only: %i[create destroy]

  def create
    @game = Game.find(params[:game_id])
    @company = Company.find(params[:involved_company][:id])
    if params[:commit] == "Add Publisher"
      @game.involved_companies.create(game: @game, company: @company, publisher: true,
                                      developer: false)
    elsif params[:commit] == "Add Developer"
      @game.involved_companies.create(game: @game, company: @company, developer: true,
                                      publisher: false)
    end
    redirect_to game_path(@game)
  end

  def destroy
    @game = Game.find(params[:game_id])
    @involved_company = @game.involved_companies.find(params[:id])
    @game.involved_companies.destroy(@involved_company)
    redirect_to root_path, notice: "Company was successfully destroyed."
  end

  def set_game
    @game = Game.find(params[:game_id])
  end
end
