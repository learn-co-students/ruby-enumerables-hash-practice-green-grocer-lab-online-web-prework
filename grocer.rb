def consolidate_cart(array)
  new_hash = {}
  array.each do |fruit|
    fruit.each do |key, value|
      if new_hash[key]
        new_hash[key][:count] += 1
      else
        new_hash[key] = value 
        new_hash[key][:count] = 1
      end
    end
end
return new_hash
end

def apply_coupons(cart, coupons)
 coupons.each do |coupon|
   if cart.keys.include? coupon[:item]
     if cart[coupon[:item]][:count] >= coupon[:num]
       discount = "#{coupon[:item]} W/COUPON"
       if cart[discount]
         cart[discount][:count] += coupon[:num]
       else
         cart[discount] = {
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
  cart.each do |item, item_details| 
   if item_details[:clearance] == true
     item_details[:price] = (item_details[:price] - (item_details[:price] * 0.20)).round(2)
   end
  end
  cart
end
  
def checkout(items, coupons)
  cart = consolidate_cart(items)
  cart1 = apply_coupons(cart, coupons)
  cart2 = apply_clearance(cart1)
  
  total = 0
  
  cart2.each do |name, price_hash|
  total += price_hash[:price] * price_hash[:count]
end

total > 100 ? total * 0.9 : total

end