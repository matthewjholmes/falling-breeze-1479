require 'rails_helper'

RSpec.describe 'garden show page' do
  before do
    @garden1 = Garden.create!(name: 'Garden 1', organic: true)

    @plot1 = @garden1.plots.create!(number: 1, size: 'big', direction: 'north')
    @plot2 = @garden1.plots.create!(number: 2, size: 'medium', direction: 'south')
    @plot3 = @garden1.plots.create!(number: 3, size: 'small', direction: 'east')

    @plant1 = @plot1.plants.create!(name: 'Plant 1', description: 'hardy', days_to_harvest: 11)
    @plant2 = @plot1.plants.create!(name: 'Plant 2', description: 'hardy', days_to_harvest: 222)
    @plant3 = @plot2.plants.create!(name: 'Plant 3', description: 'fragile', days_to_harvest: 333)
    @plant4 = @plot2.plants.create!(name: 'Plant 4', description: 'fragile', days_to_harvest: 44)
    @plant5 = @plot3.plants.create!(name: 'Plant 5', description: 'purple', days_to_harvest: 55)
    @plant6 = @plot3.plants.create!(name: 'Plant 6', description: 'blue', days_to_harvest: 66)

    @plot1.plants << @plant6

    visit garden_path(@garden1)
  end

  it 'when i visit a gardens show page' do
    expect(current_path).to eq(garden_path(@garden1))
  end

  it 'i see a list of unique plants from this gardens plots that take <100 days to harvest' do
    expect(page).to have_content(@plant1.name)
    expect(page).to_not have_content(@plant2.name)
    expect(page).to_not have_content(@plant3.name)
    expect(page).to have_content(@plant4.name)
    expect(page).to have_content(@plant5.name)
    expect(page).to have_content(@plant6.name, count: 1)
  end
end
