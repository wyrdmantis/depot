require 'test_helper'

class CartTest < ActiveSupport::TestCase
  fixtures :products

  def create_cart_with_one_product(product)
    cart = Cart.create
    cart.add_product(products(product).id).save
    cart
  end

  test "cart should create a new line item when adding a product" do
    cart = create_cart_with_one_product(:one)
    assert_equal 1, cart.line_items.count
    cart.add_product(products(:ruby).id).save
    assert_equal 2, cart.line_items.count
  end

  test "cart should update existing line item when adding existing product" do
    cart = create_cart_with_one_product(:ruby)
    cart.add_product(products(:ruby).id)
    assert_equal 1, cart.line_items.count
  end
end
