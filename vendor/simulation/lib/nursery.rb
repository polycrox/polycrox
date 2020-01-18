require 'date'

class NurserySeedStock
  
  def initialize
    @seeds = []
  end

  def fetch fidji_sym
    @seeds.find do |seed|
      seed[:fidji].to_sym == fidji_sym
    end
  end

  def << (fidji: nil, qty: 0)
    if in_fidji = fetch(fidji.to_sym)
      in_fidji[:qty] += qty
    else
      @seeds << {fidji: fidji, qty: qty}
    end
  end

  def to_s
    @seeds.each do |seed|
      puts "#{seed[1]} seeds of fidji#{seed[0].to_s}"
    end
  end

  def qty_for fidji_sym
    fetch(fidji_sym)[:qty]
  end

  def take fidji, qty
    f = fetch(fidji)
    if f[:qty] == 0
      return 0
    elsif f[:qty] > qty
      f[:qty] -= qty
      return qty
    else
      qty = f[:qty]
      f[:qty] = 0
      return qty
    end
  end


end

class Cutting ; end
class Pot ; end

class Seedling

  attr_accessor :creation_date

  def initialize(fidji, creation_date = Date.today)
    @fidji = fidji
    @creation_date = creation_date
    @state = SeedStateMachine.new
  end

end

class Nursery
  attr_reader :seed_stock, :items

  def initialize
    @items = []
    @seed_stock = NurserySeedStock.new
  end

  def create_seedling(fidji, qty)
    qty = @seed_stock.take(fidji, qty)
    (1..qty).each do |seedling|
      fidji = Fidjis.new.get(fidji.to_s)
      @items << Seedling.new(fidji)
    end
  end
end
