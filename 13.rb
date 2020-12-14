testing = false
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
timestamp = original_timestamp
increment = original_timestamp
busses = busses[1..]

# cleanup wait times:
busses = busses.map{|b| [b[0] % b[1], b[1]]}

until stop
  idx_to_remove = []
  busses.each do |num_minutes, bus_id|
    if wait_time_for_timestamp(bus_id, timestamp).eql?(num_minutes)
      increment *= bus_id
      idx_to_remove << bus_id
    end
  end
  busses.reject!{|bus| idx_to_remove.include?(bus[1])}
  if busses.empty?
    puts timestamp
    stop = true
  end
  timestamp +=increment
end
