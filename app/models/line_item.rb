class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart

  def total_price
    product.price * quantity
  end

  def decrement
    if quantity > 1
      self.quantity -= 1
    else
      destroy
    end
  end
end
