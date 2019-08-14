def consolidate_cart(cart) 
# Defined method which takes an array as an argument.

  new_hash = {} 
  # Creates new hash to store final hash.
  
  cart.each do |item_array|
  # Iterates through each item (called item_array) in the array (cart) and uses it as an argument.
  
    item_array.each do |name, property_hash|
    # Gets into the key level, as opposed to the name level as above.
    
      new_hash[name] ||= property_hash
      # Checks if new_hash includes the item key (it doesn't).
      # The ||= operator will check if the statement on the left is true. If it is, it will continue to the next line of code.
      # If the statement is falsey, it will set the statement on the left equal to the statement on the right.
      # So on the first iteration, the statement on the left is nil because no keys exist yet, so it will set it equal to property_hash, thus creating a new k/v pair for the current item.
      
      new_hash[name][:count] ? new_hash[name][:count] += 1 : new_hash[name][:count] = 1
      # Ternary statement. Either add to count (if true) or create count k/v pair (if false).
      
    end
  end
  
  new_hash
  # Returns new hash.
  
end


def apply_coupons(cart, coupons)
# Defined method which takes two arrays as arguments.
  
  coupons.each do |coupon|
   # We start by iterating into our coupons array with .each.
   
    if cart.keys.include?(coupon[:item])
    # If our cart includes the couponed item in question, carry on. If not, skip to the end of the method and return to cart.
    
      if cart[coupon[:item]][:count] >= coupon[:num]
      # If the number of these matching items in the cart is greater than or equal to the number of items redeemable against the coupon, carry on. If not, skip to end of method and return to cart.
      
        item_with_coupon = "#{coupon[:item]} W/COUPON"
        # Assign the actual coupon name (interpolating the item for abstraction) to the variable 'item_with_coupon'.
        
        if cart[item_with_coupon]
          # Does our cart include the coupon itself? It won't on first iteration (skip to 'else' to see what happens). If so, carry on.
          
          cart[item_with_coupon][:count] += coupon[:num]
          # Our cart already contains the coupon so increase the count by the number of items redeemable against the coupon.
          
          cart[coupon[:item]][:count] -= coupon[:num]
          # Reduce our coupon's count by the number of items redeemable against the coupon - the avocado coupon is now spent.
          
        else
          cart[item_with_coupon] = {}
          # Since out cart does not have the coupon, reate an empty hash for the item, matching our existing hash structure.
          
          cart[item_with_coupon][:price] = (coupon[:cost] / coupon[:num])
          # Pulling values from existing coupon. Set price key at value of the coupon cost divided by the number of items required by the coupon. So the avocado coupon price is set at 2.50 (5.00 divided by two items).
          
          cart[item_with_coupon][:clearance] = cart[coupon[:item]][:clearance]
          # The clearance key is set at whether or not the original item was on clearance in the cart (this is true for avocado).
          
          cart[item_with_coupon][:count] = coupon[:num]
          # The count key for the new hash is set to the number of items redeemable against the coupon.
          
          cart[coupon[:item]][:count] -= coupon[:num]
          # Reduce our coupon's count by the number of items redeemable against the coupon - the avocado coupon is now spent.
          
        end
      end
    end
  end
  
  cart
  # Return the new value of cart.

end


def apply_clearance(cart)
# Defined method which takes an array as an argument.

  cart.each do |item, property_hash|
  # Iterate into our cart with .each.
  
    if property_hash[:clearance]
    # Use an "if" statement to check if the :clearance key is truthy. If so, carry on. If not, exit statement and return to cart.
    
      property_hash[:price] = (property_hash[:price] * 0.8).round(2)
      # Need to get discounted price. 20% off is the same as multiplying by 0.8. Assign this value to :price key. Spec requires rounding to 2 decimal places.
      
    end
  end
  
  cart
  # Return new cart.
  
end


def checkout(items, coupons)
# Defined method which takes two arrays as arguments.

  cart = consolidate_cart(items)
  # Run the consolidate_cart method to incorporate it into the final total.
  
  after_coupons = apply_coupons(cart, coupons)
  # Run the apply_coupons method on cart and coupons to incorporate it into the final total.
  
  after_coupons_and_clearance = apply_clearance(after_coupons)
  # Run the apply_clearance method on after_coupons incorporate it into the final total.
  
  total = 0
  # The variable which stores the final total.
  
  after_coupons_and_clearance.each do |name, property_hash|
  # iterate into after_coupons_and_clearance to can total all products.
    
    total += property_hash[:price] * property_hash[:count]
    # Increments total by (price * number of items) as it iterates.
    
  end
  
  total > 100 ? total * 0.9 : total
  # Ternary. If the total is more than 100, discount by 10%, otherwise it remains as it is. Implicit return.
  
end