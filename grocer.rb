

def consolidate_cart(cart)
  final_hash = {}
  cart.each do |elm_hash|
    elm_name = elm_hash.keys[0]
    elm_stats = elm_hash.values[0]
    
    if final_hash.has_key?(elm_name)
      final_hash[elm_name][:count] += 1
    else
      final_hash[elm_name] = {
        count: 1, 
        price: elm_hash[elm_name][:price],
        clearance: elm_hash[elm_name][:clearance]
      }
    end
  end
  final_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    if cart.has_key?(item)
      if cart[item][:count] >= coupon[:num] && !cart.has_key?("#{item} W/COUPON")
          cart["#{item} W/COUPON"] = {price: coupon[:cost] / coupon[:num], clearance: cart[item][:clearance], count: coupon[:num]}
          cart[item][:count] -= coupon [:num]
      elsif cart[item][:count] >= coupon[:num] && cart.has_key?("#{item} W/COUPON")
        cart["#{item} W/COUPON"][:count] += coupon[:num]
        cart[item][:count] -= coupon [:num]
      end
    end
  end
  cart
end


def apply_clearance(cart)
  cart.each do |product_name, stats|
    stats[:price] -= stats[:price] * 0.2 unless !stats[:clearance]
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
