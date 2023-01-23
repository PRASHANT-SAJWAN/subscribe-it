class CheckoutController < ApplicationController
  def create
    product = Product.find(params[:id])

    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        name: product.name,
        amount: 100,
        currency: "inr",
        quantity: 1,
      }],
      mode: 'payment',
      success_url: root_url,
      cancel_url: root_url,
    })

    redirect_to @session.url, allow_other_host: true
  end
end