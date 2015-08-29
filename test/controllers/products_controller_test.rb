require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
    @params = {
      title:       'Lorem Ipsum',
      description: 'Wibbles are fun!',
      image_url:   'lorem.jpg',
      price:       19.95
    }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
    assert_select ".list_description dl dd", /^Ruby(.*)/
    assert_select ".list_description dl dt", /Programming Ruby(.*)/
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: @params
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "only allow admin to create products" do
    logout
    assert_difference('Product.count', 0) do
      post :create, product: @params
    end
  end

  test "only allow admin to edit products" do
    logout
    get :show, id: @product
    assert_redirected_to login_url
  end

  test "only allow admin to remove products" do
    logout
    delete :destroy, id: @product
    assert_redirected_to login_url
  end

  test "only allow admin to access products page" do
    logout
    get :show, id: @product
    assert_redirected_to login_url
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    patch :update, id: @product, product: @params
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end
end
