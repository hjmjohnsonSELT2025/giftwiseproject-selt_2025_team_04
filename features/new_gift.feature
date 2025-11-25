Feature: I can add gifts to the database

  Background: I am logged in
    Given the test user logs in
    Given the test recipient exists
    Then I should see Welcome, capybara

  Scenario:
    When I click Add a new gift
    When I submit my gift info
    Then I should see the new gift details page

  Scenario:
    When I click Add a new gift
    When I submit bad gift info
    Then I should see an error message
