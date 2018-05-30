class Garden < ApplicationRecord
  has_many :plots
  has_one :nursery

  def after_save
    self.create_nursery
  end

end
