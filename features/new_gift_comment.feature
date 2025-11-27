Feature: I can leave comments on gifts

  Background: I am logged in
    Given the test user logs in
    Given the test recipient exists
    Then I should see Welcome, capybara

  Scenario: I can leave comments on a gift
    When I click Add a new gift
    When I submit my gift info
    When I click Leave a new comment
    When I submit my comment info
    Then I should see the new comment on the gift details page
