def consolidate_cart(cart) 
  new_cart = {}                               #creating a new hash
  cart.each do |item|                         #iterating through each item in cart to check inside a nested hash
    item_name = item.keys[0]                  #giving variable item_name the value of item.keys [EXAMPLE.keys[NUM] returns the keys of an                                          element hash!]
    if new_cart[item_name]                    #if statement declaring that if there is an item already present, then increase the count
      new_cart[item_name][:count] += 1 
    else                                      #otherwise, create an instance of that item and then set it's count to 1
      new_cart[item_name] = item[item_name]
      new_cart[item_name][:count] = 1
    end
  end
  new_cart                                    #and finally ask to return the new hash
end

def apply_coupons(cart, coupons)
  
  coupons.each do |coupon|
    item = coupon[:item]                      #selects the item that the coupon applies to via the hash given
    
    if cart[item]                             #If the cart has the item . . .
      if cart[item][:count] >= coupon[:num] && !cart["#{item} W/COUPON"]
                                              
                                              # . . . and if the count >= the number of coupons for that same item, and there not a cart["#{item} W/COUPON"] in existence . . . 
                                              
        cart["#{item} W/COUPON"] = {price: coupon[:cost] / coupon[:num], clearance: cart[item][:clearance], count: coupon[:num]}
        cart[item][:count] -= coupon[:num]                                        
                                              #then create the discounted item and it's hash. coupon[:num] gives you the count for the coupons. Therefore, you can decrease the non-discounted items by the number of coupons and create a coupon set that IS discounted
                                              
      elsif cart[item][:count] >= coupon[:num] && cart["#{item} W/COUPON"]
      
                                              #Otherwise, if there IS a cart[item w/ coupon] in existence . . .
                                              
        cart["#{item} W/COUPON"][:count] += coupon[:num]
        cart[item][:count] -= coupon[:num]
                                              #then just update the count of the cart["#{item} W/COUPON"] and the count for the regular cart.
      end
    end
    
  end
  cart                                        #RETURN THE CART
end

def apply_clearance(cart)
  cart.each do |product_name, stats|          #product_name = key, stats = values
    if stats[:clearance] == TRUE              #If the clearance value is true . . .
      stats[:price] -= stats[:price] * 0.2    #Adjust the price value accordingly!
    end
  end
    cart                                      #RETURN THE CART
end

def checkout(cart, coupons)
  hash_cart = consolidate_cart(cart)                    #Start by creating a cart using the consolidate_cart helper_method
  applied_coupons = apply_coupons(hash_cart, coupons)   #Then run that new cart through coupons
  applied_clearance = apply_clearance(applied_coupons)  #and that new cart through clearance
  
  total = applied_clearance.reduce(0) { | acc, (key, value) | acc += value[:price] * value[:count]}
                                                        #your total cart is based on a reduction of the clearance cart. Your initial value is 0. You then run it through the block of sum (acc) and the key/values of the items nested in the carts.
                                                        #For the math portion, it reads "Your final number is the sum of the price of each item times the amount of each item."
    if total > 100
      total = total - (total * 0.1)                     #If your cart is over $100, the store gives you 10% off!
    end
  
  total                                                 #RETURN THE VALUE!!
end
