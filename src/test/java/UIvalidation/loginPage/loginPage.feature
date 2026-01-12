Feature: Login Page Actions

  Background: open login page
    * driver baseUrl

  @uiloginPageValidation
  Scenario: login with credentials
    * def page = read('classpath:UIvalidation/pageObject/commonObjects.json')

    * input(page.username, "standard_user")
    * input(page.password, "secret_sauce")
    * click(page.loginButton)
    * screenshot('loginPage')