class HousesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_house, only: [:show, :edit, :update, :destroy]

  # GET /houses
  # GET /houses.json
  def index
    @houses = HouseQuery.call(params)
    authorize @houses
  end

  # GET /houses/1
  # GET /houses/1.json
  def show
    authorize @house
  end

  def start_search
    @search = { }
  end

  def search
    query_params = { }

    if !params[:min_price].blank?
      query_params[:min_price] = params[:min_price];
    end

    if !params[:max_price].blank?
      query_params[:max_price] = params[:max_price];
    end

    if !params[:min_square_footage].blank?
      query_params[:min_square_footage] = params[:min_square_footage];
    end

    if !params[:max_square_footage].blank?
      query_params[:max_square_footage] = params[:max_square_footage];
    end

    if !params[:floors].blank?
      query_params[:floors] = params[:floors];
    end

    redirect_to houses_path(query_params)
  end

  # GET /houses/new
  def new
    @house = House.new
    authorize @house
  end

  # GET /houses/1/edit
  def edit
    authorize @house
  end

  # POST /houses
  # POST /houses.json
  def create
    @house = House.new(house_params)
    authorize @house
    @house.image_path.attach(params[:house][:image_path])

    respond_to do |format|
      if @house.save
        format.html { redirect_to @house, notice: 'House was successfully created.' }
        format.json { render :show, status: :created, location: @house }
      else
        format.html { render :new }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /houses/1
  # PATCH/PUT /houses/1.json
  def update
    authorize @house
    @house.image_path.attach(params[:house][:image_path])

    respond_to do |format|
      if @house.update(house_params)
        format.html { redirect_to @house, notice: 'House was successfully updated.' }
        format.json { render :show, status: :ok, location: @house }
      else
        format.html { render :edit }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /houses/1
  # DELETE /houses/1.json
  def destroy
    authorize @house

    @house.destroy
    respond_to do |format|
      format.html { redirect_to houses_url, notice: 'House was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_house
      @house = House.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def house_params
      params.require(:house).permit(:company_id, :location, :area, :year_built, :style, :price, :floors, :has_basement, :owner, :phone, :email, :user_id)
    end
end
