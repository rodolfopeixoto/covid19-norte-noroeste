json.extract! covid_information, :id, :date_reference, :suspected, :confirmed, :home_isolation, :hospitalized, :discarded, :deaths, :city_id, :created_at, :updated_at
json.url covid_information_url(covid_information, format: :json)
