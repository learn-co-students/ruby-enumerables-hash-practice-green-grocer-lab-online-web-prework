
def consolidate_cart(cart)
  # code here
final_hash = {}
cart.each do |element_hash|
  element_name = element_hash.keys[0]

  if final_hash.has_key?(element_name)
    final_hash[element_name][:count] += 1
  else
    final_hash[element_name] = {
count: 1,
price: element_hash[element_name][:price],
clearance: element_hash[element_name][:clearance]
    }
end
end
final_hash
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    item = coupon[:item]
    if cart[item] && coupon[:item][:count] >= coupon[:num] &&cart["#{item} W/COUPON"]
      cart["#{item} W/COUPON"] = {price: coupon[:cost] / coupon[:num] , clearance: cart[item][:clearance], count: coupon[:num]}
cart[item][:count] -= coupon[:num]
elseif coupon[:item][:count] >= coupon[:num] &&cart["#{item} W/COUPON"]
cart["#{item} W/COUPON"][:count] += coupton[:num]
cart[item][:count] -= coupon[:num]
end
  end
  cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
