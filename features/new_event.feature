Feature: I can add events to the database

  Background: I am logged in
    Given the test user logs in:

  Scenario:
    When I click Add new event
    When I submit my event info
    Then I should see the new event on the home page
