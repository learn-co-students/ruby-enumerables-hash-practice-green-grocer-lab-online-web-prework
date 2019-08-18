def consolidate_cart(cart)
  item_count = 0
  item_list = []
  final_cart = {}
  
  cart.each do |item|
    item.reduce({}) do |memo, (key, value)|
      item_list.push(key)
    end
  end
  
  cart.each do |item|
    item.reduce({}) do |memo, (key, value)|
      item_count = item_list.count {|x| x == key}
      value[:count] = item_count
    end
  end
  
  penultimate_cart = cart.uniq
  penultimate_cart.each do |item|
    item.reduce({}) do |memo, (key, value)|
      final_cart[key] = value
    end
  end
  
  final_cart
end
    

def apply_coupons(cart, coupons = nil)
    if coupons
      new_key = nil
      new_value = nil
      coupons.each do |coupon|
        cart.reduce({}) do |memo, (key, value)|
          if (coupon[:item] == key) && (coupon[:num] <= value[:count])
            value[:count] -= coupon[:num]
            if cart.include?(key + " W/COUPON")
                cart[key + " W/COUPON"][:count] += coupon[:num]
                new_key = nil
                new_value = nil
                
            else
                new_key = key + " W/COUPON"
                new_value = {
                :price => coupon[:cost] / coupon[:num],
                :clearance => value[:clearance],
                :count => coupon[:num]
                }
            end
          end
        end
        if new_key
          cart[new_key] = new_value
        end
      end
    end
  cart
end


def apply_clearance(cart)
  cart.reduce({}) do |memo, (key, value)|
    if value[:clearance] == true
      value[:price] = (value[:price] - (value[:price] * 0.20)).round(2)
    end
  end
  cart
end

def checkout(cart, coupons = nil)
  cart = consolidate_cart(cart)
  if coupons
    cart = apply_coupons(cart, coupons)
  end
  cart = apply_clearance(cart)
  total = 0
  
  cart.reduce({}) do |memo, (key, value)|
    total+= value[:price] * value[:count]
  end
  
  if total > 100.0
    total = total - (total * 0.10)
  end
  
  total.round(2)
end
