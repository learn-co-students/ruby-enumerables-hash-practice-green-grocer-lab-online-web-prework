def consolidate_cart(cart)
  cart_count = Hash.new()
  cart.uniq.each do |e|
    e.each do |key,value|
       value.store(:count,cart.count(e))
       cart_count[key] = value
    end
   end
   cart_count
end

def apply_coupons(cart, coupons)

  clearance = Hash.new()
  cart_item_count = Hash.new()
  coupons.uniq.each do |coupon|
    if(cart.key?(coupon[:item]))
      item_coupon_name = coupon[:item].to_s+" W/COUPON"
      coupon_price = coupon[:cost]/coupon[:num]

        cart.each do |item,item_attribute|
          clearance[item] = item_attribute[:clearance]
          cart_item_count[item] = item_attribute[:count]
        end

      coupon_clearance = clearance[coupon[:item]]
      coupon_count = (cart_item_count[coupon[:item]]/coupon[:num]) * coupon[:num]
      updated_cart_item_count = cart_item_count[coupon[:item]]%coupon[:num]

      cart.store(item_coupon_name,{:price => coupon_price, :clearance => coupon_clearance, :count => coupon_count})
      cart[coupon[:item]][:count] = updated_cart_item_count
    end
  end

  cart
end

def apply_clearance(cart)

  cart.each do |item,attribute|
    if(attribute[:clearance]==true)
      attribute[:price] = (attribute[:price]*0.80).round(2)
    end
  end

cart
end

def checkout(cart, coupons)
    consolidated = consolidate_cart(cart)
    coupons_applied = apply_coupons(consolidated, coupons)
    clearance_applied = apply_clearance(coupons_applied)
    total = 0;
    clearance_applied.each do |item,attribute|
      total_per_item = attribute[:price]*attribute[:count]
      total += total_per_item
    end

    if(total>100)
      total = total * 0.90
    end

    return total
end
