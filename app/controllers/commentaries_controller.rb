class CommentariesController < ApplicationController
  before_action :set_commentary, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /commentaries or /commentaries.json
  def index
    @commentaries = Commentary.all
  end

  # GET /commentaries/1 or /commentaries/1.json
  def show
  end

  # GET /commentaries/new
  def new
    @commentary = Commentary.new
    @post_id = params[:post_id]
    p @post_id
    p "is gere"
  end

  # GET /commentaries/1/edit
  def edit
  end

  # POST /commentaries or /commentaries.json
  def create
    @commentary = Commentary.new(commentary_params)

    respond_to do |format|
      if @commentary.save
        format.html { redirect_to @commentary, notice: "Commentary was successfully created." }
        format.json { render :show, status: :created, location: @commentary }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @commentary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commentaries/1 or /commentaries/1.json
  def update
    respond_to do |format|
      if @commentary.update(commentary_params)
        format.html { redirect_to @commentary, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @commentary }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @commentary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commentaries/1 or /commentaries/1.json
  def destroy
    @post_id = @commentary.post_id
    @commentary.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@post_id), notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commentary
      @commentary = Commentary.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def commentary_params
      params.require(:commentary).permit(:content, :user_id, :post_id)
    end
end
