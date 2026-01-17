Feature: Test Base64 Encode/Decode

#  Base64 is NOT encryption.It is encoding, used for safe data transport.
#  Some systems cannot safely handle binary data (images, files, certificates, tokens).
#  Base64 converts binary → readable ASCII text so it can travel safely.

  Background:
    * url 'http://localhost:8081'
    * header Content-Type = 'application/json'

# ---------------- ENCODE TEST ----------------
  @base64EncodeTest
  Scenario: Verify Base64 Encode API
    Given path '/base64/encode'
    And request { "data": "Hello Karate" }
    When method POST
    Then status 200

    * print response
    * match response.original == 'Hello Karate'
    * match response.encoded == 'SGVsbG8gS2FyYXRl'

# ---------------- DECODE TEST ----------------
  @base64DecodeTest
  Scenario: Verify Base64 Decode API
    Given path '/base64/decode'
    And request { "data": "SGVsbG8gS2FyYXRl" }
    When method POST
    Then status 200

    * print response
    * match response.encoded == 'SGVsbG8gS2FyYXRl'
    * match response.decoded == 'Hello Karate'