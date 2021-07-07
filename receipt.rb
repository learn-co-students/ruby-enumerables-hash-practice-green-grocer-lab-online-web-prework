require'pry'

def consolidate_cart(cart)
  overcart = {}
  cart.length.times { |index|
    if overcart.key?(cart[index].keys[0])
      overcart[cart[index].keys[0]][:count] += 1 
    else
      overcart[cart[index].keys[0]] = {
        price: cart[index][cart[index].keys[0]][:price],
        clearance: cart[index][cart[index].keys[0]][:clearance]
      }
      overcart[cart[index].keys[0]][:count] = 1
    end
  }
  overcart
end

def apply_coupons(cart, coupons)
  coupons.length.times { |index|
    if cart.key?(coupons[index][:item]) && cart[coupons[index][:item]][:count] >= coupons[index][:num]
      cart[coupons[index][:item]][:count] -= coupons[index][:num]
      if cart.key?(coupons[index][:item] + " W/COUPON")
        cart[coupons[index][:item] + " W/COUPON"][:count] += coupons[index][:num]
      else  
        cart[coupons[index][:item] + " W/COUPON"] = {
          price: coupons[index][:cost] / coupons[index][:num],
          clearance: cart[coupons[index][:item]][:clearance],
          count: coupons[index][:num]
        }
      end
    end
  }
  cart
end


def apply_clearance(cart)
  cart.length.times { |index|
  if cart[cart.keys[index]][:clearance]
    cart[cart.keys[index]][:price] -= 0.2*cart[cart.keys[index]][:price]
  end
  }
  cart
end

def register(cart)
  mathsplosion = cart.reduce(0) { |memo, (key, value)|
    memo += (value[:price] * value[:count])
  }
  if mathsplosion > 100 
    mathsplosion *= 0.9
  end
  receipt = mathsplosion.round(2)
  return receipt
end  

def checkout(cart, coupons)
  cart_2 = consolidate_cart(cart)
binding.pry
  apply_coupons(cart_2, coupons)
binding.pry
  apply_clearance(cart_2)
binding.pry
  receipt = register(cart_2)

  puts receipt
  return receipt
end

cart = [
  {"BEER" => {:price => 13.00, :clearance => false}},
  {"BEER" => {:price => 13.00, :clearance => false}},
  {"BEER" => {:price => 13.00, :clearance => false}}
]

coupons = [
  {:item => "BEER", :num => 2, :cost => 20.00},
  {:item => "BEER", :num => 2, :cost => 20.00}
]

checkout(cart, coupons)