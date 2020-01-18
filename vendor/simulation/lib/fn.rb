require 'pry'
# more functional

# Garden = Struct.new(:name, :plots)

# Plot = Struct.new(:length, :width)

#   def boxes
#     @boxes ||= Array.new(4)
#   end
# end

module Plot 
  class << self
    def add garden, plot
      # return a Garden Hash
      # with an updated plot list
      return {
        name: garden[:name], 
        plots: garden[:plots].map{}.push(plot)
      }
    end

    def history plot

    end
  end
end

module Tool
  class << self 
    def create_garden name
      return {
        name: name, 
        plots: []
      }
    end

    def count_plots garden
      garden[:plots].count
    end
  
    def prepare garden
      # it should return a prepared garden
      return {
        name: garden[:name],
        plots: garden[:plots].map do |plot|
          history_plot = Plot.history plot
          Tool.prepare_plot garden, plot
        end
      }
    end

    def prepare_plot garden, plot
      # return a prepared plot
      prepared_plot = Plot.new(60, 60)
    end
  end
end
