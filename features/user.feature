Feature:  Recipe

In order to use the features of the app, as a user, I want to be able to create restaurants, add user as staff and create new menus

Scenario: Create a new recipe

    A User should be able to create a new restaurant

    Given I am a user
    And I am signed in
    And I see manage restaurants button
    When I visit the manage restaurant section
    Then I should see a link to create a restaurant
    When I click the link to create a restaurant
    Then I should see the the form details to create it
    When I submit the form
    Then I should see the details of my restaurant
