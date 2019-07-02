require "pry"

def consolidate_cart(cart)
  new_cart = {}
  cart.each do |hash|
    hash.each do |name, price_clearance|
      if new_cart.has_key?(name) == false
        new_cart[name] = price_clearance
        new_cart[name][:count] = 1
      elsif new_cart.has_key?(name) 
        new_cart[name][:count] += 1
      end
    end
  end 
  new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon_hash|
    item_name = coupon_hash[:item]
    new_item = "#{item_name} W/COUPON"
        
    if cart.has_key?(item_name) && cart[item_name][:count] >= coupon_hash[:num]
      if cart.has_key?(new_item)
         cart[new_item][:count] += coupon_hash[:num]
        cart[item_name][:count] -= coupon_hash[:num]
        
      else 
      cart[new_item] = {
        :price => (coupon_hash[:cost] / coupon_hash[:num]),
        :clearance => cart[item_name][:clearance],
        :count => coupon_hash[:num]
      }
      cart[item_name][:count] -= coupon_hash[:num] 
    end 
    end 
  end 
  cart
end

def apply_clearance(cart)
  cart.each do |item, price_clearance|
    if cart[item][:clearance] == true
      cart[item][:price] = (cart[item][:price]*0.80).round(2)
    end 
  end 
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)
  
  total = 0
  
  clearance_cart.each do |item, price_clearance|
    total += price_clearance[:price] * price_clearance[:count] 
  end 
  if total > 100
    total = (total * 0.90).round(2)
  end 
  total
end
