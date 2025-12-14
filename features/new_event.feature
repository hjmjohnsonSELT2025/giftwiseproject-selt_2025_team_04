Feature: I can add events to the database

  Background: I am logged in
    Given the test user logs in:
    Then I should see Welcome, capybara

  Scenario:
    When I click Events
    When I click Add New Event
    When I submit my event info
    Then I should see the new event on the home page
