
class FidjisPool

  attr_reader :pool
  attr_reader :include_fidjis, :exclude_fidjis

  def initialize(include_fidjis: [],
    exclude_fidjis: [], 
    exclude_families: [])

    # if include_fidjis
    #   if include_fidjis.first.is_a? Fidji
    #     @pool = include_fidjis
    #   else
    #     @pool = Fidjis.new.pool.find_all do |fid|
    #       include_fidjis.include?(fid.family)
    #     end
    #   end
    # end

    # if exclude_families
    #   @pool = Fidjis.new.pool.find_all do |fid|
    #     not exclude_families.include?(fid.family)
    #   end
    # end
    @exclude_families = exclude_families
    set
  end

  def take_families_with_diversity diversity
    if diversity == :medium
      (FIDJIS_FAMILIES.shuffle - @exclude_families)[0..1]
    end
  end

  def set diversity: :medium
    families = take_families_with_diversity(diversity)
    @pool = Fidjis.new.pool.find_all do |fid|
      families.include?(fid.family)
    end
  end

  def to_s
    @pool.map do |fidji|
      fidji.name
    end.join(',')
  end

  def families
    @pool.map do |fidji|
      fidji.family
    end.uniq
  end

  def families_to_s
    families.join(',')
  end

  def shift
    f = @pool.shift
    @pool.push(f)
    f
  end

  def pop
    @pool.pop
    nil
  end

  def [] index
    @pool[index]
  end

  def my_sort!(desc: true)
    @pool.sort! do |f, f_next|
      f_next.height.to_i <=> f.height.to_i
    end
  end

  def count
    @pool.count
  end

  def empty?
    count == 0
  end

  def available?
    !empty?
  end

end
