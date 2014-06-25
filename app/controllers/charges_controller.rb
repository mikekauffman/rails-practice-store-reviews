class ChargesController < ApplicationController
  def new
  end

  def create
    @amount = 500

    begin
      customer = Stripe::Customer.create(
        :email => SecureRandom.uuid,
        :card => params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        :customer => customer.id,
        :amount => @amount,
        :description => 'Rails Stripe customer',
        :currency => 'usd'
      )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to charges_path
    end

    def cart_total(items)
      total = 0
      items.each do |item|
        total += item.product.hardcover_price_in_cents
      end
      total
    end
  end
end
