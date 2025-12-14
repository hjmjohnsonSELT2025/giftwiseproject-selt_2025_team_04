Feature: View, Create, Edit Recipients
  Background:
    Given I am logged in
    Given the test event exists
    Given the test recipient exists

    Scenario:  View all my recipients
      When I visit the recipients page
      Then I should see "Recipients"

    Scenario: Create a recipient
      When I visit the new recipient page
      And I fill in "Name" with "sample"
      And I fill in "Age" with "21"
      And I fill in "Occupation" with "developer"
      And I fill in "Budget" with "0"
      And I press Create Recipient
      Then I should see "sample was successfully created."

     Scenario: Edit a recipient info
       Given a recipient named "bob"
       When I visit the edit page for "bob"
       And I fill in "Age" with "21"
       And I press Update Recipient
       Then I should see "bob was successfully updated."

    Scenario: Remove a recipient
      When I visit the recipients page
      When I click View
      And I press Delete
      Then I should see "test was removed"

    Scenario: Search for recipient by name
      Given a recipient named "bob"
      When I visit the recipients page
      And I fill in "query" with "bob"
      And I press Search
      Then I should see "bob"
