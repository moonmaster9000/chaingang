$LOAD_PATH.unshift './lib'
require 'chaingang'
require 'dupe'

class Client < ActiveResource::Base
  self.site = 'http://localhost'
  include ChainGang
end

Dupe.define :client do |attrs|
  attrs.name 'test'
end
