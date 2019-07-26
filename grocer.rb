def consolidate_cart(cart)
  new_cart = {}
cart.each do |items_array|
  items_array.each do |item, attribute_hash|
    new_cart[item] ||= attribute_hash
    new_cart[item][:count] ? new_cart[item][:count] += 1 :
    new_cart[item][:count] = 1
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include?(coupon[:item]) #Checks to see if our cart includes an item that has a coupon
      if cart[coupon[:item]][:count] >= coupon[:num] #If we have a couponed item, it is greater than or equal to the amount needed for the coupon
        itemwithCoupon = "#{coupon[:item]} W/COUPON" #If it meets the requirements, a new hash is created for the item and is assigned to a variable to make life easier
        if cart[itemwithCoupon] #If our cart has an item meeting coupon requirements
          cart[itemwithCoupon][:count] += coupon[:num] #Updates the amount 
          cart[coupon[:item]][:count] -= coupon[:num]
        else
          cart[itemwithCoupon] = {}
          cart[itemwithCoupon][:price] = (coupon[:cost] / coupon[:num])
          cart[itemwithCoupon][:clearance] = cart[coupon[:item]][:clearance]
          cart[itemwithCoupon][:count] = coupon[:num]
          cart[coupon[:item]][:count] -= coupon[:num]
        end
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, attribute_hash|
    if attribute_hash[:clearance] == true
      attribute_hash[:price] = (attribute_hash[:price] *
      0.8).round(2)
    end
  end
cart
end

def checkout(cart, coupons)
  food = consolidate_cart(cart)
  cart1 = apply_coupons(food, coupons)
  cart2 = apply_clearance(cart1)

  total = 0

  cart2.each do |name, price_hash|
    total += price_hash[:price] * price_hash[:count]
  end

  total > 100 ? total * 0.9 : total
end
