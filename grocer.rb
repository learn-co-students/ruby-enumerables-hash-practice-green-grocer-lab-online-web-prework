require 'pry'

def consolidate_cart(cart)
	consolidated_cart = {}
	cart.each do |c|
    item = c.keys.first
    #binding.pry
    if consolidated_cart[item]
			consolidated_cart[item][:count] += 1

    else

			consolidated_cart[item] = {
        :price => c[item][:price],
        :clearance => c[item][:clearance],
        :count => 1
      }

    end
	end
	return consolidated_cart
end


def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
