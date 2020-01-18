require 'spec_helper'
require 'pry'
require_relative '../lib/tool'
require_relative '../lib/garden'


describe Garden do
  before {
      @fidjis = Fidjis.new
  }
  let (:carrot) { @fidjis.get('carrot') }
  let (:cabbage) { @fidjis.get('cabbage') }

  let (:garden) { Garden.new(
    name: garden_name) }
  
  context 'one plot garden' do
    let (:garden_name) { 'One Plot' }

    describe 'initialize' do
      it 'should have a key' do
        expect(garden.key).to eq('one_plot')
      end

      it 'should have one plot' do
        expect(garden.plots.count).to eq(1)
      end

      it 'should have 4 boxes' do
        expect(garden.boxes.count).to eq(4)
      end


      # there are two cases
      # 1. the garden is not yet planted
      #  and doesnt have any previous season
      # 2. the garden is already planted
      # and have one or more previous season

      # the goal of this program is to
      # prepare a new season based on the 
      # previous seasons


      it 'should have 0 past crops' do
        expect(garden.crops.count).to eq(0)
      end
    end

    describe 'prepare_next_seasons' do
      let (:season) { '2018-winter' }
      let (:season_text_file) { Pathname.new("/data/gardens/#{garden.key}/seasons/#{season}.txt") }      

      it 'should return the next seasons' do
        next_seasons = garden.next_seasons_from(start: season)
        # wrong
        # it should as well return 2018-winter
        # the parameter start means that we start with this season
        # expect(next_seasons).to eq(['2018-summer', '2019-winter', '2019-summer', '2020-winter'])
      end

      it 'should prepare a season' do
        # garden.prepare_season season
        # expect(season_text_file.exist?).to be_falsy
      end
    end

    describe 'number_of' do
      
      it 'should have 3 carrots in the garden' do
        garden.plots.first.boxes.first.fill_minimum_with(carrot)
        count = garden.count_number_of('carrot')
        expect(count).to eq(3)
      end

      it 'should have 1 cabbage in the garden' do
        garden.plots.first.boxes.first.fill_minimum_with(cabbage)
        count = garden.count_number_of('cabbage')
        expect(count).to eq(1)
      end

    end

    describe 'load_past_crop' do
      let (:crop_file) { "2017-summer.txt" }

      it 'should add a past crop to the garden' do
        garden.load_past_crop(crop_file)

        expect(garden.crops.count).to eq(1)
        expect(garden.crops[0][:planting_day]).to eq(Date.parse('16/09/2017'))
      end

    end
  end

  context 'Khanysia garden' do
    let (:garden_name) { 'Khanysia' }
    
    describe 'boxes' do
      it 'should have a lot of boxes' do
        expect(garden.boxes.count).to eq(756)
      end
    end
    
    describe 'crops' do  
      let (:nursery_plot_1) { garden.plots.find { |plot| plot.id == "nursery-1" } }

      it 'should have one past crop' do
        expect(garden.crops.count).to eq(1)        
        expect(nursery_plot_1.crops.count).to eq(1)
        expect(nursery_plot_1.crops.first.families).to eq(['apia', 'brassica'])
        
      end

      it 'should display past_crops' do
        garden.past_crops
      end
    end

    describe 'prepare' do
      it 'should prepare a garden' do
        # SUCCESS
        garden.prepare
      end
    end

    describe 'compost_need' do
      it 'should return a big number' do
        sum = 0
        compost_need = garden.plots.count do |plot|
          sum += plot.compost_need
        end

        puts sum
      end
    end
  end

end