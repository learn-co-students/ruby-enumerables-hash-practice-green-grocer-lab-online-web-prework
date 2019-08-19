require 'pry'

def consolidate_cart(cart)
  newCart = {}
  cart.each do |item|
    item.each do |key, value|
      if newCart[key]
       newCart[key][:count] += 1
      else
       newCart[key] = value
       newCart[key][:count] = 1
      end
    end
  end
  return newCart
end
  

def apply_coupons(cart, coupons)
  coupons.each {|coupon|
    if cart[coupon[:item]] and (cart[coupon[:item]][:count] >= coupon[:num])
        if cart["#{coupon[:item]} W/COUPON"] 
          cart["#{coupon[:item]} W/COUPON"][:count] += coupon[:num]
        else
          newName = "#{coupon[:item]} W/COUPON"
          cart[newName] = {}
          cart[newName][:price] = (coupon[:cost]/coupon[:num])
          cart[newName][:clearance] = cart[coupon[:item]][:clearance]
          cart[newName][:count] = coupon[:num]
        end
        cart[coupon[:item]][:count]  -=coupon[:num]
        
    end
      
  }
  return cart
  
 end 
  
  
  

def apply_clearance(cart)
  cart.each do |key, value|
    if value[:clearance] == TRUE
      value[:price] = (value[:price] *0.8).round(2)
    end
  end
  return cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0
  cart.each do |key, value|
    total += (value[:price] * value[:count])
  end
  if total > 100
    total = (total * 0.9).round(2)
end
  return total
end
