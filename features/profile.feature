Feature: I can set profile information
  Background: I am logged in and on profile page
    Given the test user logs in
    And I enter the profile page
    Then I should see Profile

  Scenario: I can update my information
    When I click Edit
    And I enter my name
    And I change my pronouns
    And I enter my job
    And I enter my age
    And I enter my likes
    And I enter my dislikes
    And I update my profile
    Then I should see my changes
