require "set"

file = open('input06.txt')


survey_input =  file.readlines
survey_input_grouped = survey_input
                 .join("-")
                 .gsub("\n-\n", "linesplit")
                 .gsub(/\W/, "")
                 .split("linesplit")

puts survey_input_grouped[0]
puts survey_input_grouped[1]
puts survey_input_grouped[2]

def count_unique_letters(word)
  word.split("").uniq.length
end

count_per_group = survey_input_grouped.map{|word| count_unique_letters(word)}

puts count_per_group.sum

####   PART 2 ####

survey_input_passenger = survey_input
                         .join("-")
                         .gsub("\n-\n", "linesplit")
                         .split("linesplit")
                         .map{|group| group
                                    .gsub("\n", "")
                                    .gsub(/^-/, "")
                                    .split("-")
                                    .map{|word| Set[*word.split("")]}}

$all_letters = Set[*('a'..'z')]

def intersection_over_group(list_of_surveys)
  common_answers = list_of_surveys.reduce($all_letters) {|intersec, n| intersec.intersection(n)}
  common_answers.length
end

puts survey_input_passenger[0].to_s
puts survey_input_passenger[1].to_s
puts survey_input_passenger[2].to_s

unique_per_group = survey_input_passenger.map{|group| intersection_over_group(group)}

puts unique_per_group.sum