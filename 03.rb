file = open('input03.txt')

tree_matrix =  file.readlines.map{|val| val}

def get_collisions(tree_positions, n_right=3, n_down=1)
  input_width = tree_positions[0].length
  current_position = 0
  total_trees = 0
  tree_positions.each_index do |idx|
    if idx.modulo(n_down).eql?(0)
      input_line = tree_positions[idx]
      if input_line[current_position].eql? '#'
        total_trees += 1
        # input_line[current_position] = 'X'
      else
        # input_line[current_position] = 'O'
      end
      current_position = (current_position + n_right).modulo(input_width - 1)
    end
    # puts input_line
  end
  total_trees
end


# puts get_collisions(tree_matrix, 3, 1)
#
slopes_check = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
product = 1
slopes_check.each do |input_parameters|
  n_trees = get_collisions(tree_matrix, input_parameters[0], input_parameters[1])
  product *= n_trees
  puts n_trees
end

puts product