def consolidate_cart(cart)
  {	
  "PEANUTBUTTER" => {:price => 3.00, :clearance => true,  :count => 2},	
  "KALE"         => {:price => 3.00, :clearance => false, :count => 3}	
  "SOY MILK"     => {:price => 4.50, :clearance => true,  :count => 1}	
}	
```	

 it should return a cart with clearance applied to peanutbutter and soy milk:	

 ```ruby	
{	
  "PEANUTBUTTER" => {:price => 2.40, :clearance => true,  :count => 2},	
  "KALE"         => {:price => 3.00, :clearance => false, :count => 3}	
  "SOY MILK"     => {:price => 3.60, :clearance => true,  :count => 1}	
}	
```
end

def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
