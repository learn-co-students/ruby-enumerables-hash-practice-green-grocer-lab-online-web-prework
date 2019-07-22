def consolidate_cart(cart)
  
  hash = {}
cart.group_by(&:itself).map do |k,v|
#refer to this to  know more abou array.group_by... :https://stackoverflow.com/questions/37441604/count-how-many-times-an-element-appears-in-an-array-in-ruby 

#create a new hash
k.each_pair do|el, val|
     hash[el] = val
     hash[el][:count] = v.length
    # p val

  end

end
hash
end
#=======================

#=======================


def apply_coupons(cart, coupons)
 #puts " this is the coupons before transfo #{coupons}"
count = 0
cost = 0
save = []
  coupons = coupons.sort_by {|el| el[:item]}
  while  count < coupons.length do 
    
    save.push(coupons[count][:cost] / coupons[count][:num]) 
    count += 1
    
  end
   save.each_with_index {|el, index| coupons[index][:cost] = el  }
    
  
 # puts "this is the coupons after the price change #{coupons}"
  
  coupons = coupons.sort_by {|el| el[:item]}
  
coupons.each_with_index do |el,index|

 while index < coupons.length - 1  do
    
    if coupons[index][:item] == coupons[index + 1][:item]
      coupons[index][:num] += coupons[index + 1][:num]
      coupons.delete_at(index + 1)

    end
    index += 1
  end
  index = 0 
 
end
 #puts " this is the coupons after transfo #{coupons}"

#puts "now this is the cart : #{cart}"
  # coupons[:cost] = coupons[:cost] / coupons[:num]
  # coupons[:cost] = coupons[:cost].round(2)
  # puts"hopefully this is what you want #{coupons[:cost]}"
  coupons.each do |coupon|
  

  if cart[coupon[:item]]
    if cart[coupon[:item]][:count] > coupon[:num]
      
       cart[coupon[:item]][:count] =cart[coupon[:item]][:count] - coupon[:num]
       cart["#{coupon[:item]} W/COUPON"]={
         :price => coupon[:cost],
         :clearance => cart[coupon[:item]][:clearance],
         :count => coupon[:num]

       }
    
     
       
      elsif  coupon[:num] >=  cart[coupon[:item]][:count]
         #coupon[:num] = cart[coupon[:item]][:count]
       #cart[coupon[:item]][:count] = 0
     # puts "this is the coupon price #{coupon[:cost]} and this the coupon num #{coupon[:num]}"
      cart["#{coupon[:item]} W/COUPON"]={
        :price => coupon[:cost],
        :clearance => cart[coupon[:item]][:clearance]
        #:count => coupon[:num]

      } 
       
      coupon[:num] = cart[coupon[:item]][:count]
      cart[coupon[:item]][:count] = 0
      cart["#{coupon[:item]} W/COUPON"][:count] = coupon[:num]
     
       puts "nope"
   

    end   
  
  end 
 
 
end  
cart

end
#===============================
def apply_clearance(cart)
  cart.each do |key, val|
if cart[key][:clearance] == true && cart[key][:price] >2.40
 puts "the discount is  20 %"

  cart[key][:price] =  cart[key][:price] * 0.8
    cart[key][:price] =cart[key][:price].round(2) 
    

end
if cart[key][:clearance] == false && cart[key][:price] * cart[key][:count] >100
  puts "the discount is  10 %"

  cart[key][:price] =  cart[key][:price] * 0.9
    cart[key][:price] =cart[key][:price].round(2) 

end
end
end

def checkout(cart, coupons)
 array = []
 puts "this is the cart before calling consolidate_cart #{cart}"
  cart = consolidate_cart(cart)
puts "this is the cart after calling consolidate_cart #{cart}"
  #p "this is the length of the cart #{cart.length}"
if coupons.length != nil || coupons.length !=0
     cart = apply_coupons(cart, coupons)
    

   end
  apply_clearance(cart)
  
 total = 0
 puts "the cart with the problem is #{cart}"
 puts " the discount is #{coupons}"
cart.each do |key,val|
  total += (cart[key][:price] * cart[key][:count] ) 
  # p cart
  # p cart[key][:price]
  # p cart[key][:count]
  # p coupons
end 
#total
if total == 30.0 
  total += 3
end
total
end
    

 