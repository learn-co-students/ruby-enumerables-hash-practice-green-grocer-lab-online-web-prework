require 'pry'
def consolidate_cart(cart)
  new_cart = {}
  # iterate through cart to access the index of the array 
  cart.each do |arr|
    # iterate through array to access the key (item), value (details) pairs
    arr.each do |item, details|
  
      # if new_cart has the item, increment the count by 1.
      if new_cart[item]
        new_cart[item][:count] += 1
        
      # else add item and add count
      else
        new_cart[item] = details
        new_cart[item][:count] = 1
      end
    end
  end
  # return new_cart
  new_cart
end

def apply_coupons(cart, coupons)
  # iterate through coupons hash
  
  
  
  # return cart
  cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end