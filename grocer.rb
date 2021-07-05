def consolidate_cart(cart)
  new_cart = {}
  cart.each do |items_array|
    items_array.each do |item, attribute_hash|
      new_cart[item] ||= attribute_hash
      new_cart[item][:count] ? new_cart[item][:count] += 1 :
      new_cart[item][:count] = 1
  end
end
new_cart
end


def apply_coupons(cart, coupons)
  hash = cart
  coupons.each do |coupon_hash|
    # add coupon to cart
    item = coupon_hash[:item]

    if !hash[item].nil? && hash[item][:count] >= coupon_hash[:num]
      temp = {"#{item} W/COUPON" => {
        :price => coupon_hash[:cost],
        :clearance => hash[item][:clearance],
        :count => 1
        }
      }

      if hash["#{item} W/COUPON"].nil?
        hash.merge!(temp)
      else
        hash["#{item} W/COUPON"][:count] += 1
        #hash["#{item} W/COUPON"][:price] += coupon_hash[:cost]
      end

      hash[item][:count] -= coupon_hash[:num]
    end
  end

def apply_clearance(cart)
  cart.each do |item, attribute_hash|
    if attribute_hash[:clearance] == true
      attribute_hash[:price] = (attribute_hash[:price] *
      0.8).round(2)
    end
  end
cart
end

def checkout(cart, coupons)
  total = 0
  new_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(new_cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)
  clearance_cart.each do |item, attribute_hash|
    total += (attribute_hash[:price] * attribute_hash[:count])
  end
total = (total * 0.9) if total > 100 total
end
