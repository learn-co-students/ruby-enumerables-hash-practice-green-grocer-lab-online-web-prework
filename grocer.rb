require "byebug"
def consolidate_cart(cart)
  items = {}
  cart.each do |item|
    if !items.has_key?(item.keys.first)
      items[item.keys.first] = item.values.first
      items[item.keys.first][:count] = 1
    else
      items[item.keys.first][:count] += 1
    end
  end
  items
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    if cart.has_key?(item)
      if cart[item][:count] >= coupon[:num] && !cart.has_key?("#{item} W/COUPON")
        cart["#{item} W/COUPON"] = {price: coupon[:cost] / coupon[:num], clearance: cart[item][:clearance], count: coupon[:num]}
        cart[item][:count] -= coupon[:num]
      elsif cart[item][:count] >= coupon[:num] && cart.has_key?("#{item} W/COUPON")
        cart["#{item} W/COUPON"][:count] += coupon[:num]
        cart[item][:count] -= coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, details|
    if details[:clearance]
      details[:price] = (details[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  hash_cart = consolidate_cart(cart)
  applied_coupons = apply_coupons(hash_cart, coupons)
  applied_discount = apply_clearance(applied_coupons)
  total = applied_discount.reduce(0) { |acc, (key, value)| acc += value[:price] * value[:count] }
  total > 100 ? total * 0.9 : total
end
