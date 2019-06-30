require "pry"
def consolidate_cart(cart)
  new_hash = {}
    cart.each do |item|
      item.each do |key, value|
      if new_hash[key]
        new_hash[key][:count] += 1 
      else 
      new_hash[key] = value 
      new_hash[key][:count] = 1
      end
    end
  end
  new_hash
end


def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include?(coupon[:item])
      if cart[coupon[:item]][:count] >= coupon[:num]
        discount = "#{coupon[:item]} W/COUPON"
        if cart[discount] 
          cart[discount][:count] += coupon[:num]
        else
          cart[discount] = {}
          cart[discount] = {:price => coupon[:cost]/coupon[:num], :clearance => cart[coupon[:item]][:clearance], :count => coupon[:num]}
          end
        cart[coupon[:item]][:count] -= coupon[:num]
      end    
    end
  end 
  cart
end

def apply_clearance(cart)
 cart.each do |key, value|
   if value[:clearance] == true
     value[:price] = (value[:price] * 80)/100
 #binding.pry
    end
  end
  cart 
end

def checkout(cart, coupons)
  
end
