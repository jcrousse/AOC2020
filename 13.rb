testing = true
file_name = testing ? 'input13_test.txt' : 'input13.txt'
file = open(file_name).readlines

timestamp = file[0].gsub("\n", "").to_i

busses = file[1].split(',').reject {|e| e.eql?("x")}.map{|bus| bus.to_i}
puts timestamp
puts busses

busses_wait_time = busses.map{|bus| ((timestamp / bus) * bus + bus) % timestamp}

minimal_wait_time = busses_wait_time.min
min_bus = busses[busses_wait_time.index(minimal_wait_time)]

puts "minimal_wait_time: #{minimal_wait_time} for bus #{min_bus}"
puts "puzzle answer part one: #{minimal_wait_time * min_bus}"

### Part two

file = open(file_name).readlines
busses = file[1].split(',').each_with_index.map { |bus_s, idx | Hash[idx  => bus_s] }
                .reduce({}) {|all_items, tmp| all_items.merge(tmp)}
           .reject {|_, v| v.eql?('x')}
           .each.map { |k, v|  [k, v.to_i] }

stop = false

def wait_time_for_timestamp(bus_id, timestamp)
  if (timestamp % bus_id).eql?(0)
    0
  else
    bus_id -  timestamp % bus_id
  end
end

original_timestamp = busses[0][1]
# busses[0][0] = original_timestamp
timestamp = original_timestamp
until stop
  total_valid = 0
  busses.each do |num_minutes, bus_id|
    unless wait_time_for_timestamp(bus_id, timestamp).eql?(num_minutes)
      break
    end
    total_valid += 1
  end
  if total_valid.eql?(busses.length)
    puts timestamp
    stop = true
  end
  timestamp +=original_timestamp
end

# 1068781
# 100000000000000
