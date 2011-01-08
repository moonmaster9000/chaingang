Given /^a client exists$/ do
  class Client < ActiveResource::Base
    self.site = ''
    include ChainGang
  end
end

When /^I call the \#find method on a client$/ do
  @finder = Client.find
end

Then /^I should receive a ChainGang::Proxy instance$/ do
end
