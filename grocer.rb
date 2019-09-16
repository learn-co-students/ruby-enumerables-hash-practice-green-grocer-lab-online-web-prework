def consolidate_cart(cart)
  counter = 0 
  consolidate_cart = 
  [
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"KALE"    => {:price => 3.00, :clearance => false}}
]
while consolidate_cart [counter] do 
  puts consolidate_cart[counter]
  counter += 1 
end 

consolidate_cart.each do |item, price|
  puts "#{item}; #{price}"
end


def apply_coupons(cart, coupons)
  counter = 0 
  apply_coupons = 
  {
  "AVOCADO" => {:price => 3.00, :clearance => true, :count => 3},
  "KALE"    => {:price => 3.00, :clearance => false, :count => 1}
}
  [{:item => "AVOCADO", :num => 2, :cost => 5.00}]
 while apply_coupons [counter] do 
  puts apply_coupons [counter]
  counter += 1 
end  
  apply_coupons.each do |item, price|
  puts "#{item}; #{price}"
end







def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
