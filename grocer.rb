
def consolidate_cart(cart)
grocery_cart = {}
  cart.each do |item|
    if grocery_cart[item.keys[0]]
      grocery_cart[item.keys[0]][:count] += 1
    else
      grocery_cart[item.keys[0]] = {
        count: 1,
        price: item.values[0][:price],
        clearance: item.values[0][:clearance]
      }
    end
  end
  grocery_cart
end
def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    if cart.has_key?(item)
      if cart[item][:count] >= coupon[:num] && !cart["#{item} W/COUPON"]
        cart["#{item} W/COUPON"] = {price: coupon[:cost] / coupon[:num], clearance: cart[item][:clearance], count: coupon[:num]}
        cart[item][:count] -= coupon[:num]
      elsif cart[item][:count] >= coupon[:num] && cart["#{item} W/COUPON"]
      cart["#{item} W/COUPON"][:count] += coupon[:num]
      cart[item][:count] -= coupon[:num]
      end
    end
  end
  cart
end	
  
def apply_clearance(cart)
  cart.each do |product_name, stats|
    stats[:price] -= stats[:price] *0.2 if stats[:clearance]
end
cart
end 

def checkout(array, coupons)
  hash_cart = consolidate_cart(array)
  applied_coupons = apply_coupons(hash_cart, coupons)
  applied_discount = apply_clearance(applied_coupons)
  total = applied_discount.reduce(0) { | acc, (key, value)| acc +=value[:price] *value[:count]}
  total > 100 ? total * 0.9 : total 
end
