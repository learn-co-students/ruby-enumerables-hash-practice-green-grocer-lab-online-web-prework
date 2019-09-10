def consolidate_cart(cart)
  # code here
  new_cart = {}
  cart.each do |piece| 
    piece.each do |item, attr_hash|
      new_cart[item] ||= attr_hash
      new_cart[item][:count] ||= 0
      new_cart[item][:count] += 1
    end
  end
  new_cart
end

def apply_coupons(cart, coupons= {})
  # code here
  new_prices = {}
  cart.each do |grocery_item, item_details|
    discounted_item = grocery_item.dup + " W/COUPON"
    discounted_details = {:price => nil, :clearance => nil, :count =>nil}
    coupons.each do |coupon| 
      if coupon[:item] == grocery_item && item_details[:count] >= coupon[:num]
	      discounted_details[:price] = (coupon[:cost] / coupon[:num])
	      discounted_details[:count] ||= 0
	      discounted_details[:count] += coupon[:num]
        discounted_details[:clearance] = item_details[:clearance].dup
        item_details[:count] -= coupon[:num]
        new_prices[grocery_item] = item_details
        new_prices[discounted_item] = discounted_details
      end
    end
    
  new_prices[grocery_item] ||= item_details
  end
  new_prices
end

def apply_clearance(cart)
  # code here
  updated_cart = {}
  cart.each do |item, details|
    if details[:clearance]
      details[:price] = (details[:price] * 0.8).round(2)
      updated_cart[item] = details
    else
      updated_cart[item] = details
    end
  end
  updated_cart
end

def checkout(cart, coupons = {})
  new_cart = consolidate_cart(cart)
  new_cart = apply_coupons(new_cart,coupons)
  new_cart = apply_clearance(new_cart)
  new_cost = 0
  new_cart.each do |item, details|
    new_cost += (details[:count] * details[:price])
  end
  if new_cost > 100
    new_cost -= (new_cost * 0.1)
  end
  new_cart
  new_cost
end
puts checkout(
  [{"AVOCADO" => {:price => 3.00, :clearance => true }},{"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"KALE"    => {:price => 3.00, :clearance => false}}
],[{:item => "AVOCADO", :num => 2, :cost => 5.00},{:item => "BEER", :num => 2, :cost => 20.00}, {:item => "CHEESE", :num => 3, :cost => 15.00}])
