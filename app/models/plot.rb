class Plot < ApplicationRecord
  belongs_to :garden
  has_many :boxes
  has_many :crops


  # has_and_belongs_to_many :items, 
  #   join_table: 'crops_items_plots', 
  #   class_name: 'Item'

  
  before_save :set_default

  after_save :create_boxes, on: [:create]

  attr_reader :cols, :rows

  SQUARE_FOOT_BOX_WIDTH = 30

  def set_default
    # must be renamed
    if self.width_cm.nil?
      self.width_cm = 0
    end
    if self.length_cm.nil?
      self.length_cm = 0
    end
  end
  
  def create_boxes
    (1..rows).each do |pos_x|
      (1..cols).each do |pos_y|
        box = Box.new
        box.pos_x = pos_x
        box.pos_y = pos_y
        boxes << box
      end
    end        
  end

  def cols
    @cols ||= width_cm / SQUARE_FOOT_BOX_WIDTH
  end

  def rows
    @rows ||= (length_cm ? length_cm : 0) / SQUARE_FOOT_BOX_WIDTH
  end

  def as_json options = nil
    {
      id: id, 
      name: name, 
      rows: rows, 
      cols: cols,
      length_cm: length_cm,
      width_cm: width_cm,
      geometry: geometry
    }.merge(options)
  end

end
