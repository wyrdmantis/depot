require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  def new_product(*args)
    Product.new(*args)
  end

  test "product attributes must not be empty" do
    product = new_product
    assert product.invalid?
    product.errors.messages.each do |v|
      assert v.any?
    end
  end

  test "product title must be unique" do
    duplicated = products(:one)
    assert duplicated.invalid?
    assert_equal ["has already been taken"], duplicated.errors[:title]
  end

  test "description must be 10 or more characters long" do
    assert products(:invalid_description).invalid?
  end

  test "product price can't be negative" do
    assert new_product(title:       "Book",
                       description: "bazbazbazbaz",
                       image_url:   "bom.jpg",
                       price:       -1,
                       locale:      "en").invalid?
  end

  test "product price can't be zero" do
    assert new_product(title:       "Book",
                       description: "bazbazbazbaz",
                       image_url:   "bom.jpg",
                       price:       0,
                       locale:      "en").invalid?
  end

  test "product price must be positive" do
    assert new_product(title:       "Book",
                       description: "bazbazbazbaz",
                       image_url:   "bom.jpg",
                       price:       1,
                       locale:      "en").valid?
  end

  test "product image_url must be a valid url" do
    params       = {:title       => "Book",
                    :description => "Bazbazbazbaz",
                    :price       => 10,
                    :locale      => "en"}
    valid_urls   = %w(baz.jpg BAZ.JPG foo.png FOO.png foo/baz/bar.jpg
                      ../FOO.GIF)
    invalid_urls = %w(baz foo.gi bar.pnd book book.png.foo ../baz.exe
                      book.gif/foo)
    valid_urls.each do |url|
      assert new_product(params.merge(image_url: url)).valid?, "#{url} should be valid"
    end
    invalid_urls.each do |url|
      assert new_product(params.merge(image_url: url)).invalid?, "#{url} should not be valid"
    end
  end
end
