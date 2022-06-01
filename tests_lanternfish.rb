require './test_helper.rb'
require './6_lanternfish.rb'

puts "Lanternfish tests:"

def test_lanternfish_initialize
  assert_error(ArgumentError) { Lanternfish.new(-2) }
  assert_error(ArgumentError) { Lanternfish.new(2.5) }
  assert_error(ArgumentError) { Lanternfish.new('a') }
end

def test_lanternfish_status
  assert_equal(8) { Lanternfish.new.status }
  assert_equal(4) { Lanternfish.new(4).status }
  assert_equal(0) { Lanternfish.new(0).status } 
end

def test_lanternfish_equality
  assert_equal(true) { Lanternfish.new == Lanternfish.new }
  assert_equal(true) { Lanternfish.new(3) == Lanternfish.new(3) }
  assert_equal(false) { Lanternfish.new(4) == Lanternfish.new(3) }
end

def test_lanternfish_tick
  assert_equal(Lanternfish.new(3)) { Lanternfish.new(4).tap { |fish| fish.tick} }
  assert_equal(Lanternfish.new(6)) { Lanternfish.new(0).tap { |fish| fish.tick} }
end

test_lanternfish_initialize
test_lanternfish_status
test_lanternfish_tick
test_lanternfish_equality





puts "Lanternfish School tests"
# LanternfishSchool test 

def test_lanternfish_school_initialize
  assert_error(ArgumentError) { LanternfishSchool.new({}) } 
  assert_error(ArgumentError) { LanternfishSchool.new(['a', 2]) }
end

def test_lanternfish_school_equality
  assert_equal(true) { LanternfishSchool.new([Lanternfish.new(6), Lanternfish.new(5)]) == LanternfishSchool.new([Lanternfish.new(6), Lanternfish.new(5)]) }
  assert_equal(false) { LanternfishSchool.new([Lanternfish.new(3)]) == LanternfishSchool.new([Lanternfish.new(4)]) }
end

def test_lanternfish_school_add
  school = LanternfishSchool.new([])
  fish1 = Lanternfish.new
  fish2 = Lanternfish.new(6)

  assert_equal(LanternfishSchool.new([fish1])) { school.add(fish1) }
  assert_equal(LanternfishSchool.new([fish1, fish2])) { school.add(fish2) }
end

def test_lanternfish_school_tick 

  school1 = LanternfishSchool.new([Lanternfish.new(5)])
  school1_tick= LanternfishSchool.new([Lanternfish.new(4)])

  school2 = LanternfishSchool.new([Lanternfish.new(0)])
  school2_tick = LanternfishSchool.new([Lanternfish.new(6), Lanternfish.new(8)])

  school3 = LanternfishSchool.new([Lanternfish.new(0), Lanternfish.new(4), Lanternfish.new(0)])
  school3_tick = LanternfishSchool.new([Lanternfish.new(6), Lanternfish.new(3), Lanternfish.new(6), Lanternfish.new(8), Lanternfish.new(8)])

  assert_equal(school1_tick) { school1.tick }
  assert_equal(school2_tick) { school2.tick }
  assert_equal(school3_tick) { school3.tick }
end


def test_lanternfish_school_after_some_days
  school1 = LanternfishSchool.new
  school2 = LanternfishSchool.new([Lanternfish.new(2)])
  school2_after_2 = LanternfishSchool.new([Lanternfish.new(0)])

  school3 = LanternfishSchool.new([Lanternfish.new(0)])
  school3_after_2 = LanternfishSchool.new([Lanternfish.new(5), Lanternfish.new(7)])
  school3_after_8 = LanternfishSchool.new([Lanternfish.new(6), Lanternfish.new(1), Lanternfish.new(8)])

  school4 = LanternfishSchool.new([Lanternfish.new(3), Lanternfish.new(4), Lanternfish.new(3), Lanternfish.new(1), Lanternfish.new(2)])
  school4_after_2 = LanternfishSchool.new([Lanternfish.new(1), Lanternfish.new(2), Lanternfish.new(1), Lanternfish.new(6), Lanternfish.new(0), Lanternfish.new(8)])
  school4_after_12 = LanternfishSchool.new([Lanternfish.new(5), Lanternfish.new(6), Lanternfish.new(5), Lanternfish.new(3), Lanternfish.new(4), Lanternfish.new(5), Lanternfish.new(6), Lanternfish.new(0), Lanternfish.new(0), Lanternfish.new(1),  Lanternfish.new(5),Lanternfish.new(6), Lanternfish.new(7), Lanternfish.new(7), Lanternfish.new(7), Lanternfish.new(8), Lanternfish.new(8)])

  assert_error(ArgumentError) { school2.after_some_days(-1) }
  assert_error(ArgumentError) { school2.after_some_days("a") }

  assert_equal(LanternfishSchool.new) { school1.after_some_days(2) }
  assert_equal(school2_after_2) { school2.after_some_days(2) }
  assert_equal(school3_after_2) { school3.after_some_days(2) }
  assert_equal(school3_after_8) { school3.after_some_days(6) }
  assert_equal(school4_after_2) { school4.after_some_days(2) }
  assert_equal(school4_after_12) { school4.after_some_days(10) }

end


def test_lanternfish_count

  school = LanternfishSchool.new([Lanternfish.new(5)])

  assert_error(ArgumentError) { school.lanternfish_count(-1) }
  assert_error(ArgumentError) { school.lanternfish_count("a") }


  assert_equal(1) { school.lanternfish_count(5) }
  assert_equal(2) { school.lanternfish_count(3) }

  school2 = LanternfishSchool.new([Lanternfish.new(3), Lanternfish.new(4), Lanternfish.new(3), Lanternfish.new(1), Lanternfish.new(2)])

  assert_equal(26) { school2.lanternfish_count(18) }
  assert_equal(5934) { school2.lanternfish_count(62) }

end


test_lanternfish_school_initialize
test_lanternfish_school_equality
test_lanternfish_school_add
puts "tick method"
test_lanternfish_school_tick

puts "after_some_days method"
test_lanternfish_school_after_some_days
test_lanternfish_count