def consolidate_cart(cart)
  new_cart = {}
  cart.each do |item|
    item.each do | i, d |
      if !new_cart[i]
        
         new_cart[i] = d
         new_cart[i][:count] = 1
      else
        new_cart[i][:count] += 1
      end
    end
  end
  new_cart
end


def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include?(coupon[:item])
      if cart[coupon[:item]][:count] >= coupon[:num]
        coupon_applied_item = "#{coupon[:item]} W/COUPON"
        if cart[coupon_applied_item]
          cart[coupon_applied_item][:count] += coupon[:num]
          cart[coupon[:item]][:count] -= coupon[:num]
        else
          cart[coupon_applied_item] = {}
          cart[coupon_applied_item][:price] = (coupon[:cost] / coupon[:num])
          cart[coupon_applied_item][:clearance] = cart[coupon[:item]][:clearance]
          cart[coupon_applied_item][:count] = coupon[:num]
          cart[coupon[:item]][:count] -= coupon[:num]
        end
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, attribute|
    if attribute[:clearance] == TRUE
      attribute[:price] = (attribute[:price] * 0.8).round(2)
    end
  end
  cart  
end

def checkout(cart, coupons)
  groceries = consolidate_cart(cart)
  cart1 = apply_coupons(groceries, coupons)
  cart2 = apply_clearance(cart1)
  
  total = 0
  
  cart2.each do |name, price|
    total += price[:price] * price[:count]
  end

total > 100 ? total * 0.9 : total
end 