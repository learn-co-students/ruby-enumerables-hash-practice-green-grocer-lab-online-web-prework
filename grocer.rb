def consolidate_cart(cart)
  items = {}
  cart.each { |add_item|
    add_item.each { |name, values|
      if items[name].nil?
        items[name] = values
        items[name][:count] = 1
      else
        items[name][:count] += 1
      end
      items
    }
  }
  p items
end

def apply_coupons(cart, coupons)
  coupon_cart = cart
  coupons.each { |apply|
    item = apply[:item]
    if !coupon_cart[item].nil? && coupon_cart[item][:count]>=apply[:num]
        discount = {"#{item} W/COUPON" => {
          :price => apply[:cost]/apply[:num],
          :clearance => coupon_cart[item][:clearance],
          :count => apply[:num]
          }}
          
          if coupon_cart["#{item} W/COUPON"].nil?
            coupon_cart.merge!(discount)
          else 
            coupon_cart["#{item} W/COUPON"][:count] += apply[:num]
          end
          coupon_cart[item][:count] -= apply[:num]
    end
    }
  p coupon_cart
end

def apply_clearance(cart)
  clearance_cart = cart
  cart.each { |item, has_clearance|
    if has_clearance[:clearance]==true
      has_clearance[:price] = (has_clearance[:price] * 0.8).round(2)
    end
  }
  p clearance_cart
end


def checkout(cart, coupons)
  full_cart = consolidate_cart(cart)
  with_coupons = apply_coupons(full_cart, coupons)
  with_clearance = apply_clearance(with_coupons)
  
  total_price = 0
  with_clearance.each { |items, price|
    total_price += price[:price] * price[:count]
  }
  
  if total_price >= 100
    total_price = (total_price*0.9)
  end
  
  p with_clearance
  p total_price
end
