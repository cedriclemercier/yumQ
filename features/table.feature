Feature:  Sit at a table

In order to sit at a table, a restaurant need to exist and a table to be free

Scenario: Sit at a table

    A User should be able to create a new restaurant

    Given I am logged in
    When I create a new restaurant
    When I visit the restaurant page
    Then I create a new table and a queue and set myself to a table
