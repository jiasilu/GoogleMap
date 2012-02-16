Feature: Sign up to be a member of GOOD Culture Map

  As a visitor to culture map
  I want to sign up and login
  So I can keep records my places on it
  
  Scenario: user sign up with invalid information
     Given I visit <new user> page
     When I enter <invalid username> in <Username>
     When I enter <invalid email> in <Email>
     When I enter <password> in <Password>
     When I enter <verify password> in <Password confirmation>
     When I click on <Create User>
     Then I should see <Registration fails!>
  
  Scenario: user sign up with valid information
      Given I visit <new user> page
      When I enter <Silu Jia> in <Username>
      When I enter <justin@goodinc.com> in <Email>
      When I enter <123456> in <Password>
      When I enter <123456> in <Password confirmation>
      When I click on <Create User>
      Then I should see <Registration success!>
      And An activation email should be sent to <justin@goodinc.com>
  
  Scenario: user activate account
      Given I register with <silu/justin@goodinc.com/password>
      When I visit the activation link in the <justin@goodinc.com>
      Then I should see <Activation success!>