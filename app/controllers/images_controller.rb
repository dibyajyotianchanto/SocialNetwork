class ImagesController < ApplicationController
  before_action :set_image, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /images or /images.json
  def index
    format.html { redirect_to user_path(current_user.id), notice: "Profile picture was successfully created." }
  end

  # GET /images/1 or /images/1.json
  def show
    format.html { redirect_to user_path(@image.user), notice: "Profile picture was successfully created." }
  end

  # GET /images/new
  def new
    @image = Image.new
    @image.user = current_user
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images or /images.json
  def create
    @image = Image.new(image_params)
    @image.user = current_user
    Image.where(user_id: current_user.id).destroy_all
    respond_to do |format|
      if @image.save
        format.html { redirect_to user_path(current_user), notice: "Profile picture was successfully created." }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1 or /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to user_path(@image.user_id), notice: "Profile picture was successfully updated." }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1 or /images/1.json
  def destroy
    if @image.user!=current_user
      format.html { redirect_to user_path(@image.user_id), alert: "You cannot delete other's profile picture" }
    else
    @image.destroy
    respond_to do |format|
      format.html { redirect_to user_path(@image.user_id), notice: "You have succesfully deleted the profile picture" }
      format.json { head :no_content }
    end
  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def image_params
      params.require(:image).permit(:name, :picture)
    end
end
