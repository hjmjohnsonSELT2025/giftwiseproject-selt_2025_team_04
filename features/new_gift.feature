Feature: I can add gifts to the database

  Background: I am logged in
    Given the test user logs in:
    Then I should see the welcome message

  Scenario:
    When I click Create a new gift
    When I submit my gift info
    Then I should see the new gift on the home page

  Scenario:
    When I click Create a new gift
    When I submit bad gift info
    Then I should see an error message