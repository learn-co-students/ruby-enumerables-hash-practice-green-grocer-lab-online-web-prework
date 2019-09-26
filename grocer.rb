
def consolidate_cart(cart)
  consolidated_hash = {}
  
  cart.each do |item_hash|
    item_name = item_hash.keys[0]
    item_details = item_hash.values[0]
    
    if consolidated_hash.has_key?(item_name)
        consolidated_hash[item_name][:count] += 1
    else 
        consolidated_hash[item_name] = {count: 1, 
                                        price: item_details[:price],
                                        clearance: item_details[:clearance]
        }
    end #if
  end #do
  
  return consolidated_hash
end

def apply_coupons(cart, coupons)
   coupons.each do |each_coupon|
     item_name = each_coupon[:item]
     item_name_w_coupon = "#{item_name} W/COUPON"
     
      if (cart.has_key?item_name) && (cart[item_name][:count] >= each_coupon[:num]) 
          if cart.has_key?(item_name_w_coupon)
            cart[item_name_w_coupon][:count] += each_coupon[:num]
          else
            cart[item_name_w_coupon] = {clearance: cart[item_name][:clearance],
                                      price: each_coupon[:cost]/each_coupon[:num],
                                      count: each_coupon[:num]}
            
          end #if
          cart[item_name][:count] -= each_coupon[:num]                               
      end #if
    
    end #do
    cart
end

def apply_clearance(cart)
  cart.each do |item, item_attributes|
    if item_attributes[:clearance] 
      item_attributes[:price] = (item_attributes[:price] * 0.8).round(2)
    end
  end # do
  cart
  # code here
end

def checkout(cart, coupons)
  consolidated_hash = consolidate_cart(cart)
  discounted_cart = apply_coupons(consolidated_hash, coupons)
  clearanced_cart = apply_clearance(discounted_cart)
  total = 0
  clearanced_cart.each do |item, item_attributes|
    item_total = item_attributes[:count] * item_attributes[:price]
    puts " #{item_attributes[:count]} #{item}s at #{item_attributes[:price]} each - #{item_total}"
    total += item_total
  end #do
  if total > 100
    total *= 0.9
  end
  total
end
