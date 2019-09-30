def consolidate_cart(cart)
  final_cart = Hash.new
  cart.each do |element_hash|
    element_name = element_hash.keys[0]
    element_values = element_hash.values[0]

    if final_cart.has_key?(element_name)
      final_cart[element_name][:count] += 1
    else
      final_cart[element_name] = element_values
      final_cart[element_name][:count] = 1
    end
  end
  return final_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    coupon_item = "#{item} W/COUPON"
    if cart[item]
      if cart.has_key?(item) && cart[item][:count] >= coupon[:num] && !cart[coupon_item]
        cart[coupon_item] = { price: coupon[:cost] / coupon[:num], clearance: cart[item][:clearance], count: coupon[:num] }
        cart[item][:count] -= coupon[:num]
      elsif cart[item][:count] >= coupon[:num] && cart[coupon_item]
        cart[coupon_item][:count] += coupon[:num]
        cart[item][:count] -= coupon[:num]
      end
    end
  end
  return cart
end

def apply_clearance(cart)
  cart.each do |product, values|
    values[:price] -= values[:price] * 0.2 if values[:clearance]
  end
  return cart
end

def checkout(array, coupons)
  hash_cart = consolidate_cart(array)
  applied_coupons = apply_coupons(hash_cart, coupons)
  applied_discount = apply_clearance(applied_coupons)
  total = applied_discount.reduce(0) { |acc, (key, value)| acc += value[:count] * value[:price]}
  total > 100 ? total * 0.9 : total
end
