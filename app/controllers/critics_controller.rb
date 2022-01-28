class CriticsController < ApplicationController
  before_action :set_critic, only: %i[ show edit update destroy ]

  # GET /critics or /critics.json
  def index
    @critics = Critic.all
  end

  # GET /critics/1 or /critics/1.json
  def show
  end

  # GET /critics/new
  def new
    @critic = Critic.new
  end

  # GET /critics/1/edit
  def edit
  end

  # POST /critics or /critics.json
  def create
    @critic = Critic.new(critic_params)

    respond_to do |format|
      if @critic.save
        format.html { redirect_to critic_url(@critic), notice: "Critic was successfully created." }
        format.json { render :show, status: :created, location: @critic }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @critic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /critics/1 or /critics/1.json
  def update
    respond_to do |format|
      if @critic.update(critic_params)
        format.html { redirect_to critic_url(@critic), notice: "Critic was successfully updated." }
        format.json { render :show, status: :ok, location: @critic }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @critic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /critics/1 or /critics/1.json
  def destroy
    @critic.destroy

    respond_to do |format|
      format.html { redirect_to critics_url, notice: "Critic was successfully destroyed." }
      format.json { head :no_content }
    end
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
