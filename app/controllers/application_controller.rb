class ApplicationController < ActionController::Base
  layout :layout_by_resource

  private

  def after_sign_in_path_for(resource)
    covid_informations_path
  end

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
end
