Feature: I can add and remove friends

  Background: I am logged in
    Given the test user logs in
    Then I should see Welcome, capybara

    Given I have pending friend requests
    And I click Friends
    Then I should see friend requests
    And I should see accept or decline


  Scenario:
    Given I have no friends
    When I accept the friend request
    Then I should see the friend
