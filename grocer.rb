def consolidate_cart(cart)
def consolidate_cart(item)
  final = Hash.new 0 
  count = :count
item.each do |hash|
  hash.each do |food, description|
  
if final.has_key?(food) == false
  final[food] = description
  final[food][count] = 1
elsif final.has_key?(food)
final[food][:count] +=1
end
final
end

def apply_coupons(cart, coupons)
  final = Hash.new 0 
  coupons.each do |key, value|
puts key
cart.each do |food, description|
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
