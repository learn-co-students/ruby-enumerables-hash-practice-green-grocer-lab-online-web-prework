def consolidate_cart(cart)
  
  hash = {}
cart.group_by(&:itself).map do |k,v|
#refer to this to  know more abou array.group_by... :https://stackoverflow.com/questions/37441604/count-how-many-times-an-element-appears-in-an-array-in-ruby 

#create a new hash
k.each_pair do|el, val|
     hash[el] = val
     hash[el][:count] = v.length
   

  end

end
hash
end

def apply_coupons(cart, coupons)

count = 0
save = []
  while  count < coupons.length do 
    
    save.push(coupons[count][:cost] / coupons[count][:num]) 
    count += 1
    
  end
   save.each_with_index {|el, index| coupons[index][:cost] = el  }
    
  coupons.each do |coupon|
  
  if cart[coupon[:item]]
     
        if cart[coupon[:item]][:count] >= coupon[:num]
          
           cart[coupon[:item]][:count] =cart[coupon[:item]][:count] - coupon[:num]
           if !cart["#{coupon[:item]} W/COUPON"]
             
               cart["#{coupon[:item]} W/COUPON"]={
                 :price => coupon[:cost],
                 :clearance => cart[coupon[:item]][:clearance],
                 :count => coupon[:num]
        
               }
             else
               cart["#{coupon[:item]} W/COUPON"][:count] += coupon[:num]
          end
          
        end   
  
  end 
 
end  
cart

end

def apply_clearance(cart)
  cart.each do |key, val|
      if cart[key][:clearance] 
      
        cart[key][:price] =  cart[key][:price] * 0.8
          cart[key][:price] =cart[key][:price].round(2) 
          
      end
  end
  cart
end

def checkout(cart, coupons)

  total = 0
  newCart = consolidate_cart(cart)
  cart_with_coupon = apply_coupons(newCart, coupons)
  cart_with_discount = apply_clearance(cart_with_coupon)

cart_with_discount.each do |key,val|
  total +=  (cart_with_discount[key][:price] * cart_with_discount[key][:count] ) 
end 


  if  total >100
        total *= 0.9  
  end

total
end
    

 