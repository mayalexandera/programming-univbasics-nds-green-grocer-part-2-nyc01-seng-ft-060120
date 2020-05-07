require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
   cart.each do |product|
    coupons.each do |coupon_product|
      if product[:item] === coupon_product[:item]
        new_product = {}
        new_product[:item] = product[:item] + " W/COUPON"
        new_product[:price] = coupon_product[:cost] / (coupon_product[:num])
        new_product[:clearance] = product[:clearance]
        
        if product[:count] >= coupon_product[:num]
          new_product[:count] = coupon_product[:num]
          product[:count] -= coupon_product[:num]
          cart << new_product
        end
      end
    end
  end
  cart
end


def apply_clearance(cart)
  cart.each do |product|
    if product[:clearance] === true
      product[:price] = (product[:price] * 0.8).round(3)
    end
  end
  cart
end


def checkout(cart, coupons)
  total = 0
  new_cart = consolidate_cart(cart)

  
  #cart size
  if (new_cart.length === 1 && coupons.empty?) || (new_cart.length > 1 && coupons.empty?)
    apply_clearance(new_cart)
  end
  
  if (new_cart.length === 1 && coupons.length === 1) || (new_cart.length >= 1 && coupons.length >= 1)
    apply_coupons(new_cart, coupons)
    apply_clearance(new_cart)
  end

  new_cart.each do |product|
    total += (product[:price] * product[:count])
  end
  if total > 100
    total = total * 0.9
  end
  total
end

