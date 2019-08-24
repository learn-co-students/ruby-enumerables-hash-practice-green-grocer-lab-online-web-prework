require "pry" 

def consolidate_cart(cart)
  # code here
  
  new_cart = {}
  
  cart.each do |item| 
    if new_cart[item.keys.first]
      new_cart[item.keys.first][:count] += 1 
    else 
      new_cart[item.keys.first] = item.values.first
      new_cart[item.keys.first][:count] = 1 
   end
  end 
  
  new_cart 
 
end

#coupons 

def apply_coupons(cart, coupons)
  # code here
  
  coupons.each do |coupon|
    item = coupon[:item] 
    if cart[item] 
    if cart[item][:count] >= coupon[:num] && !cart.has_key?("#{item} W/COUPON")
      cart["#{item} W/COUPON"] = {price: coupon[:cost]/coupon[:num] , clearance: cart[item][:clearance], count: coupon[:num]}
      cart[item][:count] = cart[item][:count] -= coupon[:num] 
    elsif cart[item][:count] >= coupon[:num] && cart.has_key?("#{item} W/COUPON")
      cart["#{item} W/COUPON"][:count] += coupon[:num] 
      cart[item][:count] = cart[item][:count] -= coupon[:num] 
    end 
  end 
end 
  cart 
end

#clearance 

def apply_clearance(cart)
  # code here
  cart.each do |item, item_values|
     item_values[:price] -= item_values[:price] * 0.2 if item_values[:clearance] 
  end 
  cart 
end

#checkout
def checkout(cart, coupons)
  
  hash_cart = consolidate_cart(cart) 
  
  applied_coupons = apply_coupons(hash_cart, coupons)
  
  applied_clearance = apply_clearance(applied_coupons)
  
  total = applied_clearance.reduce(0) { |acc, (key, value)| acc += value[:price]*value[:count] }
  
  total > 100 ? total * 0.9 : total 
  
end
