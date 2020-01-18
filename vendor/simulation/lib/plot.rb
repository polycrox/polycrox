require_relative 'box'
require_relative 'fidjis_pool'
require_relative 'crop'

class Plot
  attr_reader :area, :seasons, :id, 
    :boxes, :rows, :cols,
    :crops

  def initialize(line, id)  
    tmp = line.split(';')
    @area = tmp[0]
    @id = "#{@area}-#{id}"
    dimension = tmp[1].split('x')
    @length = dimension[0].to_i
    @width = dimension[1].to_i
    @shape = tmp[2] || nil
    @seasons = []
    @boxes = []
    @cols = @width / SQUARE_FOOT_BOX_WIDTH
    @rows = @length / SQUARE_FOOT_BOX_WIDTH
    (1..@rows).each do |row|
      (1..@cols).each do |col|
        @boxes.push(Box.new(col, row, @boxes.count + 1))
      end
    end
    @crops = []
  end

  def compost_need
    puts "#{@width} * #{@length} * #{COMPOST_HEIGHT})"
    puts "= #{(@width * @length * COMPOST_HEIGHT)}"
    (@width * @length * COMPOST_HEIGHT) 
  end
  
  def box_at x, y
    box = @boxes.find do |box|
      box.x == x && box.y == y
    end

    if box.nil?
      return BoxOutOfPlot.new
    else
      box
    end
  end 
  
  def draw
    t = ""
    (1..@cols).each do |col|
      (1..@rows).each do |row|
        t += "*"
      end
      t += "\n"
    end
    return t
  end

  def is_triangle?
    @shape == :triangle
  end

  def add_season season, veggies, active
    @seasons.push({
      season: season, 
      veggies: veggies, 
      active: active})
  end

  def load_past_crop crop_date, fidjis
    crop = Crop.new(crop_date, fidjis)
    @crops.push(crop)
  end

  def past_crops_families
    @past_crops_families ||= @crops.map do |crop|
      crop.families
    end.flatten
  end

  def fidjis_pool= pool
    @fidjis_pool = pool
  end

  def fidjis_pool
    @fidjis_pool ||= FidjisPool.new(
      exclude_families: past_crops_families)
  end

  def find_2x2_boxes fidji
    tmp_boxes = []
    boxes.each do |box|
      if box.available_for?(fidji)
        tmp_boxes.push(box)
        if box_at(box.x + 1, box.y).available_for?(fidji)
          tmp_boxes.push(box_at(box.x + 1, box.y))
          if box_at(box.x, box.y + 1).available_for?(fidji)
            tmp_boxes.push(box_at(box.x, box.y + 1))
            if box_at(box.x + 1, box.y + 1).available_for?(fidji)
              tmp_boxes.push(box_at(box.x + 1, box.y + 1))
            end
          end
        end
      end
      return tmp_boxes
    end
  end

  def find_boxes_by_2_edge_plot fidji
    # looking for 1x2 on the edge plot
    # +---
    # | * x
    # | * x 
    return []
  end


  def find_available_boxes_for fidji
    # meh
    if fidji.name == 'tomato'
      return find_2x2_boxes(fidji).flatten
    # elsif fidji.name == 'squash'
      # return find_boxes_by_3(fidji)
    end
  end

  def find_first_available_box_for fidji
    return boxes.find do |box|
      box.available_for?(fidji)
    end
  end

  def not_full?
    !full?
  end

  def full?
    boxes.each do |box|
      return false if !box.full?
    end
    puts "#{id} is full"
    return true
  end

  def count_number_of fidji
    boxes.reduce(0) do |sum, box| 
      sum + box.count_number_of(fidji)
    end
  end

  def units_left
    boxes.reduce(0) do |sum,box|
      sum + box.units_left
    end
  end
  
  def find_and_fill_boxes_for fidji
    boxes = find_available_boxes_for(fidji)
    
    if boxes.any?
      boxes.each do |box|
        box.fill_minimum_with(fidji)
      end
    else
      fidjis_pool.pop
      puts "No space #{fidji.to_s} in plot"
    end
  end
  

  def prepare
    puts "past crops: #{past_crops_families}"
    puts "pool: #{fidjis_pool.families_to_s}"
    puts "pool: #{fidjis_pool.to_s}"

    fidjis_pool.my_sort!

    while not_full? && fidjis_pool.available? do
      
      fidji = fidjis_pool.shift
      puts "=> #{fidji.to_s} (already #{count_number_of(fidji)})"

      if fidji.min_box > 1
        find_and_fill_boxes_for(fidji)
      else
        box = find_first_available_box_for(fidji)
        if box.nil?
          fidjis_pool.pop
          puts "No space for #{fidji.to_s} in plot"
        else
          box.fill_minimum_with(fidji)
        end
      end
    end

    puts "------\n"
    to_s
  end

  def past_crops
    puts "PLOT #{id}"
    crops.each do |crop|
      puts "#{crop.date}: #{crop.families}"
    end
  end
  
  def to_s
    count = {}
    puts "PLOT===#{id}"

    boxes.each do |box|
      puts "box-#{box.id}(#{box.x},#{box.y}):"
      box.fidjis.each do |fidji|
        
        if count.key?(fidji.name)
          count[fidji.name] += box.count_number_of(fidji)
        else
          count[fidji.name] = box.count_number_of(fidji)
        end
        puts "- #{box.count_number_of(fidji)} x #{fidji.to_s}"
      end
      puts "\n"
    end

    puts "#{id} (#{@length}x#{@width}) has:"
    count.each do |fidji|
      puts "- #{fidji[1]} x #{fidji[0]}"
    end
  end
end
