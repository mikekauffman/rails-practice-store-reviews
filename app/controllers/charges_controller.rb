
class ChargesController < ApplicationController
  def new
  end


  def create
    @amount = session[:total]

    begin
      customer = Stripe::Customer.create(
        :email => SecureRandom.uuid,
        :card => params[:stripeToken]
      )
      charge = Stripe::Charge.create(
        :customer => customer.id,
        :amount => price_to_cents(@amount),
        :description => 'Rails Stripe customer',
        :currency => 'usd'
      )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to "/"
      raise StripeError, e[:message]
    rescue Stripe::StripeError
      redirect_to "/"
    end
  end

  def cart_total(items)
    total = 0
    items.each do |item|
      total += item.product.hardcover_price_in_cents
    end
    total
  end
end