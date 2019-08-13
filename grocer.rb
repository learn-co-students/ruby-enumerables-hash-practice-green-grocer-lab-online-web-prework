def consolidate_cart(cart)
  updated_cart = {}
  cart.each do |item|
    if updated_cart[item.keys[0]]
      updated_cart[item.keys[0]][:count] += 1 
    else
      updated_cart[item.keys[0]] = {
        count: 1, 
        price: item.values[0][:price],
        clearance: item.values[0][:clearance]
      }
    end
  end
  updated_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include? coupon[:item]
      if cart[coupon[:item]][:count] >= coupon[:num]
        new_name = "#{coupon[:item]} W/COUPON"
        if cart[new_name]
          cart[new_name][:count] += coupon[:num]
        else 
          cart[new_name] = {
            count: coupon[:num],
            price: coupon[:cost]/coupon[:num],
            clearance: cart[coupon[:item]][:clearance]
          }
        end
        cart[coupon[:item]][:count] -= coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.keys.each do |item|
    if cart[item][:clearance]
      cart[item][:price] = (cart[item][:price]*0.80).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consol_cart = consolidate_cart(cart)
  cart_with_coupons_applied = apply_coupons(consol_cart, coupons)
  cart_with_discounts_applied = apply_clearance(cart_with_coupons_applied)
  
  total = 0.0 
  cart_with_coupons_applied.keys.each do |item|
    total += cart_with_discounts_applied[item][:price]*cart_with_discounts_applied[item][:count]
  end
  total > 100.0 ? (total * 0.90).round : total
end
