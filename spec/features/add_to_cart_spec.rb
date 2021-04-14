require 'rails_helper'

RSpec.feature "Visitor adds item to cart", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    1.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Cart changes from (0) to (1)" do
    visit root_path
    click_button('Add')
    # commented out b/c it's for debugging only
    # save_and_open_screenshot
    
    expect(page).to have_selector('a[href="/cart"]', text: 'My Cart (1)')
  end
end
