def consolidate_cart(cart)
  consol_cart = Hash.new
  
  cart.each do |item|
    if consol_cart[item.keys[0]] #Item with that key is already in consol cart
      consol_cart[item.keys[0]][:count] += 1
      
    else #Item with that key is NOT already in consol cart
      item_name = item.keys[0]
      new_consol_cart_item = {}
      new_consol_cart_item[:price] = item[item_name][:price]
      new_consol_cart_item[:clearance] = item[item_name][:clearance]
      new_consol_cart_item[:count] = 1
      consol_cart[item_name] = new_consol_cart_item
  
    end #end if
  end #end each block
  consol_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item_name = coupon[:item]
    item_name_w_coupon = "#{item_name} W/COUPON"
    
    if cart[item_name_w_coupon]
      if cart[item_name][:count] >= coupon[:num]  
        cart[item_name_w_coupon][:count] += coupon[:num]
        cart[item_name][:count] -= coupon[:num]
      end
    
    elsif cart[item_name]
      if cart[item_name][:count] >= coupon[:num]
        coupon_item_name = "#{item_name} W/COUPON"
        coupon_item = {}
        coupon_item[:price] = coupon[:cost]/coupon[:num]
        coupon_item[:clearance] = cart[item_name][:clearance]
        coupon_item[:count] = coupon[:num]
        cart[coupon_item_name] = coupon_item
        cart[item_name][:count] -= coupon[:num]
      end #end if count is enough
    end #end if item (or couponned item) is in cart
  end #end each
  cart
end

def apply_clearance(cart)
  cart.each do |item, attribute_hash|
    if attribute_hash[:clearance]
      attribute_hash[:price] = (attribute_hash[:price] * 0.8).round(2)
    end #end if
  end #end do
  cart
end #end method

def checkout(cart, coupons)
  cart_one = consolidate_cart(cart)
  cart_two = apply_coupons(cart_one, coupons)
  cart_final = apply_clearance(cart_two)
  
  total = 0
  
  cart_final.each_pair do |item, attribute_hash|
    total += (attribute_hash[:price] * attribute_hash[:count])
  end #end do
  
  if total > 100
    total = (total*0.9).round(2)
  end #end if
  total
end
