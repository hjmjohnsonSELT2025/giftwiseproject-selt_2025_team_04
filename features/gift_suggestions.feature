Feature: display list of gift suggestions

  Background: on the gift suggestions page
    Given I am on the gift suggestions page

  Scenario: create a new gift suggestion
    When I follow create new gift suggestion
    And I press "Save gift suggestion"
    Then I should be on the gift suggestions page
