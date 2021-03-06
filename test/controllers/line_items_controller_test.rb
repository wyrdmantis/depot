require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  setup do
    @line_item = line_items(:one)
    @cart = carts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should allow only admin to view line items page" do
    logout
    get :index
    assert_redirected_to login_url
  end

  test "should allow only admin to edit line item" do
    logout
    get :edit, id: @line_item
    assert_redirected_to login_url
  end

  test "should allow only admin to update line items page" do
    logout
    patch :update, id: @line_item, line_item: { product_id: @line_item.product_id }
    assert_redirected_to login_url
  end

  test "should allow only admin to destroy line items" do
    logout
    @cart.line_items << @line_item
    assert_difference('LineItem.count', 0) do
      delete :destroy, id: @line_item
    end

    assert_redirected_to login_url
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      post :create, product_id: products(:ruby).id
    end

    assert_redirected_to store_path
  end

  test "should create line_item through AJAX" do
    assert_difference("LineItem.count") do
      xhr :post, :create, product_id: products(:ruby).id
    end

    assert_response :success
    assert_select_jquery :html, '#cart' do
      assert_select 'tr#current_item td', /Programming Ruby \d\.\d/
    end
  end

  test "should show line_item" do
    get :show, id: @line_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @line_item
    assert_response :success
  end

  test "should update line_item" do
    patch :update, id: @line_item, line_item: { product_id: @line_item.product_id }
    assert_redirected_to line_item_path(assigns(:line_item))
  end

  test "should destroy line_item" do
    @cart.line_items << @line_item
    assert_difference('LineItem.count', -1) do
      delete :destroy, id: @line_item
    end

    assert_redirected_to store_url
  end

  test "should destroy line_item through AJAX" do
    @cart.line_items << @line_item
    xhr :post, :destroy, id: @line_item

    assert_response :success

    assert_select_jquery :html, '#cart' do
      assert_select 'tr', 1
      assert_select 'tr td.total_cell', /0.00/
    end
  end

  test "should destroy line_item when quantity is 1" do
    assert_difference('LineItem.count', -1) do
      post :decrement, id: @line_item
    end

    assert_redirected_to store_url
  end

  test "should destroy line_item when quantity is 1 through AJAX" do
    assert_difference('LineItem.count', -1) do
      xhr :post, :decrement, id: @line_item
    end

    assert_response :success
  end
end
