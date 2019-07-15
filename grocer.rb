def consolidate_cart(cart)
    consolidated_cart = {}

   cart.each do |item|
    item_name = item.keys[0]

     consolidated_cart[item_name] = item.values[0]

     if consolidated_cart[item_name][:count] 
      consolidated_cart[item_name][:count] += 1
    else
      consolidated_cart[item_name][:count] = 1
    end
  end

   consolidated_cart
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
