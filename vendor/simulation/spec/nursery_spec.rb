require 'spec_helper'
require 'pry'
require_relative '../lib/tool'
require_relative '../lib/nursery'

describe Seedling do
  let (:fidjis) { Fidjis.new }
  let (:carrot) { fidjis.get('carrot') }
  let (:cabbage) { fidjis.get('cabbage') }

  describe 'initialize' do
    it 'should create a Seedling' do
      seedling = Seedling.new(carrot)
      expect(seedling.creation_date).to eq(Date.today)

      seedling = Seedling.new(carrot, Date.today - 5)
      expect(seedling.creation_date).to eq(Date.today - 5)
    end
  end
end

describe Nursery do

  let (:fidjis) { Fidjis.new }
  let (:carrot) { fidjis.get('carrot') }
  let (:cabbage) { fidjis.get('cabbage') }

  let (:nursery) { Nursery.new }

  describe 'initialize' do  
    describe 'SeedStock' do
      it 'should add seeds to the stock' do
        nursery.seed_stock << {variety: 'nantes', fidji: :carrot, qty: 50}
        expect(nursery.seed_stock.qty_for(:carrot)).to eq(50)
        
        nursery.seed_stock << {fidji: :cabbage}
        expect(nursery.seed_stock.qty_for(:cabbage)).to eq(0)
      
        nursery.seed_stock << {fidji: :carrot, qty: 10}
        expect(nursery.seed_stock.qty_for(:carrot)).to eq(60)
      end
    end
  end

  describe 'create_seedling' do
    it 'should create a seedling' do
      nursery.seed_stock << {fidji: :carrot, qty: 1}
      nursery.create_seedling(:carrot, 1)
      expect(nursery.items.count).to eq(1)
      expect(nursery.seed_stock.qty_for(:carrot)).to eq(0)
    
      nursery.create_seedling(:carrot, 1)
      expect(nursery.items.count).to eq(1)
      expect(nursery.seed_stock.qty_for(:carrot)).to eq(0)
    
      nursery.seed_stock << {fidji: :tomato, qty: 10}
      nursery.create_seedling(:tomato, 20)
      expect(nursery.items.count).to eq(11)
      expect(nursery.seed_stock.qty_for(:tomato)).to eq(0)
    end
  end
end