#def consolidate_cart(cart)
#  windfall = []
#  cart.each {|item| windfall.push([(item.keys)[0], item[(item.keys)[0]]])}
#  p windfall
#  organized_cart = {}
#  windfall.length.times { |index|
#    cart_key = windfall[index]
#    if organized_cart.keys.include? windfall[index] 
#      organized_cart[cart_key][:count] += 1
#    else
#      organized_cart[cart_key] => windfall[index]
#      organized_cart[cart_key][:count] => 0
#    end
#  }
#end

def

#def consolidate_cart(cart)
#  overcart = {} #creates the hash that the method will return
#  cart.length.times { |index| #asks to iterate over every hash in the cart array
#    if overcart.key?(cart[index].keys[0]) # if the product already exists in overcart...
#      overcart[cart[index].keys[0]][:count] += 1 #...increase the count of the product by one
#    else #if overcart does not yet contain the product...
#      overcart[cart[index].keys[0]] = cart[index].keys[0]
#      overcart[cart[index].keys[0]][:count] = 0
#    end
#  }
#  puts overcart
#end

def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end

craving = [
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"KALE"    => {:price => 3.00, :clearance => false}}
]

consolidate_cart(craving)