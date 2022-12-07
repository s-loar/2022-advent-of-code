require_relative 'calorie_counter'

calorie_counter = CalorieCounter.new

# calorie_counter.write_rows

puts "1st problem: #{calorie_counter.find_max_carried}"

puts "2nd problem: #{calorie_counter.sum_of_top_3}"