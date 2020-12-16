testing = false
file_name = testing ? 'input14_test.txt' : 'input14.txt'
file = open(file_name).readlines


mem = []

mask0 = mask1 = 0
file.each do |instruction|

  if instruction[0..3].eql? 'mask'
    mask0 = instruction[7..].gsub('X', '1').to_i(2)
    mask1 = instruction[7..].gsub('X', '0').to_i(2)
  else
    mem_address = instruction[4..].gsub(/].*/, "").to_i
    mem_amt = instruction.match(/=.*/).to_s[1..].to_i
    changed_val = (mem_amt & mask0) | mask1
    mem[mem_address] = changed_val
  end
end

puts mem.reject { |n| n.nil?}.sum


## part 2

mem = []

def floating_indices(str_mask)
  idx_x = []
  str_mask.split('').each_with_index  do |e, idx|
    if e.eql? 'X'
      idx_x << 35 - idx
    end
  end
  idx_x
end

mask1 = 0
float_idx = []

mem = Hash.new(0)

file.each do |instruction|

  if instruction[0..3].eql? 'mask'
    # mask0 = instruction[7..].gsub('X', '1').to_i(2)
    mask1 = instruction[7..].gsub('X', '0').to_i(2)
    float_idx = floating_indices(instruction[7..])
  else
    mem_address = instruction[4..].gsub(/].*/, "").to_i  | mask1

    mem_amt = instruction.match(/=.*/).to_s[1..].to_i
    p = float_idx.length
    (2**p).times do |n|
      mem_address_new = mem_address
      str_rep = n.to_s(2).rjust(p, '0').split('')
      float_idx.each_with_index do |idx_mask, idx_rep|
        if str_rep[idx_rep] == '0'
          mem_address_new = mem_address_new & (("1" * 36).to_i(2) - 2 ** idx_mask)
        else
          mem_address_new = mem_address_new | 2**idx_mask
        end
      end
      mem[mem_address_new] = mem_amt
    end
  end
end

puts mem.values.sum