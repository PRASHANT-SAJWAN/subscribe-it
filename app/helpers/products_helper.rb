module ProductsHelper
  def add_product_to_user(current_user, product_id)
    @checkout_session = start_checkout_session([product_id])

    @stripe_customer = fetch_or_create_stripe_customer(current_user)

    updated_product_ids = current_user.product_ids + [product_id]
    User.find(current_user.id).update!(product_ids: updated_product_ids)

    @line_items = Stripe::Checkout::Session.list_line_items(@checkout_session.id)

    end_checkout_session(@checkout_session.id)
  end

  def start_checkout_session product_ids
    mode = 'payment' # get it from UI
    # mode = 'subscription'
    # mode = 'setup'
    Stripe::Checkout::Session.create({
      success_url: 'http://localhost:3000/success',
      cancel_url: 'http://localhost:3000//products',
      line_items: product_ids.map {
        |product_id| {
          price: Product.fetch_stripe_product(product_id),
          quantity: 1,
        }
      },
      mode: mode,
    })
  end

  def end_checkout_session checkout_session_id
    Stripe::Checkout::Session.expire(checkout_session_id)
  end

  def fetch_or_create_stripe_customer current_user
    return Stripe::Customer.retrieve(current_user.stripe_customer_id) unless current_user.stripe_customer_id.nil?

    stripe_customer = Stripe::Customer.create(name: current_user.name)
    User.find(current_user.id).update!(stripe_customer_id: stripe_customer.id)

    stripe_customer
  end
end
