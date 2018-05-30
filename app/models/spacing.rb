class Spacing < ApplicationRecord

  validates :options, :item, presence: true

  belongs_to :item

  def self.default_square
    Spacing.new(options: "square-1-cost-1-min-16-max-16")
  end

  def self.default_corner
    Spacing.new(options: "corner-1-cost-1-min-16-max-16")
  end  

  OPTIONS = [:cost, :max, :min]
  
  def match_spacing
    if options.match(/square-[0-9]*/)
      return 'square'
    elsif options.match(/corner-[0-9]*/)
      return 'corner'
    end
  end

  def match_size
    if res = options.match(/#{match_spacing}-([0-9]*)/)
      return res[1]
    else
      nil
    end
  end

  def match_edge
    if options.match(/edge/)
      return true
    else
      return false
    end
  end

  def match_trellis
    if options.match(/trellis/)
      return true
    else
      return false
    end
  end

  def match_corner
    if options.match(/corner-[a-z]*/)
      return true
    else
      return false
    end
  end  

  OPTIONS.each do |option|
    define_method "match_#{option.to_s}" do
      if res = options.match(/#{option.to_s}-([0-9]*)/)
        return res[1]
      else
        nil
      end
    end
  end

  def parsed_options
    
    @parsed_options ||= {
      options: options,
      spacing: match_spacing,
      size: match_size.to_i,
      cost_in_unit: match_cost.to_i,
      min_items: match_min.to_i,
      max_items: match_max.to_i,
      corner: match_corner,
      edge: match_edge,
      trellis: match_trellis,
      item_id: item_id,
      spacing_id: self.id
    }
  end
end