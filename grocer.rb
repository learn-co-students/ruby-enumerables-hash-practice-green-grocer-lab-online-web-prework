def consolidate_cart(cart)
  # code here
  consolidated_cart = {}
  cart.each do |item|
    item.each_pair do |(key, value)|
      if !( consolidated_cart.has_key? key)
        consolidated_cart[key] = value
        consolidated_cart[key][:count] = 1
      else
        consolidated_cart[key][:count] += 1
      end
    end
  end
  consolidated_cart
end

def apply_coupons(cart, coupons = [])
  if coupons == []
    return cart
  end
  cart_with_coupons = cart.reduce({}) do |memo, (key, value)|
    coupons.each do |cutout|
      if (cutout[:item] == key) && (cutout[:num] <= value[:count])
        new_key = "#{key} W/COUPON"
        remainder = value[:count] - cutout[:num]
        
        if memo.has_key? new_key
          memo[new_key][:count] += cutout[:num]
          memo[key][:count] = remainder
        else
          memo[new_key] = {}
          memo[new_key][:price] = cutout[:cost] / cutout[:num]
          memo[new_key][:clearance] = value[:clearance]
          memo[new_key][:count] = cutout[:num]
          memo[key] = value
          memo[key][:count] = remainder
        end
      else
        memo[key] = value
      end
    end
    memo
  end
  cart_with_coupons
end

def apply_clearance(cart)
  cart_with_clearance = cart.reduce({}) do |memo, (key, value)|
    memo[key] = value  
    if value[:clearance]
      memo[key][:price] = (memo[key][:price] * 0.8).round(2)
    end
    memo
  end
  cart_with_clearance
end

def checkout(cart, coupons)
  # code here
  receipt = apply_clearance(apply_coupons( consolidate_cart(cart), coupons))
  
  total = receipt.reduce(0){|memo, (key, value)|
    memo += ( value[:price] * value[:count] ).round(2)
  }
  if total > 100.0
    total =  (total * 0.9).round(2)
  end
  total
end

coupons = [{:item => "AVOCADO", :num => 2, :cost => 5.00}]
cart =     {
      "AVOCADO" => {:price => 3.00, :clearance => true, :count => 3},
      "KALE"    => {:price => 3.00, :clearance => false, :count => 1}
    }
    
result = apply_coupons(cart, coupons)    

puts result["AVOCADO"][:price]