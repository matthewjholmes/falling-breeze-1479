require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plot_plants).through(:plots) }
    it { should have_many(:plants).through(:plot_plants) }
  end

  describe 'model methods' do
    it '#fast_harvest_plants returns gardens plants that take <100 days to harvest' do
      garden = Garden.create!(name: 'Garden 1', organic: true)
      plot = garden.plots.create!(number: 1, size: 'big', direction: 'north')
      plant1 = plot.plants.create!(name: 'Plant 1', description: 'hardy', days_to_harvest: 11)
      plant2 = plot.plants.create!(name: 'Plant 2', description: 'hardy', days_to_harvest: 22)
      plant3 = plot.plants.create!(name: 'Plant 3', description: 'fragile', days_to_harvest: 333)
      
      expect(garden.fast_harvest_plants).to eq([plant1, plant2])
    end
  end
end
