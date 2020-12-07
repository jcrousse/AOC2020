
file = open('input07.txt')

luggage_input =  file.readlines

puts luggage_input[0]

def process_rule(rule)
  rule_parts = rule.split("contain")
  key_part = quick_cleanup(rule_parts[0])
  sub_rules = rule_parts[1].split(',')
  if sub_rules[0].include?("no other bag")
    sub_rules = {"invalid_color" => 1}
  else
    sub_rules = wrapup_hash(sub_rules.map{|sr| get_rule_details(sr)})
  end
  {key_part => sub_rules}
end

def get_rule_details(sub_rule)
  cleaned_rule = quick_cleanup(sub_rule)
  {cleaned_rule[2..] => cleaned_rule[0].to_i}
end

def quick_cleanup(bag_color)
  bag_color.lstrip.gsub(/bag(s)?(\.)?/, "").rstrip
end

def wrapup_hash(hash_list)
  hash_list.reduce({}) {|all_subs, tmp| all_subs.merge(tmp)}
end

$rule_mapping = wrapup_hash(luggage_input.map { |v| process_rule(v) })

def can_contain_gold(bag_color)
  if bag_color.eql?("invalid_color")
    return_value = false
  elsif $rule_mapping[bag_color].include?("shiny gold")
    return_value = true
  else
    return_value = $rule_mapping[bag_color].keys.map{|v| can_contain_gold(v)}.any?
  end
  return_value
end

def how_many_bags(bag_color)
  return_value = 0
  $rule_mapping[bag_color].each do |k, v|
    unless k.eql?("invalid_color")
      return_value += v * how_many_bags(k) + v
    end
  end
  return_value
end

can_contain = $rule_mapping.keys.map{|v| can_contain_gold(v) ? 1 : 0}

puts can_contain.sum

puts how_many_bags("shiny gold")