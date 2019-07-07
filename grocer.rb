require 'pry'

def consolidate_cart(cart)
	consolidated_cart = {}
	cart.each do |c|
    item = c.keys.first

    if consolidated_cart[item]
			consolidated_cart[item][:count] += 1
    else
			consolidated_cart[item] = {
        :price => c[item][:price],
        :clearance => c[item][:clearance],
        :count => 1 }

    end
	end
	return consolidated_cart
end



def apply_coupons(cart, coupons)
  # code here
	count = 0
	while count < coupons.length
		coupon = coupons[count][:item]
		if cart.has_key?(coupon)
      if cart[coupon][:count] >= coupons[count][:num]
        if cart.has_key?(coupon + " W/COUPON")
          #binding.pry
          cart[coupon][:count] = cart[coupon][:count] - coupons[count][:num]
          cart[coupon + " W/COUPON"][:count] += coupons[count][:num]
        else
          cart[coupon][:count] = cart[coupon][:count] - coupons[count][:num]
			    cart[coupon + " W/COUPON"] ={
				      :price => coupons[count][:cost]/coupons[count][:num],
				      :clearance => cart[coupon][:clearance],
				      :count => coupons[count][:num]
					}
        end
      end
      count += 1
    else
      count += 1
    end
  end
  cart
end


def apply_clearance(cart)
  # code here

  cart.each do |c|
    item = c[1]
    if item[:clearance] == true
      discount = item[:price] * 0.2
      item[:price] -= discount.round(2)
    end
  end
end

def checkout(cart, coupons)
  # code here
  total = 0
  subtotal = 0
  checkout_cart = consolidate_cart(cart)
  apply_coupons(checkout_cart, coupons)
  apply_clearance(checkout_cart)
  checkout_cart.each do |c|
    item = c[1]
    subtotal = item[:price] * item[:count]
    total += subtotal
  end
  if total >= 100
    discount = total * 0.1
    total -= discount.round(2)
  end
  total
  # apply_coupons(checkout_cart,[])
  # apply_clearance(cart)

end
