file = open('input02.txt')

def get_min_max(min_max_str)
  min_val, max_val = min_max_str.split('-')
  return min_val.to_i, max_val.to_i
end

def check_count(min_val, max_val, password, letter_check)
  count_letter = password.count(letter_check)
  result = 0
  if count_letter.between?(min_val, max_val)
    result = 1
  end
  result
end

def check_pos(min_val, max_val, password, letter_check)
  result = 0
  if password[min_val].eql?(letter_check)
    result += 1
  end
  if password[max_val].eql?(letter_check)
    result += 1
  end
  result.modulo(2)
end

def preprocess(input_line, check_type)
  definition, password = input_line.split(':')
  min_max, letter_check = definition.split(' ')
  min_val, max_val = get_min_max(min_max)
  if check_type.eql?("count")
    check_count(min_val, max_val, password, letter_check)
  elsif check_type.eql?("pos")
    check_pos(min_val, max_val, password, letter_check)
  end
end

# challenge1 =  file.readlines.map{|val| preprocess(val, "count")}
# puts challenge1.sum

challenge2 =  file.readlines.map{|val| preprocess(val, "pos")}
puts challenge2.sum