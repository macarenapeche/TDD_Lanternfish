require './test_helper.rb'



class LFSchool
  attr_reader :stages 

  def initialize(array)
    raise ArgumentError, "Expected array as argument" if !array.is_a?(Array)
    
    @stages = Hash.new(0)
    array.each { |i| @stages[i] += 1 }
    
  end

  def lanternfish_count(n)
  end
end

def test_lanternfish_initialize
  assert_error(ArgumentError) { LFSchool.new(6) }
end

def test_lanternfish_stages
  assert_equal({ 1 => 1 })  { LFSchool.new([1]).stages }
end

def test_lanternfish_count
  initial = File.read('inputDay6.txt', chomp: true).split(",").map { |item| item.to_i }
  assert_equal(initial.count) { LFSchool.new(initial).lanternfish_count(0) }
  assert_equal(386536) { LFSchool.new(initial).lanternfish_count(80) }
end


test_lanternfish_initialize
test_lanternfish_stages
test_lanternfish_count