require 'date'
require_relative 'plot'
require_relative 'crop'

class Garden
  attr_reader :name, :key, :crops
  attr_accessor :plots, :boxes, :fidjis

  def initialize(args)
    
    @key = args[:name].downcase.gsub(' ', '_')
    @plots_file = "data/gardens/#{@key}/plots.txt"

    @fidjis = Fidjis.new

    @plots = []
    File.open(@plots_file, 'r') do |f|
      f.each_line do |line|
        next if line[0] == "#" || line.empty?
        plot_index = @plots.count { |b| b.area == line.split(';')[0]} + 1
        @plots.push(Plot.new(line, plot_index))
      end
    end

    # @crops = []
    # Dir.glob("data/gardens/#{@key}/crops/*").each do |crop|
    #   crop_path = Pathname.new(crop)
    #   load_past_crop(crop_path)
    # end
  end

  def boxes
    t_boxes = []
    @plots.each do |plot|
      t_boxes.push(plot.boxes)
    end
    t_boxes.flatten
  end

  def count_number_of fidji_name
    count = 0
    plots.each do |plot|
      plot.boxes.each do |box|
        box.fidjis.each do |fidji|
          units = box.units.count {|u| u.fidji == fidji_name}
          count += (units / fidji.cost_units).to_i
        end
      end
    end
    return count
  end

  def load_past_crop crop_path
    content = crop_path.read.split("\n")
    crop = {
      planting_day: Date.parse(content[0].split('=')[1]),
      season: content[1].split('=')[1]
    }
    @crops.push(crop)

    content = content[2..-1]
    crop_date = "#{crop[:planting_day].year}-#{crop[:season]}"

    plots.each_with_index do |plot, index|
      plot_name, fidjis = content[index].split(';')
      fidjis = fidjis.split(',').map do |fid|
        @fidjis.get(fid)
      end
      plot.load_past_crop(crop_date, fidjis)
    end
    
  end
  
  def prepare_next_seasons start_season: nil
    next_seasons_from(start_season).each do |season|
      prepare_season season
    end
  end

  def prepare
    plots.each do |plot|
      plot.prepare
    end
  end

  def past_crops
    plots.each do |plot|
      plot.past_crops
    end
  end

  def to_s
    @plots.map { |plot| plot.to_s }.join()
  end
end
