def consolidate_cart(cart)
  new_cart = {}
  cart.each do |item|
    # puts item.keys
    # puts item.values[0][:price]
    if new_cart[item.keys[0]]
      new_cart[item.keys[0]][:count] += 1
    else
      new_cart[item.keys[0]] = {
        count: 1,
        price: item.values[0][:price],
        clearance: item.values[0][:clearance]
      }
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.include?(coupon[:item])
      if cart[coupon[:item]][:count] >= coupon[:num]
    new_item = "#{coupon[:item]} W/COUPON"
      if cart[new_item]
        cart[new_item][:count] += coupon[:num]
      else
        cart[new_item] = {
        price: coupon[:cost]/coupon[:num],
        count: coupon[:num],
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
  total_cost = 0
  consolidated_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(consolidated_cart, coupons)
  discounted_cart = apply_clearance(coupon_cart)

  discounted_cart.keys.each do |item|
    total_cost += discounted_cart[item][:price]*discounted_cart[item][:count]
  end
  if total_cost > 100
    total_cost = total_cost*0.90.round(2)
  end
  total_cost
end
