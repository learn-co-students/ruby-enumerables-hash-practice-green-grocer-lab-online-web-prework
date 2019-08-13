require "pry"
def consolidate_cart(cart)
i = 0 
  while i < cart.length do
    cart[i].values[0][:count] = 1
    i += 1
    end
    new_hash = {}
    cart.each do |n|
     if new_hash.keys.include?(n.keys[0])
       new_hash[n.keys[0]][:count] += 1
       else
       new_hash[n.keys[0]] = n.values[0]
     end
  end
  new_hash
end
 
 
 
 def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include? coupon[:item]
      if cart[coupon[:item]][:count] >= coupon[:num]
        new_name = "#{coupon[:item]} W/COUPON"
        if cart[new_name]
          cart[new_name][:count] += coupon[:num]
        else
          cart[new_name] = {
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
cart.length.times do |index|
  if cart.values[index][:clearance] == true
    c = cart.values[index][:price] * 0.20
    
    cart.values[index][:price] = cart.values[index][:price] - c 
  else
    
  puts "item not on clearance"
end
end
cart
end



#the checkout method is not going to work because the apply_coupons method is broken even though they gave it to me.


def checkout(cart, coupons)
cart = consolidate_cart(cart)
coupons_applied = apply_coupons(cart, coupons)
clearance_applied = apply_clearance(coupons_applied)
clearance_applied
total = 0
clearance_applied.each do |item, value|
  total_price = value[:price] * value[:count]
total = total_price + total
 end
if total > 100 
  discount = total * 0.10
  final_total = total - discount
else
final_total = total
end
final_total
end




=begin
def apply_coupons(cart, coupons)


cart.length.times do |index|
  if coupons[:item] == cart.keys[index]
    discounted_item = cart.keys[index]
    
    cart["#{discounted_item} W/COUPON"] = {}     
    cart["#{discounted_item} W/COUPON"][:count] = coupons[:num]  
    cart["#{discounted_item} W/COUPON"][:price] = coupons[:cost] / coupons[:num] 
    cart["#{discounted_item} W/COUPON"][:clearance] = cart.values[index][:clearance] 
    
    cart.values[index][:count] = cart.values[index][:count] - coupons[:num]
    
    
    cart
  else
   
 puts "item not discounted"
 
  end
cart
end
cart
end
#this method works correctly and returns expected hash, however still returns an error.
=end




