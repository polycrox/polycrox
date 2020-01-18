require 'spec_helper'
require 'pry'
require_relative '../lib/tool'
require_relative '../lib/fidji'

describe Fidjis do
  before {
    @fidjis = Fidjis.new
  }
  let (:fidji_name) { 'carrot' }
  
  describe 'get' do
    context 'carrot' do
      it 'should get the carrot fidji' do
        fidji = @fidjis.get(fidji_name)
        expect(fidji).to be_kind_of Fidji
        expect(fidji.family).to eq('apia')
      end
    end
  end
end


describe Fidji do
  before {
    @fidjis = Fidjis.new
  }
  let (:tomato) { @fidjis.get('tomato') }
  let (:cabbage) { @fidjis.get('cabbage') }
  let (:carrot) { @fidjis.get('carrot') }  

  describe 'not_friend_with?' do

    it 'should say tomato<->cabbage are not friends' do
      expect(tomato.not_friend_with?(cabbage)).to be_truthy
      expect(cabbage.not_friend_with?(tomato)).to be_truthy
    end

    it 'should say carrot<->cabbage are friends' do
      expect(carrot.not_friend_with?(cabbage)).to be_falsy
    end

  end
  
  describe 'is_friend_with?' do
    it 'should say tomato<->carrot are friends' do
      expect(tomato.friend_with?(carrot)).to be_truthy
      expect(carrot.friend_with?(tomato)).to be_truthy
    end

    it 'should say carrot<->cabbage are friends' do
      expect(carrot.friend_with?(cabbage)).to be_truthy
      expect(cabbage.friend_with?(carrot)).to be_truthy
    end

  end
end

