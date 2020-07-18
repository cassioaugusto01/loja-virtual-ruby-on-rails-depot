require 'test_helper'

class ProductTest < ActiveSupport::TestCase
    test "atributos do produto não podem estar vazios" do
      product = Product.new
      assert product.invalid?
      assert product.errors[:title].any?
      assert product.errors[:description].any?
      assert product.errors[:price].any?
      assert product.errors[:image_url].any?
    end

    test "preço do produto precisa ser positivo" do
      product = Product.new(title: "titulo do livro", 
        description: "yyy", image_url: "zzz.jpg")
        product.price = -1
        assert product.invalid?
        assert_equal ["precisa ser maior que 0.01"],
          product.errors[:price]

        product.price = 0
        assert product.invalid?
        assert_equal ["must be greater than or equal to 0.01"],
          product.errors[:price]

        product.price = 1
        assert product.valid?
    end

    def new_product(image_url)
      Product.new(title: "meu livro",
        description: "yyyy",
        price: 1,
        image_url: image_url)
    end
=begin
    test "image url" do
      ok = %w{ aaaa.gif aaaa.jpg aaaa.png AAAA.JPG AAAA.Jpg
        http://a.b.c/x/y/z/aaaa.gif }
      bad = %w { fred.doc fred.gif/more fred.gif.more }

      ok.each do |image_url|
        assert new_product(image_url).valid?,
          "#{image_url} shouldn t be invalid"
    end

    bad.each do |image_url|
      assert new_product(image_url).invalid? "#{image_url} nao devera ser valido"
    end
  end
=end