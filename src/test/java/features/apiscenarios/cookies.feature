Feature: Verify cookies from httpbin

  Background:
    # Base URL for httpbin
    * url 'https://httpbin.org'


@cookieTest
Scenario: Verify cookies sent to the server
      Given path 'cookies'
      And cookie myCookie = 'karate123'
      And cookie theme = 'dark'
      When method get
      Then status 200

      And match response.cookies.myCookie == 'karate123'
      And match response.cookies.theme == 'dark'