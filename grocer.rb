def consolidate_cart(cart) 
  new_cart = {}
  cart.each do |item_array|
    item_array.each do |item, attribute_hash|
      new_cart[item] ||= attribute_hash
      new_cart[item][:count] ? new_cart[item][:count] += 1 :
      new_cart[item][:count] = 1
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon| 
    coupon.each do |attribute, value| 
      name = coupon[:item] 
    
      if cart[name] && cart[name][:count] >= coupon[:num] 
        if cart["#{name} W/COUPON"] 
          cart["#{name} W/COUPON"][:count] += coupon[:num]
        else 
          cart["#{name} W/COUPON"] = {:price => coupon[:cost] / coupon[:num], 
          :clearance => cart[name][:clearance], :count => coupon[:num]} 
        end 
  
      cart[name][:count] -= coupon[:num] 
    end 
  end 
end 
  cart 
end

def apply_clearance(cart)
  cart.each do |item,attribute|
    if attribute[:clearance] == true
      attribute[:price] = (attribute[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  sorted_cart = consolidate_cart(cart)
  coupons_applied = apply_coupons(sorted_cart,coupons)
  final_cart = apply_clearance(coupons_applied)
  total_cost = 0
  final_cart.each do |item,attributes|
    total_cost += attributes[:price] * attributes[:count]
  end
  if total_cost > 100
    total_cost *= 0.9
  end
  total_cost
end
