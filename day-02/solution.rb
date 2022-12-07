require_relative 'rps_counter'

rps_counter = RpsCounter.new

puts "1st problem: #{rps_counter.play}"

puts "2nd problem: #{rps_counter.play_as_directed}"