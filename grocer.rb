require 'pry'

def consolidate_cart(cart)
  # code here
  new_cart = {}
  cart.each do |item| #goes through OG array
    item.each do |key, value| #take key and values from hash of first Array
      if new_cart[key] == nil   #if first hash has no key
          new_cart[key] = value #assign first hash key a value
          new_cart[key][:count] = 1 #add the count plus 1
      else 
          new_cart[key][:count] += 1
      end
    end
  end  
  new_cart
end

def apply_coupons(cart, coupons)
  # code here
    coupons.each do |coupon|
    item = coupon[:item]
    if cart.has_key?(item)
      if cart[item][:count] >= coupon[:num] && !cart["#{item} W/COUPON"]
        cart["#{item} W/COUPON"] = {price: coupon[:cost] / coupon[:num], clearance: cart[item][:clearance], count: coupon[:num]}
        cart[item][:count] -= coupon[:num]
      elsif cart[item][:count] >= coupon[:num] && cart["#{item} W/COUPON"]
      cart["#{item} W/COUPON"][:count] += coupon[:num]
      cart[item][:count] -= coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |key, value|
    if cart[key][:clearance] == true
    cart[key][:price] = (cart[key][:price] * 0.8).round(2)
    #binding.pry
   end
  end
end

def checkout(cart, coupons)
  # code here
  new_cart = consolidate_cart(cart)
  discount_cart = apply_coupons(new_cart, coupons)
  clearance_cart = apply_clearance(discount_cart)
  total = clearance_cart.reduce(0) { |acc, (key, value)| acc += value[:price] * value[:count]}
  if total > 100
    total * 0.9
  else
    total
  end
end
