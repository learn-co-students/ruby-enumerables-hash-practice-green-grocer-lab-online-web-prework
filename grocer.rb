def consolidate_cart(cart)
  array = cart
  hash.new{cart}
  cart.reduce({}) do|item,(price,clearance, count)
end

def apply_coupons(cart, coupons)
  cart.select{|item| item-coupons}
end

def apply_clearance(cart)
  cart.each{|item| item-clearance}
end

def checkout(cart, coupons)
  array = cart
  hash.new{cart}
  cart.reduce({}) do|item,(price,clearance, count)
  cart.select{|item| item-coupons}
  cart.each{|item| item-20%}
  cart.map{|total| total > 100 = total-10%}
end
