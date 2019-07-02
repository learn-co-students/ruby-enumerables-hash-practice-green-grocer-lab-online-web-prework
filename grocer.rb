require 'pry'

def consolidate_cart(cart)
  consolidated = Hash.new(0)
  cart.each do |whole_cart| 
    whole_cart.each do |each_item|
      item = each_item[0]
      if consolidated.include?(item)
        consolidated[item][:count] += 1
      else
        consolidated[item] = each_item[1]
        consolidated[item][:count] = 1
      end
    end
  end
  consolidated
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include?(coupon[:item])
      item_name = coupon[:item]
      new_item_name = "#{item_name} W/COUPON"
      if cart.key?(new_item_name) && cart[item_name][:count] >= coupon[:num]
        cart[new_item_name][:count] += coupon[:num]
      elsif cart.key?(new_item_name) && cart[item_name][:count] < coupon[:num]
        cart[item_name][:count] += coupon[:num]
      else
          cart[new_item_name] = {
          price: coupon[:cost] / coupon[:num],
          clearance: cart[item_name][:clearance],
          count: coupon[:num]
          }
      end
      cart[item_name][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |element|
    item_name = element[0]
    if cart[item_name][:clearance]
      cart[item_name][:price] = (cart[item_name][:price] * 0.80).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated = consolidate_cart(cart)
  coupons_cart = apply_coupons(consolidated, coupons)
  clearance_cart = apply_clearance(coupons_cart)
  sum = 0
  clearance_cart.each do |element|
    item_name = element[0]
    sum += (element[1][:price] * element[1][:count])
  end
  if sum > 100
    sum = sum * 0.90
  end
sum
end