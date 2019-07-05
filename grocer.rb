require 'pry'

def consolidate_cart(cart)
	consolidated_cart = {}
	cart.each do |c|
    item = c.keys.first
<<<<<<< HEAD
    #binding.pry
    if consolidated_cart[item]
			consolidated_cart[item][:count] += 1

    else

			consolidated_cart[item] = {
        :price => c[item][:price],
        :clearance => c[item][:clearance],
        :count => 1
=======
    binding.pry
    if consolidated_cart.keys.include? (:count)
			consolidated_cart[item][:count] += 1

    else
			consolidated_cart[item] = {
        consolidated_cart[item][:price] => c[:price],
        consolidated_cart[item][:clearance] => c[:price],
        consolidated_cart[item][:count] => 1
>>>>>>> 5c2f25ff71cb4a76c6756bf3fda801792e95f6ae
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
