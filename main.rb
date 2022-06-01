require './lanternfish_school.rb'

input = File.read('inputDay6.txt', chomp: true).split(',').map { |item| item.to_i }

school = LanternfishSchool.new(input)
puts school.lanternfish_count(80)
