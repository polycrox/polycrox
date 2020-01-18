require_relative 'unit'

class Box
  attr_reader :x, :y, :id
  attr_accessor :units, :fidjis
  
  def initialize col, row, id
    @units = []
    @fidjis = []
    @x = col
    @y = row
    @id = id
  end

  def position
    "#{@x},#{@y}"
  end

  def empty?
    @units.empty?
  end

  def half_empty?
    @units.count <= UNITS_PER_SQUARE_FOOT_BOX / 2
  end

  def half_full?
    @units.count >= UNITS_PER_SQUARE_FOOT_BOX / 2
  end

  def full?
    @units.count >= UNITS_PER_SQUARE_FOOT_BOX
  end

  def units_left
    UNITS_PER_SQUARE_FOOT_BOX - @units.count
  end

  def has_enough_units_for? cost_units
    (units_left) >= cost_units
  end
  
  def has_no_enemies_with?(fidji)
    @fidjis.each do |f|
      return false if f.not_friend_with?(fidji)
    end
    return true
  end
  
  def available_for? fidji
    if full?
      puts "box(#{@x},#{@y}) is full"
      return false
    end

    if has_enough_units_for?(fidji.cost_units)
      if has_no_enemies_with?(fidji)
        return true
      else
        puts "box(#{x},#{y}) has an enemy to #{fidji.to_s}"
        return false
      end
    else
      puts "box(#{x},#{y}) doesnt have #{fidji.cost_units} units (#{units_left} units left)"      
    end

    return false
  end

  def fill_with fidji, quantity = nil
    if quantity.nil?
      if fidji.max_units > 1
        quantity = (fidji.max_units * fidji.cost_units).to_i
      else
        quantity = fidji.cost_units.to_i
      end
    end

    if fidji.min_units < 1
      quantity = fidji.cost_units.to_i
    end

    if quantity > units_left
      quantity = units_left
    end

    quantity.times do
      @units.push(Unit.new(fidji.name)) 
    end

    unless @fidjis.include?(fidji)
      @fidjis.push(fidji)
    end

    puts "box(#{@x},#{@y}): fill #{count_number_of(fidji)} x #{fidji.to_s}"

  end

  def fill_half_with fidji
    quantity = (fidji.max_units / 2).to_i
    fill_with(fidji, quantity)
  end

  def fill_one_third_with fidji
    quantity = (fidji.max_units / 3).to_i
    fill_with(fidji, quantity)
  end

  def fill_one_quarter_with fidji
    quantity = (fidji.max_units / 4).to_i
    fill_with(fidji, quantity)
  end

  def fill_minimum_with fidji
    quantity = (fidji.min_units * fidji.cost_units).to_i
    fill_with(fidji, quantity)
  end

  def count_number_of fidji
    units = @units.count {|u| u.fidji == fidji.name}
    if units > 0
      if fidji.min_units < 1
        return fidji.min_units
      else
        return (units / fidji.cost_units).to_i
      end
    end
    return 0
  end    
end

class BoxOutOfPlot
  def initialize
  end

  def available_for? fidji
    false
  end
end
