require 'pry'

def consolidate_cart(cart)
  new_hash = {}
  cart.map{ |item| 
  
    #Check for duplicates. Add count value if new item. Increment count if dupe.
    if new_hash.include?(item.keys[0])
      new_hash[item.keys[0]][:count] += 1
    else
      new_hash[item.keys[0]] = item.values[0]
      new_hash[item.keys[0]][:count] = 1
    end
  }
  
  return new_hash
end

def apply_coupons(cart, coupons)
  updated_cart = cart

  coupons.each{ |coupon_item|
  
    #Check to see if there are any coupons && if the amount is met
    while updated_cart[coupon_item[:item]] && updated_cart[coupon_item[:item]][:count] >= coupon_item[:num] do

      if updated_cart["#{coupon_item[:item]} W/COUPON"]
        updated_cart["#{coupon_item[:item]} W/COUPON"][:count] += coupon_item[:num]
      else
        updated_cart["#{coupon_item[:item]} W/COUPON"] = {
          :price=> coupon_item[:cost] / coupon_item[:num], 
          :clearance=> updated_cart[coupon_item[:item]][:clearance],
          :count=> coupon_item[:num]
        }
      end
      
      updated_cart["#{coupon_item[:item]}"][:count] -= coupon_item[:num]
      
    end
  }
  
  return updated_cart

end

def apply_clearance(cart)
  updated_cart = cart
  
  #check to see if on clearance
  updated_cart.map{ |item|
    if item[1][:clearance]
      updated_cart[item[0]][:price] *= 0.8
      updated_cart[item[0]][:price] = updated_cart[item[0]][:price].round(2)
    end
  }
  
  return updated_cart
  
end

def checkout(cart, coupons)
  total = 0.0
  
  #Consolidate & apply discounts
  count_cart = consolidate_cart(cart)
  count_coupons_cart = apply_coupons(count_cart, coupons)
  count_coupons_clearance_cart = apply_clearance(count_coupons_cart)
  
  #Add up items
  count_coupons_clearance_cart.each{ |item|
    total += item[1][:price] * item[1][:count].to_i
  }
  
  #Apply 10% discount
  if total > 100
    total *= 0.9
  end
  
  return total
end