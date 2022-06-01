require './test_helper.rb'

# The code should be able to:
# 1. Read a file of integers separated by commas
# 2. Convert this list to an array 

# 3. The program takes the array (initial status) and a integer (days remaining) as input
# 4. Return an integer




# Create a class for each lanternfish. We want: 
# To initialize lanterfish which are either a new one (with a status 8) or an exiting one with a given positive integer status
# To be able to check the status of a lanternfish (do we really?)
# To be able to modify the status of a lanternfish when a day pass => tick method

# To accomplish that, first I created the set of tests below and then add each piece to the class until the tests passed

class Lanternfish
  attr_reader :status

  def initialize(status = 8)
    if status.is_a?(Integer) && status >= 0
      @status = status
    else
      raise ArgumentError, "Expected a non negative integer as argument"
    end
  end

  def tick 
    if @status > 0
      @status -= 1
    else 
      @status = 6
    end
    self
  end

  def ==(other)
    return false if !other.is_a?(self.class)

    @status == other.status
  end

end




# Create a class for a school of lanternfish. We want: 
# To create a new school either empty (empty array) or a given one (array with integer entries)
# To be able to add new lanternships to an existing school => add method
# To tick every fish in the school => tick method
# To count the number of lanternships in the school => count method (already exists)

# To accomplish that, first I created the set of tests in 'tests_lanternfish.rb' and then add each piece to the class until the tests passed.

class LanternfishSchool

  attr_reader :list

  def initialize(list = [])
    if list.is_a?(Array) && list.all? { |n| n.is_a?(Integer) }
      @list = list.map { |n| Lanternfish.new(n) }
    else 
      raise ArgumentError, "Expected an array of lanternfishes as argument" # QUESTION: WHY DOES THIS RAISES A RUNTIME ERROR (WHEN I DON'T FORCE IT TO BE ARGUMENT ONE)
    end
  end

  def ==(other)
    return false if !other.is_a?(self.class)

    @list == other.list 
  end

  def add(fish)
    @list = @list.push(fish)
    self
  end

  def tick
    new_fishes = 0
    @list.each { |fish| new_fishes += 1 if fish.status == 0 }

    @list.map! do |fish|
       fish.tick 
    end

    (0...new_fishes).each { |i| add(Lanternfish.new) }

    self
  end

  def after_some_days(n)
    if n.is_a?(Integer) && n > 0
      (1..n).each { |i| tick() }
      self
    else 
      raise ArgumentError, "Expected positive integer as argument"
    end
  end

  def lanternfish_count(n)
    after_some_days(n).list.count
  end

end




# Now I want to create the LanternfishSchool directly from an array:

def test_lanternfish_school_initialize
  assert_equal(LanternfishSchool.new([5])) { LanternfishSchool.new([5]) }
  assert_equal(LanternfishSchool.new([5,3])) { LanternfishSchool.new([5,3]) }
end

def test_lanternfish_school_list
  assert_equal([Lanternfish.new(5)]) { LanternfishSchool.new([5]).list }
end

test_lanternfish_school_initialize
test_lanternfish_school_list
