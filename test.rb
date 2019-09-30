array =     [
      {"AVOCADO" => {:price => 3.00, :clearance => true }},
      {"AVOCADO" => {:price => 3.00, :clearance => true }},
      {"KALE"    => {:price => 3.00, :clearance => false}}
    ]

def convert_array(array)
  array.each { |pair| p pair }
end

convert_array(array)
puts array.inject(:update)
