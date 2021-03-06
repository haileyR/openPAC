class DonationsController < ApplicationController
  include AuthsHelper

  def show
    if request.xhr?
      render partial: "/donations/table", locals: {donations: current_user.donations}
    else
      @donations = current_user.donations
    end
  end

  def create
    redirect_to :login unless logged_in?
    amount = params[:donation]["amount"].to_i * 100
    token = params[:stripeToken]

    @charge = Stripe::Charge.create(
      :amount => amount,
      :currency => "usd",
      :card => token,
      :description => "something about your customer"
    )

    Donation.create_records(params)
  end

  def new
    redirect_to :login unless logged_in?
    @stance = Stance.find(params[:stance_id])
    @legislators = @stance.legislators
    @legislator_ids = @stance.legislators.map{|l|l.id}
  end

  private
    def donation_params
      params.require(:donation).permit(:amount)
    end
end
