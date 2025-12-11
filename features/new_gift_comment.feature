Feature: I can leave comments on gifts

  Background: I am logged in
    Given the test user logs in
    Given the test event exists
    Given the test recipient exists
    Then I should see Welcome, capybara

  Scenario: I can leave comments on a gift
    When I click View all events
    When I click More about test event
    When I click add a new gift for test
    When I submit my gift info
    When I click Leave a new comment
    When I submit my comment info
    Then I should see the new comment on the gift details page
