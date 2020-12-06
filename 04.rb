file = open('input04.txt')

passports_input =  file.readlines
passport_lines = passports_input
                   .join(" ")
                   .gsub("\n \n", "linesplit")
                   .gsub("\n", "")
                   .split("linesplit")
                   .map{|val| val
                                .lstrip
                                .split(" ")
                                .map{|subval| subval.split(":")}}
                   .map{|val| Hash[*val.collect {|v| [v[0], v[1]]}.flatten]}

$required_keys = %w(byr iyr eyr hgt hcl ecl pid)

def height_check(height_input)
  check_val = false
  unless height_input.nil?
    height = height_input[0..-3].to_i
    unit = height_input[-2..]
    if unit.eql? "cm"
      check_val = height.between?(150, 193)
    else
      check_val = height.between?(59, 76)
    end
  end
  check_val
end

def check_hair_color(hair_input)
  check_val = false
  unless hair_input.nil?
    if hair_input[0].eql? "#" and hair_input.length == 7
      check_val = hair_input[1..].match? "^[a-zA-Z0-9]*$"
    end
  end
  check_val
end

def check_passportid(passport_id)
  check_val = false
  unless passport_id.nil?
    check_val = passport_id.length.eql?(9) and passport_id.match? "^[0-9]*$"
  end
  check_val
end

valid_hair_color = %w(amb blu brn gry grn hzl oth)

check_functions = {}
check_functions['byr'] = lambda {|var| var.to_i.between?(1920, 2002)}
check_functions['iyr'] = lambda {|var| var.to_i.between?(2010, 2020)}
check_functions['eyr'] = lambda {|var| var.to_i.between?(2020, 2030)}
check_functions['hgt'] = lambda {|var| height_check(var)}
check_functions['hcl'] = lambda {|var| check_hair_color(var)} # check_hair_color(var)
check_functions['ecl'] = lambda {|var| valid_hair_color.include?(var)}
check_functions['pid'] = lambda {|var| check_passportid(var)}


def check_passport(passport, check_functions)
  # has_all_entries = $required_keys.map{|k| passport.keys.include?(k)}.all?
  all_valid = check_functions.map {|k, v| v[passport[k]]}.all?
end

validity_checks = passport_lines.map{ |passport| check_passport(passport, check_functions) ? 1 : 0}

puts validity_checks.sum