require 'pry'

def consolidate_cart(cart)
  organized_cart = {}
  count = 0
  cart.each do |element|
    element.each do |fruit, hash|
      organized_cart[fruit] ||= hash
      organized_cart[fruit][:count] ||= 0
      organized_cart[fruit][:count] += 1
    end
  end
  return organized_cart
end



def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    if cart[item]
        if cart[item][:count] >= coupon[:num] && !cart.has_key?("#{item} W/COUPON")
          cart["#{item} W/COUPON"] = {
          price: coupon[:cost]/coupon[:num],
          clearance: cart[item][:clearance] ,
          count: coupon[:num]
          }
          cart[item][:count] -= coupon[:num]
        else if cart[item][:count] >= coupon[:num] && cart.has_key?("#{item} W/COUPON")
          cart["#{item} W/COUPON"][:count] += coupon[:num]
          cart[item][:count] -= coupon[:num]
        end
    end
  end
end
cart
end

def apply_clearance(cart)
  cart.each do |element_name, stats|
   
   if stats[:clearance] == true 
     discount_amount = stats[:price] * 0.20
     stats[:price] -= discount_amount
   end
  end
  cart
end

def checkout(cart,coupons)
    hash_cart = consolidate_cart(cart)
    applied_coupon = apply_coupons(hash_cart, coupons)
    applied_discount = apply_clearance(applied_coupon)
    total = applied_discount.reduce(0){|item_sum,(key,value)|item_sum += value[:price] * value[:count]}
    total > 100 ? total * 0.90 : total
    # binding.pry
end

