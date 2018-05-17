class FormProperty < ApplicationRecord

  validates :name, :html, :description, presence: true
  validates :name, uniqueness: true
  validates :options, presence: true, if: :is_select?

  has_many :properties, dependent: :destroy
  
  def self.create name:, html:, options: nil, multiple: false
    fp = FormProperty.new
    fp.html = html
    fp.name = name
    fp.options = options
    fp.multiple = multiple
    fp.save
    fp
  end

  def is_select?
    html == 'select'
  end

  def set_option option
    return false if option.empty?
    return false if options_to_a.include?(option)
    self.options = (options_to_a << option).join(',')
    self.save
  end

  def options_to_a
    options.split(',')
  end
end
