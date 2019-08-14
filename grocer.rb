def consolidate_cart(cart)
  new_cart = {}
  item_count = :count
    cart.each do |item_hash|
      item_hash.each do |item_name, details|
        if new_cart.include?(item_name) == false
          new_cart[item_name] = details
          new_cart[item_name][item_count] = 1
        else new_cart.include?(item_name) == true
          new_cart[item_name][:count] += 1
        end
      end
    end
  new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.include? coupon[:item]
      if cart[coupon[:item]][:count] >= coupon[:num]
        new_item_name = "#{coupon[:item]} W/COUPON"
          if cart[new_item_name]
            cart[new_item_name][:count] += coupon[:num]
          else
            cart[new_item_name] = {
              price: coupon[:cost] / coupon[:num],
              clearance: cart[coupon[:item]][:clearance],
              count: coupon[:num]
            }
          end
          cart[coupon[:item]][:count] -= coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.keys.each do |item_name|
    if cart[item_name][:clearance] == true
      cart[item_name][:price] = (cart[item_name][:price] * 0.80).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
cart = consolidate_cart(cart)
coupon_cart = apply_coupons(cart, coupons)
final_cart = apply_clearance(coupon_cart)
total_cost = 0

final_cart.each do |item_name, data|
  total_cost += data[:price] * data[:count]
end

if total_cost > 100.0 == true
  total_cost = (total_cost * 0.90).round(2)
end
total_cost
end
