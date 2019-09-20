def consolidate_cart(cart)
cart_c = {}
cart.each do |item|
  if cart_c[item.keys[0]]
    cart_c[item.keys[0]][:count] += 1
  else 
    cart_c[item.keys[0]] = {
      count: 1,
      price: item.values[0][:price],
      clearance: item.values[0][:clearance]
    }
  end
end
cart_c
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.include?(coupon[:item]) && cart[coupon[:item]][:count] >= coupon[:num]
      if cart.include?("#{coupon[:item]} W/COUPON")
        cart["#{coupon[:item]} W/COUPON"][:count] += coupon[:num]
        cart["#{coupon[:item]}"][:count] -= coupon[:num]
      else
        cart["#{coupon[:item]} W/COUPON"] = {
          price: coupon[:cost]/coupon[:num],
          count: coupon[:num],
          clearance: cart[coupon[:item]][:clearance]
        }
        cart["#{coupon[:item]}"][:count] -= coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item|
    if item[1][:clearance] == true
      item[1][:price] -= item[1][:price]*0.2
    end
  end
  cart
end


def checkout(cart, coupons)
  cons_cart = consolidate_cart(cart)
  coups_cart = apply_coupons(cons_cart, coupons)
  disc_cart = apply_clearance(coups_cart)
  
  
  total =  disc_cart.reduce(0) {|memo, item| 
  memo += item[1][:price]*item[1][:count]
  }
  total >= 100 ? total = (total*0.9).round(2) : total
end
