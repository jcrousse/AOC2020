
test1 = [0, 3, 6]
test2 = [1, 3, 2]
test3 = [2, 1, 3]
test4 = [1, 2, 3]
test5 = [2, 3, 1]

part_one = false
$num_iterations = part_one ? 2020 : 30000000

my_puzzle = [6, 4, 12, 1, 20, 0, 16]


def day_15(input_values)
  spoken = []
  last_turn = []
  $num_iterations.times do |turn|
    if input_values[turn].nil?
      if last_turn[spoken[turn - 1]].nil?
        spoken[turn] = 0
      else
        spoken_number = spoken[turn - 1]
        spoken[turn] = turn - 1 - last_turn[spoken_number]
      end
      previous_number = spoken[turn - 1]
      last_turn[previous_number] = turn - 1
    else
      spoken[turn] = input_values[turn]
      last_turn[spoken[turn]] = turn
    end
  end
  spoken[-1]
end


puts day_15(test1)
puts day_15(test2)
puts day_15(test3)
puts day_15(test4)
puts day_15(test5)
puts day_15(my_puzzle)