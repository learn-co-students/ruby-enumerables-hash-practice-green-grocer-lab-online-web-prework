def consolidate_cart(cart: [])
  con_hash = {}
  cart.each dp |item|
    item.each do |name, attribute|
      if con_hash.has_key?(name)
        con_hash[name][:count] += 1 
      else
        con_hash = con_hash.merge({name => attribute.merge({count:1})})
  return con_hash
end

def apply_coupons(cart:[], coupons:[])
  cart_cons = cart
  coupons.each do |coupon|
    item_name = coupon[:item]
    if cart_cons.keys.include?(item_name)
      cart_count = cart_cons[item_name][:count]
      if cart_count >= coupon[:num]
        item_coup = {"#item_name} W/COUPON" => {price: coupon[:cost], clearance: cart_cons[item_name [:clearance], count: cart_count/coupon[:num]}}
        cart_cons[item_name][:count]%= coupon[:num]
        cart_cons = cart_cons.merge(item_coup)
      end
    end
  end
  return cart_cons
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
