require 'rails_helper'

RSpec.describe 'plots index page' do
  before do
    @garden1 = Garden.create!(name: 'Garden 1', organic: true)

    @plot1 = @garden1.plots.create!(number: 1, size: 'big', direction: 'north')
    @plot2 = @garden1.plots.create!(number: 2, size: 'medium', direction: 'south')
    @plot3 = @garden1.plots.create!(number: 3, size: 'small', direction: 'east')

    @plant1 = @plot1.plants.create!(name: 'Plant 1', description: 'hardy', days_to_harvest: 11)
    @plant2 = @plot1.plants.create!(name: 'Plant 2', description: 'hardy', days_to_harvest: 22)
    @plant3 = @plot2.plants.create!(name: 'Plant 3', description: 'fragile', days_to_harvest: 33)
    @plant4 = @plot2.plants.create!(name: 'Plant 4', description: 'fragile', days_to_harvest: 44)
    @plant5 = @plot3.plants.create!(name: 'Plant 5', description: 'purple', days_to_harvest: 55)
    @plant6 = @plot3.plants.create!(name: 'Plant 6', description: 'blue', days_to_harvest: 66)

    visit plots_path
  end

    it 'when i visit the plots index page' do
      expect(current_path).to eq(plots_path)
    end

    it 'i see a list of all plot numbers' do
      expect(page).to have_content('Plot 1')
      expect(page).to have_content('Plot 2')
      expect(page).to have_content('Plot 3')
    end

    it 'under each plot number i see all that plots plants' do
      within("#plot-#{@plot1.id}") do
        expect(page).to have_content(@plant1.name)
        expect(page).to have_content(@plant2.name)
      end
    end
end
