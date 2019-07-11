require 'pry'
def consolidate_cart(cart)
          # binding.pry
          #create a new hash
  organized_cart = {}
 
  cart.each do |item|
          # binding.pry
          #if this line compiles as true 
    if organized_cart[item.first[0]]
          #do something in here 
      organized_cart[item.first[0]][:count] += 1
          # binding.pry
          #else
    else
          # binding.pry
          #we do something in here
      organized_cart[item.keys[0]] = {
        count: 1,
        price: item.values[0][:price],
        clearance: item.values[0][:clearance]
      }
    end
  end
 # binding.pry
  return organized_cart    
end
  
  
  
  
def apply_coupons(cart, coupons)
  #iterate over coupons
  coupons.each do |coupon|
   # binding.pry
    if cart.keys.include?(coupon[:item])   
      #binding.pry
      if cart[coupon[:item]][:count] >= coupon[:num]
        discount = "#{coupon[:item]} W/COUPON"
        if cart[discount]
          cart[discount][:count] += coupon[:num] 
        else
         cart[discount] = {
         :price => coupon[:cost]/coupon[:num],
         :clearance => cart[coupon[:item]][:clearance], 
         :count => coupon[:num]
         }
        end
        cart[coupon[:item]][:count] -= coupon[:num]
      end
  #we want to see if our cart includes the coupon item coupon[:item]
  #we want to create a new key that contains W/ COUPON
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

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart1 = apply_coupons(cart, coupons)
  cart2 = apply_clearance(cart)
  
  total = 0 
  
  cart2.each do |name, price_hash|
  total += price_hash[:price] * price_hash[:count]
end   

  total > 100 ? total * 0.9 : total
end
