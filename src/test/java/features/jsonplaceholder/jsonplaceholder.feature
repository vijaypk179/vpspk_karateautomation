Feature: sample karate test script
  for help, see: https://github.com/karatelabs/karate/wiki/IDE-Support

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  @getUser
  Scenario: get all users and then get the first user by id
    Given path 'users'
    When method get
    Then status 200

    * def first = response[0]

    Given path 'users', first.id
    When method get
    Then status 200
    * karate.embed(response, 'text/plain')

  @createAndGetUser
  Scenario: create a user and then get it by id
    * def user =
      """
      {
        "name": "Test User",
        "username": "testuser",
        "email": "test@user.com",
        "address": {
          "street": "Has No Name",
          "suite": "Apt. 123",
          "city": "Electri",
          "zipcode": "54321-6789"
        }
      }
      """

    Given url 'https://jsonplaceholder.typicode.com/users'
    And request user
    When method post
    Then status 201

    * def id = response.id
    * print 'created id is: ', id

    Given path id
    When method get
    Then status 200
    And match response contains user
    * karate.embed(response, 'text/plain')

  @createAndDeleteUser
  Scenario: Create, Delete and Verify User
    # 1️⃣ Create new user
    Given path 'users'
    And request
    """
    {
      "name": "Vijay Test",
      "username": "vijaytest",
      "email": "vijay@test.com"
    }
    """
    When method POST
    Then status 201

    # capture created user id
    * def userId = response.id
    * print 'Created User ID:', userId

    # 2️⃣ Delete the user
    Given path 'users', userId
    When method DELETE
    Then status 200

    # 3️⃣ Verify deleted user
    Given path 'users', userId
    When method GET
    Then status 404
    * karate.embed(response, 'text/plain')

  @createAndUpdateUser
  Scenario: Create, Update (PUT), and Partial Update (PATCH) Post

    # 1️⃣ POST /posts - Create new post
    Given path 'posts'
    And request
    """
    {
      "title": "Karate API Test",
      "body": "This is a post created using Karate",
      "userId": 1
    }
    """
    When method POST
    Then status 201
    And match response.title == "Karate API Test"
    And match response.userId == 1

    * def postId = response.id
    * print 'Created Post ID:', postId


    # 2️⃣ PUT /posts/1 - Full update
    Given path 'posts', 1
    And request
    """
    {
      "id": 1,
      "title": "Updated Title via PUT",
      "body": "Updated body via PUT",
      "userId": 1
    }
    """
    When method PUT
    Then status 200
    And match response.title == "Updated Title via PUT"
    And match response.body == "Updated body via PUT"


    # 3️⃣ PATCH /posts/1 - Partial update
    Given path 'posts', 1
    And request
    """
    {
      "title": "Partially Updated Title"
    }
    """
    When method PATCH
    Then status 200
    And match response.title == "Partially Updated Title"
    * karate.embed(response, 'text/plain')