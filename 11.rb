testing = false
file_name = testing ? 'input11_test.txt' : 'input11.txt'
file = open(file_name).readlines

def to_numeric_row(str_row)
  str_row.split('').each do |single_char|
    puts single_char
  end
end

class Seat
  attr_accessor :adjacent_seats, :row_position, :col_position
  attr_reader :occupied
  def initialize(str_value)
    @occupied = 0
    @usable = str_value.eql?('L') ? 1 : 0
    @adjacent_seats = []
    @next_round = 0
    @row_position = 0
    @col_position = 0
  end

  def to_s
    if @usable.eql?(1)
      @occupied.eql?(1) ? '#' : 'L'
    else
      '.'
    end
  end

  def to_i
    @occupied
  end

  def +(other)
    @occupied + other.occupied
  end

  def coerce(other)
    [other.to_i, @occupied]
  end

  def calc_next_round
    case @adjacent_seats.sum
    when 0
      @next_round = 1 * @usable
    when 5..10
      @next_round = 0
    else
      @next_round = @occupied
    end
  end

  def update
    @occupied = @next_round
  end

  def stable?
    @occupied.eql? @next_round
  end

  def usable?
    @usable.eql?(1)
  end
end

class SeatingGrid
  def initialize(seating_map)
    @seating_rows = []
    seating_map.each do |r|
      @seating_rows << r.gsub("\n", "").split('').map{|e| Seat.new(e)}
    end
    @width = @seating_rows[0].length
    @height = @seating_rows.length

    # @seating_rows.each_index { |r_idx| @seating_rows[r_idx].each_index { |c_idx|  surrounding_seats(r_idx, c_idx)}}
    @seating_rows.each_index { |r_idx| @seating_rows[r_idx].each_index { |c_idx|  visible_seats(r_idx, c_idx)}}
  end

  def to_s
    @seating_rows.map { |r| r.join('') }.join("\n")
  end

  def surrounding_seats(r_idx, c_idx)
    @seating_rows[r_idx][c_idx].row_position = r_idx
    @seating_rows[r_idx][c_idx].col_position = c_idx
    3.times do |r_id_2|
      3.times do |c_id_2|
        adjacent_row = r_idx + r_id_2 - 1
        adjacent_col = c_idx + c_id_2 - 1
        if (adjacent_row).between?(0, @height - 1) and (adjacent_col).between?(0, @width - 1)
          unless r_id_2.eql?(1) and c_id_2.eql?(1)
            @seating_rows[r_idx][c_idx].adjacent_seats << @seating_rows[adjacent_row][adjacent_col]
          end
        end
      end
    end
  end

  def visible_seats(r_idx, c_idx)
    @seating_rows[r_idx][c_idx].row_position = r_idx
    @seating_rows[r_idx][c_idx].col_position = c_idx
    3.times do |r_id_2|
      3.times do |c_id_2|
        direction_row = r_id_2 - 1
        direction_col = c_id_2 - 1
        distance = 1
        unless direction_row.eql?0 and direction_col.eql? 0
          adjacent_row = r_idx + distance * direction_row
          adjacent_col = c_idx + distance * direction_col
          while (adjacent_row).between?(0, @height - 1) and (adjacent_col).between?(0, @width - 1) and
            not @seating_rows[adjacent_row][adjacent_col].usable?
              distance += 1
              adjacent_row = r_idx + distance * direction_row
              adjacent_col = c_idx + distance * direction_col
          end
          if (adjacent_row).between?(0, @height - 1) and (adjacent_col).between?(0, @width - 1)
              @seating_rows[r_idx][c_idx].adjacent_seats << @seating_rows[adjacent_row][adjacent_col]
          end
        end
      end
    end
  end

  def calc_next_round
    @seating_rows.each { |r| r.each { |s| s.calc_next_round}}
  end
  def update_seats
    @seating_rows.each { |r| r.each { |s| s.update}}
  end
  def stabilized?
    @seating_rows.map { |row| row.map { |seat| seat.stable?}.all?}.all?
  end
  def total_seats
    @seating_rows.map { |row| row.sum}.sum
  end
end

seating_matrix = SeatingGrid.new(file)

puts seating_matrix
seating_matrix.calc_next_round
idx = 0
until seating_matrix.stabilized? do
  puts seating_matrix
  seating_matrix.update_seats
  puts "\n\n---update round #{idx += 1}---\n\n"
  seating_matrix.calc_next_round
end

puts "total number of occupied seats: #{seating_matrix.total_seats}"