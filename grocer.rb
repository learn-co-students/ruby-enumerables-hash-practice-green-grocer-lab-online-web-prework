def consolidate_cart(cart)
  new = {}
  cart.each do |item|
    if new[item.keys[0]]
      new[item.keys[0]][:count] += 1
    else 
      new[item.keys[0]] = {
        count: 1,
        price: item.values[0][:price],
        clearance: item.values[0][:clearance]
      }
    end
  end
  new
end


def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include? coupon[:item]
      if cart[coupon[:item]][:count] >= coupon[:num]
        new_key = "#{coupon[:item]} W/COUPON"
        if cart[new_key]
          cart[new_key][:count] += coupon[:num]
        else 
          cart[new_key] = {
            count: coupon[:num],
            price: coupon[:cost]/coupon[:num],
            clearance: cart[coupon[:item]][:clearance]
          }
  end
  cart[coupon[:item]][:count] -= coupon[:num]
end
end  
end
cart 
end 

def apply_clearance(cart)
  cart.keys.each do |item|
    if cart[item][:clearance]
      cart[item][:price]= (cart[item][:price]* 0.80).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  total = 0.0 
  consol_cart = consolidate_cart(cart)
  cart_w_coupons = apply_coupons(consol_cart, coupons)
  discounted_cart = apply_clearance(cart_w_coupons)
  
  # add each item to get total 
  discounted_cart.keys.each do |item|
    total += discounted_cart[item][:price]* discounted_cart[item][:count]
  end
  if total > 100.00 
    total = (total * 0.90).round(2)
  end
  total
end




