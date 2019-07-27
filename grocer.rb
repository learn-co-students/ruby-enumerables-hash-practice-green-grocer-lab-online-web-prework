def consolidate_cart(cart)
  organized_cart = {}
count = 0
cart.each do |element|
  element.each do |fruit, hash|
    organized_cart[fruit] ||= hash
    organized_cart[fruit][:count] ||= 0
    organized_cart[fruit][:count] += 1
  end
end
return organized_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon_hash|
  fruit_name = coupon_hash[:item]
  new_coupon_hash = {
    :price => coupon_hash[:cost],
    :clearance => "true",
    :count => coupon_hash[:num]
  }

   if cart.key?(fruit_name)
    new_coupon_hash[:clearance] = cart[fruit_name][:clearance]
    if cart[fruit_name][:count]>= new_coupon_hash[:count]
      new_coupon_hash[:count] = (cart[fruit_name][:count]/new_coupon_hash[:count]).floor
      cart[fruit_name][:count] = (coupon_hash[:num])%(cart[fruit_name][:count])
    end
    cart[fruit_name + " W/COUPON"] = new_coupon_hash
  end
  end
return cart
end

test_cart = {
"AVOCADO" => {:price => 3.0, :clearance => true, :count => 4},
"KALE"    => {:price => 3.0, :clearance => false, :count => 1}
}

test_coupon =
[
  {:item => "AVOCADO", :num => 2, :cost => 5.00},
  {:item => "BEER", :num => 2, :cost => 20.00},
  {:item => "CHEESE", :num => 3, :cost => 15.00}
]

result =
{
"AVOCADO" => {:price => 3.0, :clearance => true, :count => 2},
"KALE"    => {:price => 3.0, :clearance => false, :count => 1}
}

apply_coupons(test_cart, test_coupon)


def apply_clearance(cart)
  cart.each do |item, price_hash|
  if price_hash[:clearance] == true
    price_hash[:price] = (price_hash[:price] * 0.8).round(2)
  end
end
cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(items)
  cart1 = apply_coupons(cart, coupons)
  cart2 = apply_clearance(cart1)

  total = 0

  cart2.each do |name, price_hash|
    total += price_hash[:price] * price_hash[:count]
  end

  total > 100 ? total * 0.9 : total

end

items =   [
      {"AVOCADO" => {:price => 3.00, :clearance => true}},
      {"AVOCADO" => {:price => 3.00, :clearance => true}},
      {"AVOCADO" => {:price => 3.00, :clearance => true}},
      {"AVOCADO" => {:price => 3.00, :clearance => true}},
      {"AVOCADO" => {:price => 3.00, :clearance => true}},
      {"KALE" => {:price => 3.00, :clearance => false}},
      {"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
      {"ALMONDS" => {:price => 9.00, :clearance => false}},
      {"TEMPEH" => {:price => 3.00, :clearance => true}},
      {"CHEESE" => {:price => 6.50, :clearance => false}},
      {"BEER" => {:price => 13.00, :clearance => false}},
      {"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
      {"BEETS" => {:price => 2.50, :clearance => false}},
      {"SOY MILK" => {:price => 4.50, :clearance => true}}
    ]

coupons = [
      {:item => "AVOCADO", :num => 2, :cost => 5.00},
      {:item => "AVOCADO", :num => 2, :cost => 5.00},
      {:item => "BEER", :num => 2, :cost => 20.00},
      {:item => "CHEESE", :num => 2, :cost => 15.00}
    ]

checkout(items, coupons)
