Feature: I can leave comments on gifts

  Background: I am logged in
    Given the test user logs in
    Given the test event exists
    Given the test recipient exists
    Given the test gift exists
    Then I should see Welcome, capybara

  Scenario: I can leave comments on a gift
    When I click Gifts
    When I click View
    Then I should see "test"
    When I click Add Comment
    When I submit my comment info
    Then I should see the new comment on the gift details page
