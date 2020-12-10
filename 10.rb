testing = false
file_name = testing ? 'input10_test.txt' : 'input10.txt'

file = open(file_name)

adapter_input = file.readlines.map { |n| n.to_i }
adapter_input << 0
adapter_input.sort!

# adapter_input = (1..15).to_a

puts adapter_input[0]
puts adapter_input[1]

total_jmp1 = 0
total_jmp3 = 1

adapter_input.each_index do |idx|
  unless idx == adapter_input.length - 1
    if 3.eql? adapter_input[idx + 1] - adapter_input[idx]
      total_jmp3 += 1
    else
      total_jmp1 += 1
    end
  end
end

puts "jumps of 1: #{total_jmp1}"
puts "jumps of 3: #{total_jmp3}"
puts "Puzzle answer: #{total_jmp3 * total_jmp1}"

exists_in_sequence = []
adapter_input.each { |v| exists_in_sequence[v] = true }

number_paths = [1]

exists_in_sequence.each_index do |idx|
  unless exists_in_sequence[idx].nil?
    number_paths[idx] = number_paths[idx - 1].to_i
    if idx > 1
      number_paths[idx] += number_paths[idx - 2].to_i
      if idx > 2
        number_paths[idx] += number_paths[idx - 3].to_i
      end
    end
  end
end

puts number_paths