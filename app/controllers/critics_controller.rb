class CriticsController < ApplicationController
  before_action :set_critic, only: %i[show edit update destroy]

  # GET /critics or /critics.json
  def index
    @critics = Critic.all
  end

  # GET /critics/1 or /critics/1.json
  def show; end

  # GET /critics/new
  def new
    @critic = Critic.new
  end

  # GET /critics/1/edit
  def edit; end

  # POST /critics or /critics.json
  def create
    @critic = Critic.new(critic_params)
    if params[:company_id]
      @criticable = Company.find(params[:company_id])
    elsif params[:game_id]
      @criticable = Game.find(params[:game_id])
    end

    @critic.criticable = @criticable
    @critic.user = current_user

    if @critic.save
      redirect_to @criticable, notice: "Feedback was successfully created."
    else
      render @criticable, status: :unprocessable_entity
    end
  end

  # DELETE /critics/1 or /critics/1.json
  def destroy
    @critic.destroy
    redirect_to @critic.criticable, notice: "Critic was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_critic
    @critic = Critic.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def critic_params
    params.require(:critic).permit(:title, :body, :user_id, :criticable_id, :criticable_type)
  end
end
