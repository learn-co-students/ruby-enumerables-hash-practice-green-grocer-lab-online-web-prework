require 'pry'

def consolidate_cart(cart)
  holder=[]
  new_cart={}
  
  cart.each do |item|
    count_var=cart.count(item)
    holder.push(count_var)
  end
  
  cart.each do|item|
    item.each do |key, value|
      value[:count]=holder[cart.index(item)]
      new_cart[key]=value
    end
  end
  
  new_cart
    
  #binding.pry
  
end

def apply_coupons(cart, coupons)
  add_to_cart={}
  coupons.each do |item|
    cart.each do |key,value|
      if key == item[:item]
        if value[:count]>=item[:num]
          add_to_cart[key + " W/COUPON"]={
            :price => item[:cost]/item[:num],
            :clearance => value[:clearance],
            :count => value[:count]-(value[:count]%item[:num])
          }
          value[:count]=value[:count]%item[:num]
        end
      end
     #cart.delete_if {|key, value| value[:count]==0}
    end
  end
  add_to_cart.each{|key,value| cart[key]=value}
  #binding.pry
  cart
end

def apply_clearance(cart)
  cart.each do |key,value|
    value[:price]=(value[:price] * 0.8).round(2) if value[:clearance]
  end
end

def checkout(cart, coupons)
  cart=consolidate_cart(cart)
  cart=apply_coupons(cart,coupons)
  cart=apply_clearance(cart)
  total=0

  cart.each do |key,value|
    total+=(value[:price]*value[:count])
  end
  
  if total>100
    total*=0.9
  end
  
  total
  
end
