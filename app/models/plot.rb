class Plot < ApplicationRecord
  belongs_to :garden
  has_many :boxes

  after_save :create_boxes, on: [:create]

  def create_boxes
    
  end
end
