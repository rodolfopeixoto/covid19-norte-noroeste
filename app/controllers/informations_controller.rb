class InformationsController < ApplicationController
  def import
    Information.import(params[:file])
    redirect_to root_url, notice: 'COVID-19 Information imported.'
  end
end
