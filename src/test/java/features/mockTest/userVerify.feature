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

  @fileDownloadTest
  Scenario: Download file and validate response
    Given path 'download'
    When method get
    Then status 200

  # Check that the content matches what we expect
    * match response == read('classpath:resources/sample.txt')

    # Save it to target folder to see it physically
    * karate.write(response, 'actual-download.txt')

  @apiversioning
  Scenario: Verify v1 API response
    Given path 'api', 'v1', 'users'
    When method get
    Then status 200
    And match response.version == 'v1'
    And match response.users[0].name == 'Vijay'
    And match response.users[0] !contains { firstName: '#string' }

  @apiversioning
  Scenario: Verify v2 API response
    Given path 'api', 'v2', 'users'
    When method get
    Then status 200
    And match response.version == 'v2'
    And match response.users[0].firstName == 'Vijay'
    And match response.users[0].lastName == 'Pandi'
    And match response.meta.count == 1


