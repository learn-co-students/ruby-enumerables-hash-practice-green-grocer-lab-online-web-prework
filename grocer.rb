# Method. consolidate_cart
def consolidate_cart(cart)
  
  # Create new hash to fill
  new_cart = {}
  
  # Iterate over each element of cart array
  cart.each do |hash|
    
    # For each element take item & description, then set as key & value
    hash.each do |item, descr|
      
      # Increment count by 1 if item already present in new_cart hash
      if new_cart[item]
        new_cart[item][:count] += 1
      
      # If item not present in new_cart hash, set item as key, descr as value, & item count to 1
      else
        new_cart[item] = descr
        new_cart[item][:count] = 1
      end
      
    end
    
  end
  
  new_cart
  
end


# Method. apply_coupons
def apply_coupons(cart, coupons)

  # If there are no coupons, break and return cart
  return cart if coupons == []

  # Create new_cart var, set it equal to cart, and make changes
  new_cart = cart

  # Iterates over each element in array coupons
  coupons.each do |coupon|  # Each coupon is a hash w/ key & value
    c_name = coupon[:item]
    c_num = coupon[:num]
    
    # If cart has item & coupon && item count >= num of coupons
    if cart.include?(c_name) && cart[c_name][:count] >= c_num
      
      # Subtract item count in cart by num of coupons 
      new_cart[c_name][:count] -= c_num
      
      # If item "W/ COUPON" exists, increment count by 1
      if new_cart.has_key?("#{c_name} W/COUPON")
        new_cart["#{c_name} W/COUPON"][:count] += coupon[:num]
        
      # Else add item "W/ COUPON" to cart hash
      else
        new_cart["#{c_name} W/COUPON"] = {
          :price => (coupon[:cost] / coupon[:num]),
          :clearance => new_cart[c_name][:clearance],
          :count => coupon[:num]
        }
        
      end
      
    end
    
  end
   
   new_cart
   
end


# Method. apply_clearance
def apply_clearance(cart)

  # Create new_cart hash, set equal to cart, in order to make changes to orig
  new_cart = cart

  # Iterate over each item. If clearance = true, take 20% off.
  cart.each do |item, hash|
      if hash[:clearance]
        new_cart[item][:price] = (cart[item][:price] * 0.8).round(2)
      end
  end
  
  new_cart

end


# Method. checkout
def checkout(cart, coupons)

  # Consolidate cart array into cart hash
  new_cart = consolidate_cart(cart)
  
  # Apply coupons to cart
  apply_coupons(new_cart, coupons)
  
  # Apply clearance to cart
  apply_clearance(new_cart)

  # Create total var for total price
  total = 0

  # Add up all item prices for total
  new_cart.each do |name, hash|
    total += (hash[:price] * hash[:count])
  end

  # If total price is greater than $100, take 10% off
  if total >= 100
    total *= 0.9
  end

  total
  
end


