require 'spec_helper'
require 'pry'
require_relative '../lib/tool'
require_relative '../lib/plot'


describe Plot do
  before {
    @fidjis = Fidjis.new
  }
  let (:plot) { Plot.new('plot;194x90;', 1) }
  let (:tomato) { @fidjis.get('tomato') }
  let (:onion) { @fidjis.get('onion') }
  let (:carrot) { @fidjis.get('carrot') }
  let (:cabbage) { @fidjis.get('cabbage') }
  let (:okra) { @fidjis.get('okra') }
  let (:purple_kale) { @fidjis.get('purple kale') }

  it 'should have four boxes' do
    expect(plot.boxes.count).to eq(4)
  end

  it 'should have 0 season' do
    expect(plot.seasons.count).to eq(0)
  end

  it 'should have 2 rows and 2 columns' do
    expect(plot.rows).to eq(2)
    expect(plot.cols).to eq(2)
  end

  it 'should draw the boxes in a plot' do
    draw = plot.draw
    expect(draw).to eq("**\n**\n")
  end

  describe 'box_at' do
    it 'should return nil if out of plot' do
      box = plot.box_at(0, 0)
      expect(box).to be_kind_of BoxOutOfPlot
    end

    it 'should return the first box' do
      box = plot.box_at(1, 1)
      expect(box).to be_kind_of Box
    end    
  end

  describe 'find_available_boxes_for' do
    before {
      @boxes = plot.find_available_boxes_for(fidji)
    }
    context 'plot empty; look for boxes to plant tomato' do
      let (:fidji) { tomato }
      it 'should return 4' do   
        
        expect(@boxes.count).to eq(4)
      end
    end
  end

  describe 'find_and_fill_boxes_for' do
    it 'should fill 4 boxes with one Tomato' do
      plot.find_and_fill_boxes_for(tomato)
      # expect(plot.contains?(tomato)).to be_truthy
      # expect(plot.boxes[0].contains?(tomato)).to be_truthy
      expect(plot.boxes[0].fidjis.include?(tomato)).to be_truthy
      expect(plot.boxes[0].units.count).to eq(4)

    end
  end

  describe 'find_first_available_box_for' do
    context 'plot empty;' do
      it 'should return the first box' do
        box = plot.find_first_available_box_for(carrot)
        expect(box).to be_kind_of Box
        expect(box.position).to eq('1,1')
      end

      context 'plot full;' do
        it 'should return 0 box' do
          box = plot.find_first_available_box_for(carrot)
          box.fill_with(carrot)
          box = plot.find_first_available_box_for(carrot)
          box.fill_with(carrot)
          box = plot.find_first_available_box_for(carrot)
          box.fill_with(carrot)
          box = plot.find_first_available_box_for(carrot)
          box.fill_with(carrot)
          box = plot.find_first_available_box_for(carrot)
          expect(box).to eq nil
        end
      end            
    end
  end

  describe 'find_boxes_by_4_edge' do
    
    it 'should find one 2x2 boxes (= 4 boxes)' do
      boxes_2x2 = plot.find_2x2_boxes(tomato)
      expect(boxes_2x2.count).to eq(4)
    end

    context 'with a plot of 2 boxes' do
      let (:plot) { Plot.new("plot;30x30;", 1) }
      it 'should not find 2x2 boxes' do
        boxes_2x2 = plot.find_2x2_boxes(tomato) 
        expect(boxes_2x2.count).to eq(0)
      end
    end
  end

  describe 'last_seasons_families' do
    it 'should return 0 families' do
      families = plot.past_crops_families
      expect(families).to eq([])
    end
  end

  describe 'fidjis_families' do
    context 'diversity: :medium' do
      # let (:diversity) { :medium }
      # it 'should return 2 fidjis families' do
      #   families = plot.fidjis_families_pool
      #   puts families
      #   expect(families.count).to eq(2)
      # end
    end
  end

  describe 'fidjis_pool' do
    it 'should return a FidjisPool' do
      pool = plot.fidjis_pool
      expect(pool).to be_kind_of FidjisPool
    end
  end

  # this is wrong
  describe 'full?' do
    it 'should return false' do
      expect(plot.full?).to be_falsy
    end

    it 'should return false' do
      plot.boxes.first.fill_with(carrot)
      expect(plot.full?).to be_falsy
    end

    it 'should return true when all the boxes are not empty' do
      plot.boxes.first.fill_with(carrot)
      plot.boxes[1].fill_with(carrot)
      plot.boxes[2].fill_with(carrot)
      plot.boxes[3].fill_with(carrot)
      expect(plot.full?).to be_truthy
    end    
  end

  describe 'prepare' do
    context 'with a random FidjisPool' do
      it 'should prepare a plot' do
        plot.prepare
      end
    end

    context 'with a specific FidjisPool' do
      before {
        pool = FidjisPool.new(include_fidjis: ["apia", "herbs"])
        plot.fidjis_pool = pool
      }
      it 'should prepare a plot' do
        plot.prepare
      end
    end
  end


  describe 'units_left' do
    let (:plot) { Plot.new("plot;30x30", 1) }
    it 'should return the number of units left in the box' do
      expect(plot.units_left).to eq(16)

      plot.boxes[0].fill_with(cabbage)

      expect(plot.units_left).to eq(4)
    end
  end


  describe 'count_number_of' do
    it 'should have one cabbage in the plot' do
      plot.boxes[0].fill_minimum_with(cabbage)
      expect(plot.count_number_of(cabbage)).to eq(1)
    end

    it 'should have three carrots in the plot' do
      plot.boxes[0].fill_minimum_with(carrot)
      expect(plot.count_number_of(carrot)).to eq(3)
    end

    it 'should have one tomato in the plot' do
      plot.find_and_fill_boxes_for(tomato)
      expect(plot.count_number_of(tomato)).to eq(1)
    end
  end

  describe 'load_past_crop' do
    let (:plot) { Plot.new('plot;60x60', 1) }

    it 'should load past crop' do  
      plot.load_past_crop('2017-summer', [tomato, carrot])
      expect(plot.crops.count).to eq(1)
      
      plot.load_past_crop('2016-winter', [onion, okra])
      expect(plot.crops.count).to eq(2)
    end

    it 'should return past crops families' do
      plot.load_past_crop('2017-summer', [tomato, carrot])
      expect(plot.past_crops_families).to eq(['solana', 'apia'])
    end

    it 'should not return families from last crop' do
      plot.load_past_crop('2017-summer', [tomato, carrot])
      expect(plot.fidjis_pool.families.count).to eq(2)
      expect(plot.fidjis_pool.families.include?('solana')).to be_falsey
      expect(plot.fidjis_pool.families.include?('apia')).to be_falsey
    end
  end

  describe 'compost_need' do
    it 'should return the volume of compost' do
      expect(plot.compost_need).to eq(1000)
    end

  end
end