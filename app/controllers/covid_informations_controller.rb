class CovidInformationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = CovidInformation.ransack(params[:q])
    @covid_informations = @q.result.includes(:city).order('date_reference desc').page(params[:page])
  end

  def show
    @covid_information = CovidInformation.find(params[:id])
  end

  def new
    @covid_information = CovidInformation.new
  end

  def edit
    @covid_information = CovidInformation.find(params[:id])
  end

  def create
    @covid_information = CovidInformation.new(covid_information_params)

    respond_to do |format|
      if @covid_information.save
        format.html { redirect_to @covid_information, notice: 'Os dados foram cadastrados com sucesso.' }
        format.json { render :show, status: :created, location: @covid_information }
      else
        format.html { render :new }
        format.json { render json: @covid_information.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @covid_information = CovidInformation.find(params[:id])
    respond_to do |format|
      if @covid_information.update(covid_information_params)
        format.html { redirect_to @covid_information, notice: 'Dados da covid atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @covid_information }
      else
        format.html { render :edit }
        format.json { render json: @covid_information.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @covid_information = CovidInformation.find(params[:id])
    @covid_information.destroy
    respond_to do |format|
      format.html { redirect_to covid_informations_url, notice: 'O dado for exclúido com sucesso.' }
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
    params.require(:covid_information).permit(:date_reference, :suspected, :confirmed, :home_isolation, :hospitalized, :discarded, :deaths, :heal, :city_id, :positive_active)
  end
end
