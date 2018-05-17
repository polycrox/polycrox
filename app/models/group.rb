class Group < ApplicationRecord

  validates :name, presence: true
  validates :name, uniqueness: true

  has_and_belongs_to_many :items, join_table: 'items_groups'

  def self.find_or_create name:
    Group.find_by_name(name) || Group.create(name: name)
  end
end


