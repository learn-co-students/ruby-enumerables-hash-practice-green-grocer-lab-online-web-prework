

def consolidate_cart(cart)
  newhash = {}
  
  cart.each do |element_hash|
    elementname = element_hash.keys[0]

    
    if newhash.has_key?(elementname)
      newhash[elementname][:count] += 1
    else
      newhash[elementname] = {
        count: 1,
        price: element_hash[elementname][:price],
        clearance: element_hash[elementname][:clearance]
      }

    end
  end
newhash
  
  # code here
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    if cart.has_key?(item)
      if cart[item][:count] >= coupon[:num] && !cart.has_key?("#{item} W/COUPON")
        cart["#{item} W/COUPON"] = {price: coupon[:cost] / coupon[:num], clearance: cart[item][:clearance], count: coupon[:num]}
      elsif cart[item][:count] >= coupon[:num] && cart.has_key?("#{item} W/COUPON")
        cart["#{item} W/COUPON"][:count] += coupon[:num]
        
      end 
      cart[item][:count] -= coupon[:num]
    end
  end
      cart
  # code here
end

def apply_clearance(cart)
  cart.each do |product_name, stats|
    stats[:price] -= stats[:price] * 0.2 if stats[:clearance] == true
  end
  cart
  # code here
end

def checkout(cart, coupons)
  
  
  # code here
end
