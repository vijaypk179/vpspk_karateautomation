Feature: User Mock Server

Background:
* def filePath = 'classpath:resources/sample.txt'


  Scenario: pathMatches('/users') && methodIs('post')
    * def response =
    """
    {
      "id": 101,
      "name": "#(request.name)",
      "email": "#(request.email)"
    }
    """
    * def responseStatus = 201

  Scenario: pathMatches('/users/101') && methodIs('get')
    * def response =
    """
    {
      "id": 101,
      "name": "Vijay",
      "email": "vijay@test.com"
    }
    """
    * def responseStatus = 200

  Scenario: pathMatches('/users/101') && methodIs('delete')
    * def responseStatus = 204

  Scenario: pathMatches('/download') && methodIs('get')
    # Path to the actual file in your repository
    * def fileInRepo = read('classpath:resources/sample.txt')

   # 1. Set the response body to the file content
    * def response = fileInRepo

  # 2. Set headers to force a download
    * def responseHeaders = { 'Content-Disposition': 'attachment; filename="downloaded.txt"', 'Content-Type': 'text/plain' }

  # 3. Return Success
    * def responseStatus = 200
