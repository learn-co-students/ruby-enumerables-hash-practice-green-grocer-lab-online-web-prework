require 'pry' #have access to everything local 

def consolidate_cart(cart)
  #start with array and return a hash
  
  final_hash = {}
  #when to use hash vs. map
    #return values: need operation for map to return new collection —> use map
  
  cart.each do |element_hash|
    element_name = element_hash.keys[0]
    #version 1: 
      # if final_hash[element_name] = nil   
    
    if final_hash.has_key?(element_name)
      final_hash[element_name][:count] += 1
    else
      final_hash[element_name] = {
        count: 1, 
        price: element_hash[element_name][:price],
        clearance: element_hash[element_name][:clearance]
      }
    end
  end
  final_hash
end

def apply_coupons(cart, coupons)
  # Go through each coupon to apply them iteratively
  # Looping through all the coupons in order to apply them
  coupons.each do |coupon|
    coupon_item = coupon[:item]
    # Skip this coupon if the cart does not include the coupon's item
    next unless cart.keys.include?(coupon_item)
    
    # Instantiate a bunch of variables that we're going to be working with in order to avoid confusing hash calls
    min_coupon_items = coupon[:num]
    cost_per_coupon = coupon[:cost] / min_coupon_items
    on_clearance = cart[coupon_item][:clearance]
    
    # *Skip this coupon if there aren't enough items in the cart to satisfy this coupon
    next if cart[coupon_item][:count] < min_coupon_items
    
    # Let's see if the coupon has already been added to this cart
    coupon_name = "#{coupon_item} W/COUPON"
    if cart.key?(coupon_name)
      # Instead of adding the coupon as a line item to the cart, we want to modify the existing coupon line item
      existing_number_of_coupons_applied = cart[coupon_name][:count]
      
      # Add the number of new coupons being applied to the existing number of coupons applied
      cart[coupon_name][:count] = existing_number_of_coupons_applied + min_coupon_items
      
    else # Coupon has not been added to cart
      # Add this coupon as a line item in the cart
      cart[coupon_name] = {
        price: cost_per_coupon,
        clearance: on_clearance,
        count: min_coupon_items
      }
    end
    
    # Modify the grocery item within the cart
    original_cart_item_count = cart[coupon_item][:count]
    cart[coupon_item][:count] = [original_cart_item_count - min_coupon_items, 0].max
  end
  return cart
end

def apply_clearance(cart)
  
  cart.each do |item_name, item_info|
    item_price = item_info[:price]
    on_clearence = item_info[:clearance]
    original_price = item_info[:price]
    
    #Apply clearance price
    if on_clearence
      item_info[:price] = (original_price * 0.80).round(2)
    end
  end 
  return cart
end

def checkout(cart, coupons)
  # Consolidate the cart array into a hash
  consolidated_cart = consolidate_cart(cart)
  
  # Apply coupon discounts if the proper number of items are present
  cart_with_coupons = apply_coupons(consolidated_cart, coupons)
  
  # Apply 20% discount if items are on clearance
  cart_with_discounts = apply_clearance(cart_with_coupons)
  
  #Initialize total cost of cart at $0
  cart_total_cost = 0
  
  # Totals the cost of entire cart, returns cost
  total = cart_with_discounts.reduce(0) { |acc, (key, value)| acc += (value[:price] * value[:count]) }
  # total > 100 ? total * 0.9 : total
  
  # item_total_cost = item_info[:price] * item_info[:count]
  # cart_total_cost += item_total_cost
  
  if total >= 100.00
    total = (total * 0.90).round(2)
  end
  return total
end
