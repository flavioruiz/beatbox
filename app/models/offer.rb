class Offer < ActiveRecord::Base
  belongs_to(:user)
  has_many(:locations, :class_name => 'OfferLocation', :dependent => :destroy)

  class Album < Offer
  end
end
