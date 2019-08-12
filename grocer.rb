def consolidate_cart(cart)
  new_cart = {}
  
  cart.map do |item|
    if new_cart[item.keys[0]]
      new_cart[item.keys[0]][:count] += 1 
    else 
      new_cart[item.keys[0]] = {
        price: item.values[0][:price],
        clearance: item.values[0][:clearance],
        count: 1 
      }
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include? coupon[:item]
      if cart[coupon[:item]][:count] >= coupon[:num]
        if cart["#{coupon[:item]} W/COUPON"]
          cart["#{coupon[:item]} W/COUPON"][:count] += coupon[:num]
        else
          cart["#{coupon[:item]} W/COUPON"] = {
          price: coupon[:cost]/coupon[:num],
          clearance: cart[coupon[:item]][:clearance],
          count: coupon[:num]
          }
        end 
        cart[coupon[:item]][:count] -= coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  #visit each element in the cart hash 
  #check for clearance == TRUE
  #lookup :price
  #create discount_variable to hold dicsount amount
  #update :price, :price -= discount_variable.round(2)
  #return updated cart
  
  cart.each do |item, value|
    if value[:clearance]
      discount_variable = value[:price] * 0.20 
      value[:price] -= discount_variable.round(2)
    end
  end
  cart 
end

def checkout(cart, coupons)
  #call consolidate_cart(cart)
  #call apply_coupons(cart, coupons)
  #call apply_clearance(cart)
  #reduce :price to variable called total 
  #check total >= 100.00
  #if true, assign variable total_discount = total * 0.100
  #update total -= total_discount.round(2)
  #return total
  
  updated_cart = consolidate_cart(cart)
  updated_cart = apply_coupons(updated_cart, coupons)
  updated_cart = apply_clearance(updated_cart)
  
  total = 0.00 
  
  updated_cart.each do |item, value|
    total += value[:price] * value[:count]
  end
  
  if total >= 100.00 
    total_discount = total * 0.10
    total -= total_discount.round(2)
  end
  total
end
