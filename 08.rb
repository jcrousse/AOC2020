file = open('input08.txt')

code_input =  file.readlines.map { |code_line|  [code_line[0..2], code_line[4..].to_i]}


def run_input(code_input)
  total_instructions = code_input.length
  accumulator = 0
  current_idx = 0
  already_visited = []
  while already_visited[current_idx].nil? and current_idx < total_instructions
    already_visited[current_idx] = true
    instruction, amount = code_input[current_idx]
    if instruction.eql?("jmp")
      current_idx += amount
    else
      current_idx +=1
      if instruction.eql?('acc')
        accumulator += amount
      end
    end
  end
  program_ends =  current_idx.eql?(total_instructions)
  [accumulator, program_ends, already_visited]
end

final_acc, did_end, visited_idx = run_input(code_input)
puts final_acc
puts did_end


code_input.each_index do |line_idx|
  instruction, _ = code_input[line_idx]
  if instruction.eql?("jmp")
    code_input[line_idx][0] = "nop"
    acc, ends, _ = run_input(code_input)
    if ends
      puts acc
    end
    code_input[line_idx][0] = "jmp"
  elsif instruction.eql?("nop")
    # todo: try all jump destinations not in visited_idx
    code_input[line_idx][0] = "nop"
  end
end