def consolidate_cart(cart)
  cart.reduce({}) do |memo, el|
    name = el.keys[0]
    if memo.has_key?(name)
      memo[name][:count] += 1
    else
      el[name][:count] = 1
      memo[name] = el[name]
    end
    memo
  end
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include?(coupon[:item])
      coupon_item = cart[coupon[:item]]
      
      if coupon_item[:count] >= coupon[:num]
        times_applied = coupon_item[:count] / coupon[:num]      
        coupon_item[:count] -= coupon[:num] * times_applied
        
        cart["#{coupon[:item]} W/COUPON"] = {
          price: coupon[:cost] / coupon[:num],
          clearance: coupon_item[:clearance],
          count: coupon[:num] * times_applied
        }
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |key, val|
    cart[key][:price] = cart[key][:clearance] ? (cart[key][:price] * 0.80).round(2) : cart[key][:price]
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart,coupons)
  cart = apply_clearance(cart)
  
  price = cart.reduce(0) do |memo, (key, val)| 
    memo += val[:price] * val[:count] 
  end
  
  price = price > 100 ? price * 0.90 : price
  
  price.round(2)
end
