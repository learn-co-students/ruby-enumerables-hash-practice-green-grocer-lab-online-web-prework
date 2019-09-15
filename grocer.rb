def consolidate_cart(cart)
  # code here
  cart_hash = {}
  cart.each do |items|
    items.each do |key_food, value_info|
      cart_hash[key_food] = value_info
      cart_hash[key_food][:count] ||= 0
      cart_hash[key_food][:count] += 1
    end
  end  
  cart_hash  
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
  # code here
  cart.each do |food, info|
  if cart[food][:clearance]
      new_price = info[:price] - (info[:price] * 0.2)
      info[:price] = new_price.round(2)
    end  
  end  
  cart     
end

def checkout(cart, coupons)
  # code here
  total = 0
  groceries = consolidate_cart(cart)
  cart1 = apply_coupons(groceries, coupons)
  cart2 = apply_clearance(cart1)

  cart2.each do |name, price|
    total += price[:price] * price[:count]
  end
  
  if total > 100
    total - (total / 10)
  else
    total
  end

end
