@mockapitest
Feature: Test User API using Karate Mock Server

  Background:
    * url 'http://localhost:8081'
    * header Content-Type = 'application/json'

  @userCRUDusingMockServer
  Scenario: Create, Get and Delete User

    # Create User
    Given path 'users'
    And request
    """
    {
      "name": "Vijay",
      "email": "vijay@test.com"
    }
    """
    When method POST
    Then status 201
    And match response.id == 101

    # Get User
    Given path 'users', 101
    When method GET
    Then status 200
    And match response.name == 'Vijay'

    # Delete User
    Given path 'users', 101
    When method DELETE
    Then status 204
