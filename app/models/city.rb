class City < ApplicationRecord
  belongs_to :region
  has_many :covid_informations
end
