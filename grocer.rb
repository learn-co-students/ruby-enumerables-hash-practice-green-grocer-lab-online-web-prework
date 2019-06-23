require "pry"

def consolidate_cart(cart) #cart is array of hashes in this method !!!
  updated_cart = {}
  #binding.pry
  cart.each do |item| #item is a hash
    item.each do |product, info| # e.g. {"TEMPEH"=>{:price=>3.0, :clearance=>true}}
      if updated_cart[product]
        updated_cart[product][:count] += 1
      else
        updated_cart[product] = info #set info for new item
        updated_cart[product][:count] = 1 #add count key and value
      end
    end
  end
  updated_cart #return cart
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

def apply_clearance(cart) #returns cart with clearance items reduced by 20%
  #cart is hash of hashes!

  cart.each do |keys, values|
    if values[:clearance] == true
     new_price = values[:price] * 0.8
      values[:price] = new_price.round(2)
    end
  end
  cart
end

def checkout(cart, coupons)   # cart is array of hashes here !!!
   consolidated_cart = consolidate_cart(cart)   #consolidate cart
   couponed_cart = apply_coupons(consolidated_cart, coupons) # apply discount from coupons
   final_cart = apply_clearance(couponed_cart) # apply clearance

   total = 0
   final_cart.each do |name, properties| #final cart is a hash
     total += properties[:price] * properties[:count]
   end
   total = total * 0.9 if total > 100 #   #if total is over 100, apply 10% discount
   total
end