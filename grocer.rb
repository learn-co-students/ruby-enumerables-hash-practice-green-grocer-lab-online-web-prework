def consolidate_cart(cart)
  cart_hash = {}
  cart.map {|item|
    item.each_pair {|key, value|
      if cart_hash[key]
        cart_hash[key][:count] += 1
      else
        cart_hash[key] = value
        cart_hash[key][:count] = 1
      end
    }
  }
  cart_hash
end

def apply_coupons(cart, coupons)
  coupons.each{|coupon|
    item_w_coupon = coupon[:item] + " W/COUPON"
    if cart.has_key?(item_w_coupon)
      if cart[coupon[:item]][:count] >= coupon[:num]
        cart[item_w_coupon][:count] += coupon[:num]
        cart[coupon[:item]][:count] -= coupon[:num]
      end
    elsif cart.has_key?(coupon[:item])
      if cart[coupon[:item]][:count] >= coupon[:num]
        cart[item_w_coupon] = {price: coupon[:cost]/coupon[:num], count: coupon[:num], clearance: cart[coupon[:item]][:clearance]} 
        cart[coupon[:item]][:count] -= coupon[:num]
      end
    end
  }
  cart
end

def apply_clearance(cart)
  cart.each_pair{|key, value|
    if cart[key][:clearance]
      old_price = cart[key][:price]
      new_price = cart[key][:price] - (cart[key][:price] * 0.2).round(2)
      cart[key][:price] = new_price
    end
  }
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0 
  cart.each_pair{ |key, value|
    total += cart[key][:price] * cart[key][:count]
  }
  if total > 100
    total = total - (total * 0.1).round(2)
  end
  total
end