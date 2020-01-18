SQUARE_FOOT_BOX_WIDTH = 30
UNITS_PER_SQUARE_FOOT_BOX = 16

COMPOST_HEIGHT = 10

FIDJIS_FAMILIES = [
  'solana', 
  'chenopo', 
  'apia', 
  'brassica', 
  'allium',
  'cucurbita',
  'legumino',
  'malva'
]

MORE_VEGETABLE_FAMILIES = [
  'herbs',
  'misc'
]

require_relative 'fidji'
# ALL THE VEGETABLES
class Fidjis

  attr_reader :pool

  def initialize
    @pool = []
    File.open('data/fidjis.txt', 'r') do |f|
      f.each_line do |line|
        next if line[0] == '#' || line.empty?
        @pool.push(Fidji.new(line))
      end
    end
  end

  def get fidji_name
    @pool.find do |fidji|
      fidji.name == fidji_name
    end
  end
end


