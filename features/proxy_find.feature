Feature: Find Proxy
  Background: 
    Given a client exists

  Scenario: Calling the find method should return a proxy
    When I call the #find method on a client
    Then I should receive a ChainGang::Proxy instance
