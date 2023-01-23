class ProductsController < ApplicationController
  before_action :require_login

  def index
    @products = Product.all
  end

  def purchase
    product_id = params[:id].to_i
    return if current_user.blank? || current_user.product_ids.include?(product_id) || product_id.blank?

    # redirect_to ''
    helpers.add_product_to_user(current_user, product_id)
  end

  private

  def require_login
    redirect_to '/login' unless current_user.present?
  end
end 
