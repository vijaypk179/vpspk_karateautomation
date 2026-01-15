@ouathtesting
Feature: GitHub OAuth API Automation

  Background:
    * url 'https://api.github.com'
    * header Authorization = 'Bearer ' + githubToken
    * header Accept = 'application/vnd.github+json'

  Scenario: Get authenticated user details
    Given path 'user'
    When method GET
    Then status 200
    And match response.login != null