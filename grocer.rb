require "pry"
def consolidate_cart(cart)
  consolidated_hash = {}
  cart.each do |item|
    if consolidated_hash[item.keys[0]] 
     consolidated_hash[item.keys[0]][:count] +=1 
    else 
      consolidated_hash[item.keys[0]] = {
        price: item.values[0][:price],
        clearance: item.values[0][:clearance], 
        count: 1 
      } 
    end
  end
  consolidated_hash
end 
  

def apply_coupons(cart, coupons)
  coupons.each do |coupon| 
    coupon.each do |attribute, value| 
      name = coupon[:item] 
      if cart[name] && cart[name][:count] >= coupon[:num] 
        if cart["#{name} W/COUPON"] 
          cart["#{name} W/COUPON"][:count] += coupon[:num] 
        else 
          cart["#{name} W/COUPON"] = {:price => coupon[:cost]/coupon[:num], 
          :clearance => cart[name][:clearance], :count => coupon[:num]} 
        end 
        cart[name][:count] = cart[name][:count] - coupon[:num] 
      end 
    end 
  end 
  return cart 
end

def apply_clearance(cart)
  cart.each do |food, attribute|
    if attribute[:clearance] == true 
      attribute[:price] = (attribute[:price] * 0.8).round(2) 
    end 
  end 
  return cart
end

def checkout(cart, coupons)
  total = 0 
  checkout_cart = consolidate_cart(cart)
  checkout_coupon = apply_coupons(checkout_cart, coupons)
  checkout_clearance = apply_clearance(checkout_coupon)
  
  checkout_clearance.each do |food, attribute|
    total += (attribute[:price] * attribute[:count])
      if total > 100 
        total = total * 0.90
      end 
  end 
  return total 
end

