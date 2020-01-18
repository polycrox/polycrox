require 'spec_helper'
require 'pry'
require_relative '../lib/tool'
require_relative '../lib/box'


describe Box do
  before {
    @fidjis = Fidjis.new
  }
  let (:tomato) { @fidjis.get('tomato') }
  let (:carrot) { @fidjis.get('carrot') }
  let (:cabbage) { @fidjis.get('cabbage')}
  let (:schard) { @fidjis.get('swiss chard')}
  let (:onion) { @fidjis.get('onion')}
  let (:dill) { @fidjis.get('dill')}
  let (:beanbush) { @fidjis.get('bean bush')}

  describe 'available_for?' do
    let (:box) { Box.new(1, 1) }

    it 'should be available for a tomato when empty' do
      expect(box.available_for?(tomato)).to be_truthy
    end
    
    context 'the box is full of carrots' do
      before {
        box.fill_with carrot
      }
      it 'should not be available for a tomato' do
        expect(box.units.count).to eq(16)
        expect(box.available_for?(tomato)).to be_falsy
      end
    end

    context 'the box is half-full of carrots' do
      before {
        box.fill_half_with carrot
      }
      it 'should be available for a tomato' do
        expect(box.available_for?(tomato)).to be_truthy
      end
    end

    context 'enemies' do
      context 'the box has carrots' do
        it 'should not be avalaible for a dill' do
          box.fill_minimum_with(carrot)
          expect(box.available_for?(dill)).to be_falsy
        end
      end
      context 'the box has onions' do
        it 'should not be available for a bean bush' do
          box.fill_minimum_with(onion)
          expect(box.available_for?(beanbush)).to be_falsy
        end
      end
    end
  end

  describe 'fill_with' do
    let (:box) { Box.new(1, 1) }

    it 'should fill one cabbage for a total of 12 units' do
      box.fill_with(cabbage)
      expect(box.units.count).to eq(12)
      expect(box.fidjis.count).to eq(1)
    end

    it 'should fill carrots for a total of 16 units' do
      box.fill_with(carrot)
      expect(box.units.count).to eq(16)
      expect(box.fidjis.count).to eq(1)
    end

    it 'should fill tomato for a total of 4 units' do
      box.fill_with(tomato)
      expect(box.units.count).to eq(4)
      expect(box.fidjis.count).to eq(1)
    end

    it 'should fill half a box of carrot' do
      box.fill_half_with(carrot)
      expect(box.units.count).to eq(8)
      expect(box.fidjis.count).to eq(1)
    end

    it 'should fill 1/3 a box of carrot' do
      box.fill_one_third_with(carrot)
      expect(box.units.count).to eq(5)
    end

    it 'should fill 1/4 a box of carrot' do
      box.fill_one_quarter_with(carrot)
      expect(box.units.count).to eq(4)
    end

    it 'should fill the minimum of carrot' do
      box.fill_minimum_with(carrot)
      box.fill_minimum_with(carrot)
      # box.fill_with(carrot, :min)
      expect(box.units.count).to eq(6)
      expect(box.fidjis.count).to eq(1)
    end

    it 'should fill half carrots half onion' do
      box.fill_half_with(carrot)
      box.fill_half_with(onion)
      expect(box.units.count).to eq(16)
      expect(box.fidjis.count).to eq(2)
    end

    it 'should fill minimum carrot/onion and a tomato' do
      box.fill_minimum_with(carrot)
      box.fill_minimum_with(onion)
      box.fill_with(tomato)
      expect(box.units.count).to eq(10)
      expect(box.fidjis.count).to eq(3)
    end

    # it 'should eggplant' do
    #   box.fill_minimum_with(eggplant)
    #   expect(box.units.)
    # end

  end
end