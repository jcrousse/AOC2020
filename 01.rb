file = open('input01.txt')
my_input =  file.readlines.map{|val| val.to_i}
my_input.combination(2).each do |val1, val2|
  if val1 + val2 == 2020
    puts val1 * val2
  end
end

def generic_solution(input_values, n_combinations)
  input_values.combination(n_combinations).each do |values|
    if values.sum == 2020
      product = 1
      values.each do  |val|
        product *= val
      end
      puts product
    end
  end
end

generic_solution(my_input, 3)