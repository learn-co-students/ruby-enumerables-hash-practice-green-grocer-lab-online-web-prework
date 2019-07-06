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
      if coupon.match(/W\/COUPON/)
        cart[coupon][:count] = cart[coupon][:count] * 2
        count += 1
        binding.pry
      else
        cart[coupon][:count] = cart[coupon][:count] - coupons[count][:num]
			  cart[coupon + " W/COUPON"] ={
				      :price => coupons[count][:cost]/coupons[count][:num],
				      :clearance => cart[coupon][:clearance],
				      :count => coupons[count][:num]
				        }
			  count +=1
      end
    else
      count += 1
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
