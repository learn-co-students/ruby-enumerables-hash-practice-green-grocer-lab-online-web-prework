def consolidate_cart(cart)
  consolidated_cart = {}

   cart.each do |item|
    item_name = item.keys[0]

     consolidated_cart[item_name] = item.values[0]

     if consolidated_cart[item_name][:count] 
      consolidated_cart[item_name][:count] += 1
    else
      consolidated_cart[item_name][:count] = 1
    end
  end

   consolidated_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    coupon_name = coupon[:item]
    coupon_item_num = coupon[:num]
    cart_item = cart[coupon_name]

     next if cart_item.nil? || cart_item[:count] < coupon_item_num

     cart_item[:count] -= coupon_item_num

     coupon_in_cart = cart["#{coupon_name} W/COUPON"]

     if coupon_in_cart
      coupon_in_cart[:count] += 1
    else
      cart["#{coupon_name} W/COUPON"] = { 
        price: coupon[:cost], 
        clearance: cart_item[:clearance], 
        count: 1
      }
    end
  end

   cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
