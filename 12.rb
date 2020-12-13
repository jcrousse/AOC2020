testing = false
file_name = testing ? 'input12_test.txt' : 'input12.txt'
file = open(file_name).readlines

class Boat
  attr_reader :position
  def initialize
    @direction_idx = 0
    @position = [0, 0]
    @directions = [[1,0], [0, -1], [-1, 0], [0, 1]]
    @cardinals = %w(E S W N)
  end

  def rotate(direction, degrees)
    rotate_val = direction.eql?('R')  ? 1 : -1
    rotate_num = degrees / 90
    @direction_idx = (@direction_idx + rotate_val * rotate_num) % 4
  end

  def get_direction
    @directions[@direction_idx]
  end

  def forward(move_len)
    move(@directions[@direction_idx], move_len)
  end

  def move(direction, move_len)
    # position = position + move_len * direction vector
    @position = [@position, direction.map{|e| e * move_len}].transpose.map {|x| x.reduce(:+)}
  end

  def translation(direction, move_len)
    move(@directions[@cardinals.index(direction)], move_len)
  end

  def jf_manatane_distance
    @position[0].abs + @position[1].abs
  end

  def do_instruction(instruction)
    instruction = instruction.gsub("\n", '')
    instruction_type = instruction[0]
    instruction_num = instruction[1..].to_i
    case instruction_type
    when 'F'
      forward(instruction_num)
    when 'R', 'L'
      rotate(instruction_type, instruction_num)
    else
      translation(instruction_type, instruction_num)
    end
  end
end

boaty_mc_boatface = Boat.new

file.map { |v| boaty_mc_boatface.do_instruction(v)  }
puts boaty_mc_boatface.jf_manatane_distance

"""Part two: directions become waypoints.
  -@waypoint value
  -E/S/W/N means moving the vector in @directions by the given cardinal and value
  -

"""

class BoatWaypoint < Boat
  attr_reader :position
  def initialize
    @direction_idx = 0
    @position = [0, 0]
    @waypoint = [10, 1]
    @directions = [[1,0], [0, -1], [-1, 0], [0, 1]]
    @cardinals = %w(E S W N)
  end

  def rotate(direction, degrees)
    rotate_val = direction.eql?('R')  ? 1 : 0
    rotate_num = degrees / 90
    rotate_num.times do
      @waypoint[0], @waypoint[1] = @waypoint[1], @waypoint[0]
      @waypoint[rotate_val] *= -1
    end
  end

  def get_direction
    @directions[@direction_idx]
  end

  def forward(move_len)
    @position[0], @position[1] =
      @position[0] + move_len * @waypoint[0], @position[1] + move_len * @waypoint[1]
  end

  def move_wp(direction, move_len)
    # waypoint = waypoint + move_len * direction vector
    @waypoint = [@waypoint, direction.map{|e| e * move_len}].transpose.map {|x| x.reduce(:+)}
  end

  def translation(direction, move_len)
    move_wp(@directions[@cardinals.index(direction)], move_len)
  end

end

el_boato = BoatWaypoint.new

file.map { |v| el_boato.do_instruction(v)  }
puts el_boato.jf_manatane_distance