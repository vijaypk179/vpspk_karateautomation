Feature: User Mock Server

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