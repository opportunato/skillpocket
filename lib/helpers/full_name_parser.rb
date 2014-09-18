class FullNameParser
  def initialize(full_name)
    @full_name = full_name
  end

  def first_name
    @full_name.split[0]
  end

  def last_name
    @full_name.split[1]
  end
end