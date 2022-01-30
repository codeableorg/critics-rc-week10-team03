class GamesController < ApplicationController
  before_action :set_game, only: %i[show edit update destroy]

  # GET /games or /games.json
  def index
    @games = Game.all
  end

  # GET /games/1 or /games/1.json

  def show
    @critic = Critic.new
    @critics = @game.critics
    @genres = Genre.all
    @genre = Genre.new
    @platform = Platform.new
    @platforms = Platform.all
    @companies = Company.all
    @involved_company = InvolvedCompany.new
  end

  # GET /games/new
  def new
    @game = Game.new
    @games = Game.all
  end

  # GET /games/1/edit
  def edit
    @games = Game.all
  end

  # POST /games or /games.json
  def create
    @game = Game.new(game_params)

    if @game.save
      redirect_to root_path, notice: "Game was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /games/1 or /games/1.json
  def update
    if @game.update(game_params)
      redirect_to root_path, notice: "Game was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /games/1 or /games/1.json
  def destroy
    @game.destroy
    redirect_to root_path, notice: "Game was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def game_params
    params.require(:game).permit(:name, :summary, :release_date, :category, :rating, :cover,
                                 :game_id, :parent_id)
  end
end
