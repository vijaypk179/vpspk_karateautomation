Feature: Test query param endpoint

  Background:
    # Base URL (change if needed)
    * url 'https://api.restful-api.dev'

  @getAPIwithQueryParam
  Scenario Outline: Get objects by IDs via query params
    Given path 'objects'
    And param id = <id1>
    And param id = <id2>
    And param id = <id3>
    When method GET
    Then status 200
    And match response == '#array'
    * print 'Response for ids:', <id1>, <id2>, <id3>

    Examples:
      | id1 | id2 | id3 |
      | 3   | 5   | 10  |
      | 1   | 2   | 4   |
      | 7   | 8   | 9   |

  @getAPIwithOffsetLimit
  Scenario Outline: Get products with offset <offset> and limit <limit>
    * url 'https://api.escuelajs.co/api/v1/'
    Given path 'products'
    And param offset = <offset>
    And param limit = <limit>
    When method GET
    Then status 200
    And match response == '#[]'
    And assert response.length <= <limit>

    Examples:
      | offset | limit |
      | 0      | 5     |
      | 0      | 10    |
      | 5      | 5     |
      | 10     | 10    |
      | 20     | 5     |