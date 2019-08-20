def consolidate_cart(array_hash_cart = [
                                          {"AVOCADO" => {:price => 3.00, :clearance => true }},
                                          {"AVOCADO" => {:price => 3.00, :clearance => true }},
                                          {"KALE"    => {:price => 3.00, :clearance => false}}
                                       ])
  # code here
  new_hash_cart = {}; # new cart that's to be modified and later returned
  array_hash_cart.each do |hash_item| # looking at each item in the cart...
  	if(new_hash_cart[hash_item.keys[0]]); # ...if there is key in the hash then...
  		new_hash_cart[hash_item.keys[0]][:count] += 1; # ...increments it's count by 1.
  	else # But if there's no keys in current hash then...
      new_hash_cart[hash_item.keys[0]] = # ...add a new hash item along with associated values.
      {
	  	price: hash_item.values[0][:price],
	    clearance: hash_item.values[0][:clearance],
	    count: 1,
	   }
  	end;
  end;
  return(new_hash_cart);
end;

def apply_coupons(array_hash_cart, array_hash_coupon)
  # code here
  array_hash_coupon.each do |hash_coupon|
    if array_hash_cart.keys.include? hash_coupon[:item]
      if array_hash_cart[hash_coupon[:item]][:count] >= hash_coupon[:num]
        new_name = "#{hash_coupon[:item]} W/COUPON";
        if array_hash_cart[new_name]
          array_hash_cart[new_name][:count] += hash_coupon[:num];
        else
          array_hash_cart[new_name] = 
          {
            price: hash_coupon[:cost]/hash_coupon[:num],
            clearance: array_hash_cart[hash_coupon[:item]][:clearance],
            count: hash_coupon[:num]
          }
        end;
        array_hash_cart[hash_coupon[:item]][:count] -= hash_coupon[:num];
      end;
    end;
  end;
  return(array_hash_cart);
end;

def apply_clearance(hash_cart)
  hash_cart.keys.each do |hash_item|
    if hash_cart[hash_item][:clearance]
      hash_cart[hash_item][:price] = (hash_cart[hash_item][:price]*0.80).round(2);
    end;
  end;
  return(hash_cart);
end

def checkout(array_hash_cart, array_hash_coupon)
  consolidated_cart = consolidate_cart(array_hash_cart);
  coupons_applied = apply_coupons(consolidated_cart, array_hash_coupon);
  discounts_applied = apply_clearance(coupons_applied);

  sub_total = 0.00
  discounts_applied.keys.each do |item|
    sub_total += discounts_applied[item][:price]*discounts_applied[item][:count]
  end
  sub_total > 100.00 ? (sub_total * 0.90).round : sub_total
end

consolidated_cart = consolidate_cart;
p(consolidated_cart);
puts;

coupons_applied = apply_coupons(consolidated_cart, [{:item => "AVOCADO", :num => 2, :cost => 5.00}]);

p(coupons_applied);
puts;

clearance_applied = apply_clearance(
{
	"PEANUT BUTTER" => {:price => 3.00, :clearance => true,  :count => 2},
	"KALE"         => {:price => 3.00, :clearance => false, :count => 3},
	"SOY MILK"     => {:price => 4.50, :clearance => true,  :count => 1}
});

p(clearance_applied);
puts;

sub_total_checkout = checkout(
	[
	  {"AVOCADO" => {:price => 3.00, :clearance => true }},
	  {"AVOCADO" => {:price => 3.00, :clearance => true }},
	  {"KALE"    => {:price => 3.00, :clearance => false}}
	],
	[
		{:item => "AVOCADO", :num => 2, :cost => 5.00}
	]);
p(sub_total_checkout);
puts