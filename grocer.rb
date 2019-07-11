require 'pry'

def consolidate_cart(cart)
  # cart = [{}]
  hash = {}
  i = 0
  while i < cart.length do
    # if hash includes item
  item = cart[i]
  key = item.keys[0]
    if hash.has_key?(key)
# increment the key's value's quantity attribute. 
       i += 1     
    else
# write in a new key/value pair. The value is a hash with price, quantity, truthy/falsey
     cart.select( |i| i=i )
      
     i += 1   
     

    end
  end
  hash
end

def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
