class OffersController < ApplicationController
  before_filter(:require_user)

  def index
    @offers = current_user.offers
  end

  def update
    @offer = current_user.offers.find(params[:id])
    @offer.update_attributes(params[:offer_album])

    curids   = Array(params[:locations]).map(&:to_i)
    toremove = @offer.locations.map(&:id) - curids
    @offer.locations.find(toremove).each(&:delete)

    Array(params[:lnew]).each do |lnew|
      @offer.locations.create(lnew)
    end
    redirect_to(offer_url(@offer))
  end

  def show
    @offer = current_user.offers.find(params[:id])
  end

  def destroy
    offer = current_user.offers.find(params[:id])
    current_user.offers.delete(offer) if offer
    redirect_to(offers_url)
  end

  def create
    @offer = current_user.offers.build(params[:offer_album])
    if @offer.save
      Array(params[:lnew]).each do |lnew|
        @offer.locations.create(lnew)
      end
      redirect_to(offer_url(@offer))
    else
      render(:action => :new)
    end
  end

  def new
    @offer = current_user.offers.build
  end
end
