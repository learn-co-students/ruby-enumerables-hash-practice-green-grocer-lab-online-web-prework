require_relative 'grocer'

def items
	[
		{"AVOCADO" => {:price => 3.00, :clearance => true}},
		{"KALE" => {:price => 3.00, :clearance => false}},
		{"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
		{"ALMONDS" => {:price => 9.00, :clearance => false}},
		{"TEMPEH" => {:price => 3.00, :clearance => true}},
		{"CHEESE" => {:price => 6.50, :clearance => false}},
		{"BEER" => {:price => 13.00, :clearance => false}},
		{"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
		{"BEETS" => {:price => 2.50, :clearance => false}}
	]
end

def coupons
	[
		{:item => "AVOCADO", :num => 2, :cost => 5.00},
		{:item => "BEER", :num => 2, :cost => 20.00},
		{:item => "CHEESE", :num => 3, :cost => 15.00}
	]
end

def generate_cart
	[].tap do |cart|
		rand(20).times do
			cart.push(items.sample)
		end
	end
end

def generate_coupons
	[].tap do |c|
		rand(2).times do
			c.push(coupons.sample)
		end
	end
end

=begin
def consolidate_cart(items)

  hashed_cart = Hash.new

  items.each do |item|

    item.each do |n,m|

      if !hashed_cart[n]
        hashed_cart[n] = m
        hashed_cart[n][:count] = 1
      else
        hashed_cart[n][:count] += 1
      end

    end
  end

  hashed_cart
end


def apply_coupons(cart, coupons)

  if coupons.empty?
    return cart
  end

  coupons.each do |coupon|              # iterate through coupons
    if cart.include? coupon[:item]      # if cart includes a item with same name of coupon item
      puts "Found Coupon for Item"
      item_name = coupon[:item]         # get item details
      item_qty = cart[item_name][:count]
      item_price = cart[item_name][:price]

      discount_qty = coupon[:num]       # get coupon details
      discount_cost = coupon[:cost]

      if discount_qty > 1 
        discount_price = discount_cost / discount_qty   # calculate price per item
      else
        discount_price = discount_cost
      end

      cart[item_name][:count] = item_qty - discount_qty     # deduct discounted items at regular, then add discounted info

      cart["#{item_name} W/COUPON"] = {
        :price =>  discount_price,
        :clearance => "#{cart[item_name][:clearance]}",
        :count => discount_qty
      }

      p cart
    end
  end
end

def apply_clearance(cart)

  cart.each do |item, hash|

    puts "ITem: #{item}\nHash: #{hash}"

    puts "Keys: #{hash.keys}"

    # if item.first.keys.include? :clearance
    #   price = item.first[:cost]
    #   item.first[:cost] = "%.2f" % (price * 0.8)
    # end

    if hash.keys.include? :clearance
      price = hash[:cost]
      hash[:cost] = "%.2f" % (price * 0.8)
    end


  end

  cart
end


def checkout(unsorted_items, coupons)

  puts "Cart 0: #{unsorted_items}"

  cart = consolidate_cart(unsorted_items)
  
  puts "cart1: #{cart}"
  
  
  cart = apply_coupons(cart, coupons)
  
  puts "cart 2: #{cart}"
  
  cart = apply_clearance(cart)
  
  total = 0
  
  cart.each do |item, attrs|
    puts "Item: #{item} \nPrice: #{attrs[:price]} \nQty: #{attrs[:count]}"    
  end
  
  cart
end

=end

cart = generate_cart
coupons = generate_coupons

# puts "Items in cart"
# cart.each do |item|
# 	puts "Item: #{item.keys.first}"
# 	puts "Price: #{item[item.keys.first][:price]}"
# 	puts "Clearance: #{item[item.keys.first][:clearance]}"
# 	puts "=" * 10
# end

puts "Coupons on hand"
coupons.each do |coupon|
	puts "Get #{coupon[:item].capitalize} for #{coupon[:cost]} when you by #{coupon[:num]}"
end


puts "Your total is #{checkout(cart, coupons)}"
