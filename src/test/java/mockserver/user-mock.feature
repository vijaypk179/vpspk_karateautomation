Feature: User Mock Server

Background:
  * def filePath = 'classpath:resources/sample.txt'
  * configure cors = true


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

  Scenario: pathMatches('/api/v1/users') && methodIs('get')
    * def response =
    """
    {
      "version": "v1",
      "users": [
        { "id": 1, "name": "Vijay" }
      ]
    }
    """
    * def status = 200

  Scenario: pathMatches('/api/v2/users') && methodIs('get')
    * def response =
    """
    {
      "version": "v2",
      "users": [
        { "id": 1, "firstName": "Vijay", "lastName": "Pandi" }
      ],
      "meta": {
        "count": 1
      }
    }
    """
    * def status = 200

  Scenario: pathMatches('/api/users') && methodIs('get')
    * def users =
    """
    [
      { "id": 3, "name": "Karthik" },
      { "id": 1, "name": "Arun" },
      { "id": 2, "name": "Vijay" },
      { "id": 5, "name": "Jane" },
      { "id": 4, "name": "Zack" }
    ]
    """

    * def sort = requestParams.sort

    * if (sort == 'asc') users.sort((a, b) => a.name.localeCompare(b.name))
    * if (sort == 'desc') users.sort((a, b) => b.name.localeCompare(a.name))

    * def response = users
    * def status = 200