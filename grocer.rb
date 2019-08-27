def consolidate_cart(cart)
  consol_cart = {}
  count = 0
  cart.each do |element|
    element.each do |fruit, hash|
      consol_cart[fruit] ||= hash
      consol_cart[fruit][:count] ||= 0
      consol_cart[fruit][:count] += 1
    end
  end
  return consol_cart
end 

def apply_coupons(cart, coupons) 
  coupons.each do |coupon|
    item_name = coupon[:item]
    if cart[item_name] && cart[item_name][:count] >= coupon[:num]
      
      if cart["#{item_name} W/COUPON"]
        cart["#{item_name} W/COUPON"][:count] += coupon[:num] #update count of couponed items
      else
        cart["#{item_name} W/COUPON"] = {
          price: coupon[:cost] / coupon[:num],
          clearance: cart[item_name][:clearance],
          count: coupon[:num]
        }
      end
      cart[item_name][:count] -= coupon[:num] # update count of un-couponed items
    end
  end
  cart
end



def apply_clearance(cart)
  cart.each do |item_name, values|
    if values[:clearance]
      values[:price] = (values[:price] * 0.8).round(2)
    end
  end
end




def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)

  total = 0
  final_cart.each do |item_name, details|
    total += details[:price] * details[:count]
  end
  total > 100 ? total * 0.9 : total
end



  
  




