require_relative 'fidjis_pool'

class Fidji
  attr_reader :name, :family, :height, 
    :min_box, :max_units, :min_units, :cost_units,
    :find_conditions, :friends, :not_friends
  
  def initialize line
    tmp = line.split(';')
    @name = tmp[0]
    @family = tmp[1]
    @height = tmp[2]
    # @square_foot_planting = tmp[3].to_f
    @min_box = tmp[3].to_f
    # @square_foot_positions = tmp[4].split(',') unless tmp[4].nil?
    @max_units = tmp[4].to_f
    @min_units = tmp[5].to_f
    @cost_units = tmp[6].to_f
    @find_conditions = tmp[7].split(',') unless tmp[7].nil? #else ['find_box_with_space_and_no_enemies']

    @friends = tmp[8] || []
    @not_friends = tmp[9] || []
  end

  def to_s
    "#{name}(#{family})"
  end

  def to_sym
    name.to_sym
  end

  def friend_with? fidji
    !not_friend_with?(fidji)
  end

  def not_friend_with? fidji
    not_friends.include?(fidji.name) || 
      not_friends.include?(fidji.family) || 
        fidji.not_friends.include?(name) ||
          fidji.not_friends.include?(family)
  end

end
