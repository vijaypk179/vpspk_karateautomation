# Karate Template

Refer to the [Getting Started Guide](https://github.com/karatelabs/karate/wiki/Get-Started:-Maven-and-Gradle#github-template) for instructions.

To Run Jenkins in 8080 port:
java -jar jenkins.war


# Karate Template

This repository demonstrates API testing using the Karate Framework. Below is a detailed explanation of the test annotations used in this framework and the corresponding API endpoints.

---

## **Annotations and Test Scenarios**

### 1. `@mockapitest`
- **Description**: This annotation is used for scenarios that test the mock server functionality.
- **Example**:
    - **Scenario**: Create, Get, and Delete User
    - **API Endpoint**: `http://localhost:8081/users`
    - **Details**:
        - **POST**: Creates a user with the provided details.
        - **GET**: Retrieves the user details by ID.
        - **DELETE**: Deletes the user by ID.

---

### 2. `@fileDownloadTest`
- **Description**: This annotation is used for scenarios that test file download functionality.
- **Example**:
    - **Scenario**: Download file and validate response
    - **API Endpoint**: `http://localhost:8081/download`
    - **Details**:
        - **GET**: Downloads a file and validates its content.

---

### 3. `@apiversioning`
- **Description**: This annotation is used for scenarios that test API versioning.
- **Example**:
    - **Scenario**: Verify v1 API response
    - **API Endpoint**: `http://localhost:8081/api/v1/users`
    - **Details**:
        - **GET**: Retrieves user details for version 1 of the API.
    - **Scenario**: Verify v2 API response
    - **API Endpoint**: `http://localhost:8081/api/v2/users`
    - **Details**:
        - **GET**: Retrieves user details for version 2 of the API.

---

### 4. `@userSortingbyNameascending`
- **Description**: This annotation is used for scenarios that test sorting functionality in ascending order.
- **Example**:
    - **Scenario**: Verify ascending sort
    - **API Endpoint**: `http://localhost:8081/api/users?sort=asc`
    - **Details**:
        - **GET**: Retrieves a list of users sorted by name in ascending order.

---

### 5. `@userSortingbyNamedescending`
- **Description**: This annotation is used for scenarios that test sorting functionality in descending order.
- **Example**:
    - **Scenario**: Verify descending sort
    - **API Endpoint**: `http://localhost:8081/api/users?sort=desc`
    - **Details**:
        - **GET**: Retrieves a list of users sorted by name in descending order.

---

### 6. `@getAPIwithQueryParam`
- **Description**: This annotation is used for scenarios that test API endpoints with query parameters.
- **Example**:
    - **Scenario**: Get objects by IDs via query params
    - **API Endpoint**: `https://api.restful-api.dev/objects`
    - **Details**:
        - **GET**: Retrieves objects by passing multiple `id` query parameters.

---

### 7. `@getAPIwithOffsetLimit`
- **Description**: This annotation is used for scenarios that test pagination using offset and limit query parameters.
- **Example**:
    - **Scenario**: Get products with offset and limit
    - **API Endpoint**: `https://api.escuelajs.co/api/v1/products`
    - **Details**:
        - **GET**: Retrieves a paginated list of products using `offset` and `limit` query parameters.

---

## **How to Run the Tests**

1. **Start the Mock Server**:
   ```bash
   mvn exec:java -Dexec.mainClass=MockServerRunner
---
**Overview**

    1.Clones the Karate automation project from GitHub
    
    2.Builds the project using Maven
    
    3.Executes Karate tests based on a tag parameter
    
    4.Publishes Karate HTML reports
    
    5.Sends email notification after job completion

🛠 Prerequisites

Before running this pipeline, ensure:

    1.Jenkins is installed and running
    
    2.Maven is configured in Jenkins as a global tool named Maven
    
    3.Java (JDK 8 or above) is installed
    
    4.Jenkins plugins installed:
    
    5.Git
    
    6.HTML Publisher
    
    7.Email Extension Plugin

Pipeline Stages

1 ️ Checkout

    Clones the repository from GitHub
    
    Uses branch: scenario4

2 Build

    Cleans and builds the project
    
    Skips test execution during build

    mvn clean install -DskipTests

3 Test

    Executes Karate tests using TestRunner
    
    Runs only scenarios matching the provided tag
    
    mvn clean test -Dtest=TestRunner -Dkarate.options="--tags @tagName"