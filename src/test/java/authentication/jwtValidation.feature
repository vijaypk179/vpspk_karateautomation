Feature: Login and access profile using JWT token

  Background:
    * url 'https://api.escuelajs.co/api/v1'
    * header Content-Type = 'application/json'

  @jwthappypath
  Scenario: Login and fetch user profile using JWT

  # ---- Login ----
    Given path 'auth/login'
    And request
    """
    {
      "email": "john@mail.com",
      "password": "changeme"
    }
    """
    When method post
    Then status 201

  # Capture JWT tokens
    * def accessToken = response.access_token
    * def refreshToken = response.refresh_token

  # Validate tokens
    And match accessToken != null
    And match refreshToken != null

  # ---- Get Profile ----
    Given path 'auth/profile'
    And header Authorization = 'Bearer ' + accessToken
    When method get
    Then status 200

  # Basic validations
    And match response.id == 1
    And match response.email == 'john@mail.com'
