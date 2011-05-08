class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.validate_login_field = false
  end
  has_many(:offers, :class_name => "Offer::Album", :dependent => :destroy)
end
