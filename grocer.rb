def consolidate_cart(cart)
   # turn array into hash using .reduce
  new_cart = {}
  cart.reduce(new_cart) do |hash, item|
    if new_cart[item.keys[0]]
      # if we get here, there is already a new_cart item, so we +1 to the count
      new_cart[item.keys[0]][:count] += 1
    else
      # if we get here, we create a new_cart item
      new_cart[item.keys[0]] = {
      count: 1,
      price: item.values[0][:price],
      clearance: item.values[0][:clearance]
    }
    end
  end
  new_cart
end

def apply_coupons(cart, coupons) # {cart}, {coupons}
  # Is there a coupon? Go through coupons hash
  coupons.each do |coupon|
    if cart.keys.include? coupon[:item]
      #does the cart hash have a key that matches the :item in the coupon hash?
      if cart[coupon[:item]][:count] >= coupon[:num]
        # if there is a coupon, create new item
        new_item = "#{coupon[:item]} W/COUPON"
        if cart[new_item]
          cart[new_item][:count] += coupon[:num]
          # item:count is >= coupon:num, alter count and go back up to first if
        else
          # item:count is < coupon:num, list current item
          cart[new_item] = { 
            count: coupon[:num],
            price: coupon[:cost] / coupon[:num],
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
  # go through {cart}
  cart.keys.each do |item|
    if cart[item][:clearance]
    #if #clearance is true, :price * 0.20
    cart[item][:price] = cart[item][:price]  - (cart[item][:price] * 0.20)
    end
  end
  cart
end

def checkout(cart, coupons)
  # consolidate the cart
  consolidated = consolidate_cart(cart)
  
  # apply coupons to the consolidated cart
  coupon_cart = apply_coupons(consolidated, coupons)
  
  # apply discounts to the coupon_cart
  discount_cart = apply_clearance(coupon_cart)

  total_price = 0.0
  
  # iterate through discount_cart
  discount_cart.keys.each do |item|
    #add item[:price] * item[:count] to total_price
    total_price += discount_cart[item][:price] * discount_cart[item][:count]
  end
  if total_price > 100.00
    # apply 10% discount and adjust total_price
    total_price = total_price - (total_price * 0.10)
  end
  total_price
end