Feature: File upload API test using multipart/form-data

  Background:
    * url 'https://api.escuelajs.co/api/v1'
    * configure charset = null

  @postfileupload
  Scenario: Upload a file successfully
    Given path 'files', 'upload'
    And multipart file file = { read: 'classpath:resources/sample.png', filename: 'sample.png', contentType: 'image/png' }
    When method POST
    Then status 201
    And match response.location contains 'https://'
    * print response