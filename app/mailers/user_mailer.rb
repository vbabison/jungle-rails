class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  #sends order in an email with HTML format
  def order_email(order)
    @order = order
    @lineitems = Product.joins(:line_items).where('line_items.order_id' => order.id).select('products.name, line_items.quantity, line_items.item_price_cents, line_items.total_price_cents')
    @products = @lineitems.to_a

    mail(to: @order.email, subject: "Jungle Order ID: #{@order.id}")
  end

end