class CovidInformationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_covid_information, only: %i[show edit update destroy]

  def index
    @covid_informations = CovidInformation.includes(:city).order('date_reference desc').page(params[:page])
  end

  def show; end

  def new
    @covid_information = CovidInformation.new
  end

  def edit; end

  def create
    @covid_information = CovidInformation.new(covid_information_params)

    respond_to do |format|
      if @covid_information.save
        format.html { redirect_to @covid_information, notice: 'Informações cadastradas com sucesso.' }
        format.json { render :show, status: :created, location: @covid_information }
      else
        format.html { render :new }
        format.json { render json: @covid_information.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @covid_information.update(covid_information_params)
        format.html { redirect_to @covid_information, notice: 'Informações atualizadas com sucesso.' }
        format.json { render :show, status: :ok, location: @covid_information }
      else
        format.html { render :edit }
        format.json { render json: @covid_information.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @covid_information.destroy
    respond_to do |format|
      format.html { redirect_to covid_informations_url, notice: 'Informações removidas com sucesso.' }
      format.json { head :no_content }
    end
  end

  def import
    covid_valid, covid_errors = CovidInformation.import(params[:file])
    if covid_valid
      redirect_to covid_informations_path, notice: 'Planilha importada com sucesso'
    else
      @errors = covid_errors
      redirect_to covid_informations_path
    end
  end

  private

  def set_covid_information
    @covid_information = CovidInformation.find(params[:id])
  end

  def covid_information_params
    params.require(:covid_information).permit(:date_reference, :suspected, :confirmed, :home_isolation, :hospitalized, :discarded, :deaths, :heal, :city_id)
  end
end
