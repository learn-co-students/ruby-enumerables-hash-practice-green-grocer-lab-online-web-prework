def consolidate_cart(cart)
  # code here
  reduce_cart = {}
  for item in cart
    item.each_pair { |key, value|
       if reduce_cart.key?(key)
         reduce_cart[key][:count] += 1
       else
         reduce_cart[key] = value
         reduce_cart[key][:count] = 1
       end
     }
  end
  reduce_cart
end


def apply_coupons(cart, coupons)
  for coupon in coupons
    if cart.keys.include? coupon[:item]
      if cart[coupon[:item]][:count] >= coupon[:num]
        product_W_Coupon = "#{coupon[:item]} W/COUPON"
        if cart[product_W_Coupon]
          cart[product_W_Coupon][:count] += coupon[:num]
        else
          cart[product_W_Coupon] = {
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
  # code here
  cart.each_pair { |key, value|
    if value[:clearance]
      value[:price] -=( (value[:price] * 20) / 100).round(2)
    end
  }
  cart
end

def checkout(cart, coupons)
  # code here
  sorted_cart = apply_clearance( apply_coupons(consolidate_cart(cart), coupons))
  total = 0
  sorted_cart.each_value { |value|
     total += value[:count] * value[:price]
   }
  total > 100 ? (total * 0.9) : total
end
