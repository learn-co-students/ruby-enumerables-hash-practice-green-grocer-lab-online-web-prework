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
  # iterate through coupons array
  coupons.each do |arr|
    # iterate through array to access the key (descriptor) and values (actual data)
    arr.each do |key, value|
      # if cart has the item, create new item
      if cart.include? (arr[:item]) 
        new_item = "#{arr[:item]} W/COUPON"
        cart[new_item] = {}
        cart[new_item][:count] = arr[:num]
        cart[new_item][:price] = arr[:cost] / arr[:num]
        cart[new_item][:clearance] = cart[arr[:item]][:clearance]
        
        # adjust cart count
        if cart[arr[:item]][:count] >= arr[:num]
          cart[arr[:item]][:count] -= arr[:num]
        end
        
        
      end
    end
  end
  
  # return cart
  cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end