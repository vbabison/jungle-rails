require 'rails_helper'
#require 'shoulda/matchers'

RSpec.describe Product, type: :model do

  before do
      @category = Category.create(name: "chairs")
  end

  context "Validations" do


    it "has all valid properties " do
      @product = Product.create(name:"Big Chair", price: 1,
                                quantity: 1, category: @category)
      @product.validate!
      @product.errors.full_messages
    end

    it "must have a name" do
         @product = Product.create(name: nil, price: 1,
                                quantity: 1, category: @category)
         expect(@product).to_not be_valid
         expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "must have price" do
         @product = Product.create(name: "Big Chair", price: nil,
                                quantity: 1, category: @category)
         expect(@product).to_not be_valid
         expect(@product.errors.full_messages).to include("Price can't be blank")
    end

     it "must have a quantity" do
         @product = Product.create(name: "Big Chair", price: 1,
                                quantity: nil, category: @category)
         expect(@product).to_not be_valid
         expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

      it "must have a category" do
         @product = Product.create(name: "Big Chair", price: 1,
                                quantity: 1, category: nil)
         expect(@product).to_not be_valid
         expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end

end