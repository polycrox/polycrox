
class Crop

  attr_reader :date, :fidjis, :families

  def initialize date, fidjis
    @date = date
    @fidjis = fidjis
    @families = @fidjis.map do |fidji|
      fidji.family
    end.uniq
  end
end