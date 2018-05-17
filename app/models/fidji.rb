class Fidji < ApplicationRecord

  validates :name, uniqueness: true
  validates :name, :family, presence: true
end
