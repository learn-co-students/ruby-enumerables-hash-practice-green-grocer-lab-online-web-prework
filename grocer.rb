def consolidate_cart(cart)
  new_cart = {}
  cart.each do |cart_hash|
    item = cart_hash.keys[0]
    stats = cart_hash.values[0]
    if new_cart.has_key?(item)
      stats[:count] += 1
    else
      new_cart[item] = stats
      stats[:count] = 1
    end
  end
  return new_cart
end

def apply_coupons(cart, coupons)
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
  cart.each do |item, stats|
    stats[:price] -= stats[:price] * 0.2 if stats[:clearance]
  end
  cart
end

def checkout(cart, coupons)
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
