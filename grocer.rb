def consolidate_cart(cart)
  updated_cart = {}
  cart.each do |item|
    if updated_cart[item.keys[0]]
      updated_cart[item.keys[0]][:count] += 1 
    else
      updated_cart[item.keys[0]] = {
        count: 1, 
        price: item.values[0][:price],
        clearance: item.values[0][:clearance]
      }
    end
  end
  updated_cart
end

def apply_coupons(cart, coupons)
  
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
