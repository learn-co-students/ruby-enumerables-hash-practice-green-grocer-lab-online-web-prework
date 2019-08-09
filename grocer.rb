require 'pry'

def consolidate_cart(cart)
  new_cart = {}
  cart.each do |x|
    if new_cart[x.keys[0]]
      new_cart[x.keys[0]][:count] += 1
    else
      new_cart[x.keys[0]] = {
        count: 1,
        price: x.values[0][:price],
        clearance: x.values[0][:clearance]
      }
    end
  end
  new_cart
  #binding.pry
end

def apply_coupons(cart, coupons)
  coupons.each do |x|
    if cart.keys.include? x[:item]
      if cart[x[:item]][:count] >= x[:num]
        is_coupon = "#{x[:item]} W/COUPON"
        if cart[is_coupon]
          cart[is_coupon][:count] += x[:num]
        else
          cart[is_coupon] = {
            count: x[:num],
            price: x[:cost]/x[:num],
            clearance: cart[x[:item]][:clearance]
          }
        end
        cart[x[:item]][:count] -= x[:num]
      end
    end
  end
  cart
  #binding.pry
end

def apply_clearance(cart)
  cart.keys.each do |x|
    if cart[x][:clearance]
      cart[x][:price] = (cart[x][:price]*0.80).round(2)
    end
  end
  cart
  #binding.pry
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  cart_w_coupons = apply_coupons(new_cart, coupons)
  cart_w_discounts = apply_clearance(cart_w_coupons)

  total = 0.0
  cart_w_discounts.keys.each do |x|
    total += cart_w_discounts[x][:price]*cart_w_discounts[x][:count]
  end
  total > 100.00 ? (total * 0.90).round : total
  #binding.pry
end
