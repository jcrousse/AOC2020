file = open('input05.txt')
seats_input =  file.readlines

def binarypartition_to_seatid(partition)
  row_val = partition[0..7].gsub('F', '0').gsub('B', '1').to_i(2)
  col_val = partition[7..].gsub('L', '0').gsub('R', '1').to_i(2)
  seat_id = row_val * 8 + col_val
  puts seat_id
  seat_id
end

puts binarypartition_to_seatid("BFFFBBFRRR")
puts binarypartition_to_seatid("FFFBBBFRRR")
puts binarypartition_to_seatid("BBFFBBFRLL")

seat_ids = seats_input.map{|val| binarypartition_to_seatid(val)}

puts seat_ids.max