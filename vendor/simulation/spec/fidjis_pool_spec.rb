require 'spec_helper'
require 'pry'
require_relative '../lib/tool'
require_relative '../lib/fidjis_pool'

describe FidjisPool do
  before {
    @fidjis = Fidjis.new
    @fidjis = [beetroot, eggplant, tomato, carrot, cabbage]
    @pool = FidjisPool.new(include_fidjis: @fidjis)
  }

  let (:tomato) { @fidjis.get('tomato') }
  let (:cabbage) { @fidjis.get('cabbage') }
  let (:carrot) { @fidjis.get('carrot') }
  let (:beetroot) { @fidjis.get('beetroot') }
  let (:eggplant) { @fidjis.get('eggplant') }



  describe 'initialize' do    
    it 'should do' do
      expect(@pool.to_s).to eq('beetroot,eggplant,tomato,carrot,cabbage')
    end
  end

  describe 'shift' do
    it 'should return tomato and put beetroot at the end' do
      fidji = @pool.shift
      expect(fidji.name).to eq('beetroot')
      expect(@pool[-1].name).to eq('beetroot')
    end
  end

  describe 'sort' do
    it 'should sort: tomato, cabbage, carrot' do
      @pool.my_sort!
      expect(@pool.to_s).to eq('tomato,eggplant,cabbage,carrot,beetroot')
    end
  end

  describe 'exclude_families is set' do
    before {
      @pool = FidjisPool.new(exclude_families: ["solana", "apia"])
      @pool.set
    }

    it 'should not have solano (tomato, eggplant) or apia (carrot) in the pool' do
      expect(@pool.pool.include?(tomato)).to be_falsy
      expect(@pool.pool.include?(eggplant)).to be_falsy
      expect(@pool.pool.include?(carrot)).to be_falsy
      expect(@pool.families.count).to eq(2)
    end
  end

end