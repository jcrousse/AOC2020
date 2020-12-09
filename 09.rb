testing = false
file_name = testing ? 'input09_test.txt' : 'input09.txt'
$preamble_size = testing ? 5 : 25
file = open(file_name)

code_input =  file.readlines.map { |n| n.to_i }


puts code_input[1]

def is_sum(target_number, sublist)
  found = false
  sublist.combination(2).each do |n1, n2|
    if target_number.eql?(n1 + n2)
      found = true
      puts "#{target_number} is the sum of #{n1} and #{n2}"
      break
    end
  end
  found
end

puts is_sum(150, [1, 2, 3, 50, 7, 8, 100, 66])
puts is_sum(150, [1, 2, 3, 50, 7, 8, 99, 66])

target_num = 0

code_input[$preamble_size -1..].each_index do |idx|
  sublist = code_input[idx..idx + $preamble_size - 1]
  target_num = code_input[idx + $preamble_size]
  unless is_sum(target_num, sublist)
    puts "number #{target_num} is not the sum of previous numbers"
    break
  end
end

code_input.each_index do |idx1|
  idx2 = 0
  sublist = code_input[idx1..idx2]
  while sublist.sum < target_num
    idx2 += 1
    sublist = code_input[idx1..idx2]
  end
  if sublist.sum.eql?(target_num)
    puts "list of numbers found: #{sublist}"
    puts "minimal value: #{sublist.min}"
    puts "maximal value: #{sublist.max}"
    puts "puzzle answer: #{sublist.min + sublist.max}"
    break
  end
end

