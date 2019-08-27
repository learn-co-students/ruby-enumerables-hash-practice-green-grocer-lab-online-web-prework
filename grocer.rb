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
    current_item = coupon[:item]
    if cart.keys.include?(current_item) && cart[current_item][:count] >= coupon[:num]
      if cart[current_item + " W/COUPON"]
        cart[current_item + " W/COUPON"][:count] += 1
      else
        cart[current_item + " W/COUPON"] = cart[current_item].dup
        cart[current_item + " W/COUPON"][:count] = coupon[:num]
        cart[current_item + " W/COUPON"][:price] = coupon[:cost] / coupon[:num]
      end
      cart[current_item][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, details|
    #debugger
    if details[:clearance]
      details[:price] = (details[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
end
