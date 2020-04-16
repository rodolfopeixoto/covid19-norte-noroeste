class CovidInformationsController < ApplicationController
  before_action :set_covid_information, only: [:show, :edit, :update, :destroy]

  # GET /covid_informations
  # GET /covid_informations.json
  def index
    @covid_informations = CovidInformation.all
  end

  # GET /covid_informations/1
  # GET /covid_informations/1.json
  def show
  end

  # GET /covid_informations/new
  def new
    @covid_information = CovidInformation.new
  end

  # GET /covid_informations/1/edit
  def edit
  end

  # POST /covid_informations
  # POST /covid_informations.json
  def create
    @covid_information = CovidInformation.new(covid_information_params)

    respond_to do |format|
      if @covid_information.save
        format.html { redirect_to @covid_information, notice: 'Covid information was successfully created.' }
        format.json { render :show, status: :created, location: @covid_information }
      else
        format.html { render :new }
        format.json { render json: @covid_information.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /covid_informations/1
  # PATCH/PUT /covid_informations/1.json
  def update
    respond_to do |format|
      if @covid_information.update(covid_information_params)
        format.html { redirect_to @covid_information, notice: 'Covid information was successfully updated.' }
        format.json { render :show, status: :ok, location: @covid_information }
      else
        format.html { render :edit }
        format.json { render json: @covid_information.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /covid_informations/1
  # DELETE /covid_informations/1.json
  def destroy
    @covid_information.destroy
    respond_to do |format|
      format.html { redirect_to covid_informations_url, notice: 'Covid information was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_covid_information
      @covid_information = CovidInformation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def covid_information_params
      params.require(:covid_information).permit(:date_reference, :suspected, :confirmed, :home_isolation, :hospitalized, :discarded, :deaths, :city_id)
    end
end
