require 'rubygems'
require 'httparty'

module Beatmap
module Site

class Base

  def self.inherited(klass)
    klass.class_eval do
      include HTTParty
    end
  end

  def initialize(config={})
    @config = config
  end
end

end
end