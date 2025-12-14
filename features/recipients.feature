Feature: View, Create, Edit Recipients
  Background:
    Given I am logged in
    Given the test event exists

    Scenario:  View all my recipients
      When I visit the recipients page
      Then I should see "Recipients"

    Scenario: Create a recipient
      When I visit the new recipient page
      And I fill in "Name" with "sample"
      And I fill in "Age" with "21"
      And I fill in "Occupation" with "developer"
      And I fill in "Budget" with "0"
      And I press "Create"
      Then I should see "sample was successfully created."

     Scenario: Edit a recipient info
       Given a recipient named "bob"
       When I visit the edit page for "bob"
       And I fill in "Age" with "21"
       And I press "submit"
       Then I should see "bob was successfully updated."

    Scenario: Delete a recipient
      Given the test recipient exists
      When I click View all events
      When I click More about test event
      When I click view recipient
      Then I should see "view recipient"
      When I press "Delete"
      Then I should see "test was removed"

