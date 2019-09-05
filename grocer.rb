def consolidate_cart(cart)
  final_hash = {}
    cart.each do |ele_hash|
      
        ele_name = ele_hash.keys[0]
  
        if final_hash.has_key?(ele_name)
          final_hash[ele_name][:count] += 1
        else
          final_hash[ele_name] = {
            price: ele_hash[ele_name][:price],
            clearance: ele_hash[ele_name][:clearance],
            count: 1
          }
      end
    end
    final_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
  
    item = coupon[:item]
    
    if cart[item]
      if cart[item][:count] >= coupon[:num] && !cart.has_key?("#{item} W/COUPON")
        cart["#{item} W/COUPON"] = { 
          price: coupon[:cost] / coupon[:num], 
          clearance: cart[item][:clearance], 
          count: coupon[:num] 
        }
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
  cart.each do |prod_name, stats|
    stats[:price] -= stats[:price] * 0.2 if stats[:clearance] == true
  end
  cart
end

def checkout(cart, coupons)
  hash_cart = consolidate_cart(cart)
  applied_coupons = apply_coupons(hash_cart, coupons)
  applied_discount = apply_clearance(applied_coupons)
  
  total = applied_discount.reduce(0) { |sum, (key, value)| sum += value[:price] * value[:count] }

  total > 100 ? total * 0.9 : total
end
