Feature: can view upcoming reminders

  Scenario: basic reminder with future send time valid
    Then pending reminder with a future send time should be valid

  Scenario: reminder without send time is invalid
    Then reminder without send_at should be invalid


#Feature: can view upcoming reminders

 # Background: on the upcoming reminders page
  #  Given I am on the upcoming reminders page

  #Scenario: see upcoming reminders
   # Then I should see "Upcoming Reminders"
    #And I should see "No reminders yet."

  #Scenario: create a new reminder
   # When I go to the new reminder page
    #And I press the save reminder button
    #Then I should be on the upcoming reminders page
    #And I should see "Reminder saved"

#Future!! i got too eager
#"Feature: can view upcoming reminders

  #"Background: reminders added to database

    #'Given the following reminders exist:

  #    | send_at             | status  | channel |
  #    | 2025-12-10 08:00:00 | pending | in_app |
  #    | 2025-12-01 08:00:00 | pending | in_app |
  #    | 2025-10-31 08:00:00 | sent    | in_app |

    #'And I am on the upcoming reminders page

 # Scenario: see only pending future reminders
  #  When I am on the upcoming reminders page
 #   Then I should see "2025-12-01" before "2025-12-10" in the reminders list
   # And I should not see "2025-10-31" in the reminders list

  #Scenario: create a new reminder
  #  When I create a new reminder
  #  And I select 2025 as the year
  #  And I select December as the "reminder_send_at_2i" month
 #   And I select the 10th as the day
 #   And I press "Save reminder"
  #  Then I should be on the upcoming reminders page
  #  And I should see "Reminder saved"
  #  And I should see "2025-12-10" in the reminders list"