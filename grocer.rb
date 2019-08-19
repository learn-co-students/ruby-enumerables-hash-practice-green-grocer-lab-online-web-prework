def consolidate_cart(cart)
  hash_cart = {}

  cart.each do |item|
    item.each_pair do |key, value|
      if hash_cart.include? key
        hash_cart[key][:count] +=1
      else
        hash_cart[key] = value
        hash_cart[key][:count] = 1
      end
    end
  end
  hash_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |item_coupon|

    item_coupon.each_pair do |key, value|

			if cart.include? value

        if cart[value][:count] < item_coupon[:num]
          pp "not enough cheese"

        elsif cart[value][:count] % item_coupon[:num] != 0
          array_of_number_of_times_to_run_coupon = cart[value][:count].divmod(item_coupon[:num])

          cart["#{value} W/COUPON"] = {:price => (item_coupon[:cost] / item_coupon[:num]), :clearance => cart[value][:clearance], :count => (item_coupon[:num] * array_of_number_of_times_to_run_coupon[0])}

          cart[value][:count] = (cart[value][:count] - (item_coupon[:num] * array_of_number_of_times_to_run_coupon[0]))

        else
          array_of_number_of_times_to_run_coupon = cart[value][:count].divmod(item_coupon[:num])

          cart["#{value} W/COUPON"] = {:price => (item_coupon[:cost] / item_coupon[:num]), :clearance => cart[value][:clearance], :count => array_of_number_of_times_to_run_coupon[0] * item_coupon[:num]}

          cart[value][:count] = array_of_number_of_times_to_run_coupon[1]

        end

			end
		end
	end
  cart
end

def apply_clearance(new_cart)
  new_cart.each_pair do |key, value|
    if value[:clearance] === true
      new_price = value[:price] * 0.8
      value[:price] = new_price.floor(2)
    else
      pp "not on clearance, do nothing"
    end
  end
  new_cart
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  cart_after_coupons = apply_coupons(new_cart, coupons)
  cart_after_coupons_and_clearance = apply_clearance(cart_after_coupons)

  running_total = 0
  grand_total = 0

  cart_after_coupons_and_clearance.each_pair do |item, info_about_it|
    item_subtotal = info_about_it[:price] * info_about_it[:count]
    running_total += item_subtotal
  end

  if running_total > 100
    grand_total = running_total * 0.9
  else
    grand_total = running_total
  end
  grand_total.floor(2)
end
