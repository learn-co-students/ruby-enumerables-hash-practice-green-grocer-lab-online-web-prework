def consolidate_cart(cart)
  # code here
  new_cart = {}
	cart.each do |hash|
		hash.each do |item, attributes|

			if new_cart[item]
				new_cart[item][:count] += 1
			else
				new_cart[item] = attributes
				new_cart[item][:count] = 1
			end
		end
end
new_cart
 end


 def apply_coupons(cart, coupons)
   coupons.each do |coupon_hash|
     item_name = coupon_hash[:item]
     new_item = "#{item_name} W/COUPON"

     if cart.has_key?(item_name) && cart[item_name][:count] >= coupon_hash[:num]
       if cart.has_key?(new_item)
          cart[new_item][:count] += coupon_hash[:num]
         cart[item_name][:count] -= coupon_hash[:num]

       else
       cart[new_item] = {
         :price => (coupon_hash[:cost] / coupon_hash[:num]),
         :clearance => cart[item_name][:clearance],
         :count => coupon_hash[:num]
       }
       cart[item_name][:count] -= coupon_hash[:num]
     end
     end
   end
   cart
 end

def apply_clearance(cart)
 cart.each do |key, value|
   if value[:clearance] == true
     value[:price] = (value[:price]*0.80).round(2)
   end
 end
 cart
end

def checkout(cart, coupons)
  # code here
  consolidated_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(coupon_cart)

  sum = 0
  final_cart.each do |name,item|
    sum += item[:count] * item[:price]
  end

  if sum > 100
    sum = sum * 0.90
  end
sum
end
