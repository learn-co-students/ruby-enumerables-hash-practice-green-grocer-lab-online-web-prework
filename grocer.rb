def consolidate_cart(cart)
  counted = {}
  cart.each do |kv|
    k = kv.keys.first
    v = kv.values.first
    if counted[k]
      counted[k][:count] += 1
    else
      counted[k] = v
      counted[k][:count] = 1
    end
  end
  return counted
end

def enough_items_for_coupon?(item_count, coupon_for_num)
  item_count >= coupon_for_num ? true : false
end

def apply_coupons(cart, coupons)
  wcoupon = " W/COUPON"

  coupons.each do |coupon|
    item = coupon[:item]
    item_w_coupon = item + wcoupon
    price_of_each = coupon[:cost] / coupon[:num]

    #if not enough items?

    if cart[item]
      #subtract discounted items from NON-discounted items
      #but only if coupon meets minimum amount
      if enough_items_for_coupon?(cart[item][:count], coupon[:num])
        cart[item][:count] -= coupon[:num]

        #add discounted items to cart
        cart[item_w_coupon] = {count: 0} unless cart[item_w_coupon]
        cart[item_w_coupon][:clearance] = cart[item][:clearance]
        cart[item_w_coupon][:count] += coupon[:num]
        cart[item_w_coupon][:price] = price_of_each
      end
    end
  end
  return cart
end

def apply_clearance(cart)
  cart.each_key do |item|
    # total minus 20/100 of total,
    cart[item][:price] -= cart[item][:price] * 0.2 unless cart[item][:clearance] == false
  end
  return cart
end

def checkout(cart, coupons)
  all = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  total = all.values.map { |item|
    # multiply price by count
    price = item.fetch(:price)
    price *= item.fetch(:count)
  }.reduce(:+)

  # 10% discount if over 100
  total > 100.0 ? total - (total * 0.1) : total
end
