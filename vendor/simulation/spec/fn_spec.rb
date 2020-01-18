require 'spec_helper'
require 'pry'
require_relative '../lib/fn'

describe Tool do

  describe 'create_garden' do
    it 'should return a garden hash' do
      garden = Tool.create_garden('one_plot')
      expect(garden).to eq({:name=>"one_plot", :plots=>[]})
    end
  end
  
  describe 'add_plot' do

    it 'should add a plot to a garden' do
      garden = Tool.create_garden('one_plot')
      plot = Plot.new(60, 60)
      u_garden = Tool.add_plot garden, plot
      
      expect(garden[:plots].count).to eq(0)
      expect(u_garden[:plots].count).to eq(1)
      
      garden = Tool.add_plot u_garden, plot
      expect(garden[:plots].count).to eq(2)
    end
  end

  describe 'count_plots' do
    it 'should count plots' do
      garden = Tool.create_garden('one_plot')
      count = Tool.count_plots garden
      expect(count).to eq(0)
      plot = Plot.new(60, 60)
      u_garden = Tool.add_plot garden, plot      
      count = Tool.count_plots u_garden
      expect(count).to eq(1)
    end
  end

  describe 'prepare_plot' do
    it 'should prepare a plot' do
      garden = Tool.create_garden('one_plot')
      plot = Plot.new(60, 60)
      garden = Tool.add_plot garden, plot
      new_plot = Tool.prepare_plot garden, garden[:plots][0]
      expect(new_plot).to eq('')
    end
  end
end