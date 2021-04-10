require 'rails_helper'

RSpec.feature "Navigate home page to product detail page", type: :feature do

    before :each do
    @category = Category.create! name: 'Apparel'

    1.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 5,
        price: 54.99
      )
    end
  end



  scenario "Can click a on link to prodcut details" do
    visit products_path

    click_link "Details", match: :first

    expect(page).to have_css 'section.products-show'
  end




  #hope page specs
    scenario "They see all products" do
      visit root_path
      expect(page).to have_css 'article.product', count: 1
  end


end