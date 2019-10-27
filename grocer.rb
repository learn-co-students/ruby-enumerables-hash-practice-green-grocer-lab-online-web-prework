def consolidate_cart(cart)
  hash = {}
  cart.each do |item_hash|
    item_hash.each do |name, price_hash|
      if hash[name].nil?
        hash[name] = price_hash.merge({:count => 1})
      else
        hash[name][:count] += 1
      end
    end
  end
  hash
end

def apply_coupons(cart, coupons)
  hash = cart
  coupons.each do |coupon_hash|
    # add coupon to cart
    item = coupon_hash[:item]

    if !hash[item].nil? && hash[item][:count] >= coupon_hash[:num]
      temp = {"#{item} W/COUPON" => {
        :price => coupon_hash[:cost],
        :clearance => hash[item][:clearance],
        :count => 1
        }
      }
      
      if hash["#{item} W/COUPON"].nil?
        hash.merge!(temp)
      else
        hash["#{item} W/COUPON"][:count] += 1
        #hash["#{item} W/COUPON"][:price] += coupon_hash[:cost]
      end
      
      hash[item][:count] -= coupon_hash[:num]
    end
  end
  hash
end

def apply_clearance(cart)
  cart.each do |item, price_hash|
    if price_hash[:clearance] == true
      price_hash[:price] = (price_hash[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(items, coupons)
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
total = 0
  cart = consolidate_cart(cart)
  coupons_applied = apply_coupons(cart, coupons)
  
  clearance_applied = apply_clearance(coupons_applied)
  #puts clearance_applied
  clearance_applied.each do |item, item_hash|
    if item_hash[:count] < 0 
      item_hash[:count] = -(item_hash[:count])
    end
    if !item.include?('W/COUPON')
      if clearance_applied[item][:count] < clearance_applied["#{item} W/COUPON"][:count]
        clearance_applied["#{item} W/COUPON"][:count] = clearance_applied[item][:count]
      end
    end
    #if clearance_applied[item][:count] < clearance_applied["#{item} W/COUPON"][:count]
      #clearance_applied["#{item} W/COUPON"][:count] = clearance_applied[item][:count]
    #end
    total += (item_hash[:price] * item_hash[:count])
    puts total
  end
  if total >= 100
    total = total - (total *0.10)
  else 
    total
  end
end

coupons = [{:item => "BEER", :num => 2, :cost => 20.00}, {:item => "BEER", :num => 2, :cost => 20.00}]

cart = [
  {"BEER" => {:price => 13.00, :clearance => false}},
  {"BEER" => {:price => 13.00, :clearance => false}},
  {"BEER" => {:price => 13.00, :clearance => false}}
]

checkout(cart, coupons)