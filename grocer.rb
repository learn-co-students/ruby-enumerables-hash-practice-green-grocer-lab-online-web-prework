def consolidate_cart(cart)
  foods = {}
  cart.each{|item|
    if foods[item.keys[0]]
      foods[item.keys[0]][:count] += 1
    else 
      foods[item.keys[0]] = {:price => item.values[0][:price], :clearance => item.values[0][:clearance], :count => 1}
    end
  }
   foods
end

def apply_coupons(cart, coupons)
  foods = {}
  cart.each{|item|
    if foods[item.values[0]][:clearance] === true
      foods[item.keys[0]] = "#{item.keys[0]} W/COUPON"=>{:price =>item.values[0][:price]/2 , :clearance => item.values[0][:clearance], :count => 2}
    end
  }
  foods
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
