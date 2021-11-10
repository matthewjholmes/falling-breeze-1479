class Plant < ApplicationRecord
  has_many :plot_plants, dependent: :destroy
  has_many :plots, through: :plot_plants
end
