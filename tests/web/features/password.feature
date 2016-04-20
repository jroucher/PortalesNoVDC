Feature: Password change

  @VDCPORTALS-130
  Scenario: Validate new password - invalid password length
    Given goto page of change
     When set "passwordA" to "pas12"
     Then PasswordA is invalid

  @VDCPORTALS-131
  Scenario: Validate new password - invalid character : '#'
    Given goto page of change
     When set "passwordA" to "pass#wordA"
     Then PasswordA is invalid

  Scenario: Validate new password - password is not equal
    Given goto page of change
     When set "passwordA" to "passwordA"
      And set "passwordB" to "passwordB"
     Then PasswordB is invalid

  @VDCPORTALS-131
  Scenario: Validate new password - Acept alphanumeric characters and `@` and `!`
    Given goto page of change
     When set "passwordA" to "Password1@"
     Then PasswordA is valid

  @VDCPORTALS-75
  Scenario: User is invalid
    Given goto page of change
      And select language "es"
     When set "username" to "QAUserMock"
      And set "password" to "Passw0rdMock"
      And set new password to "Passw0rd1"
      And send request
     Then LDAP node "Gbl" has error
      But message in node "Gbl" contain "Usuario o contraseña no válidos"

  Scenario: Original password is invalid
    Given goto page of change
      And select language "es"
     When set credentials of "UserA"
      And set "password" to "Passw0rdMock"
      And set new password to "Passw0rd1"
      And send request
     Then LDAP node "Gbl" has error
      But message in node "Gbl" contain "Usuario o contraseña no válidos"

  @VDCPORTALS-125
  Scenario: Password is changed
    Given goto page of change
     When set credentials of "UserA"
      And set new password to "Passw0rd1"
      And send request
     Then LDAP node "Gbl" is ok
      But before exit set original password

  @VDCPORTALS-78
  Scenario: User exceeded limit of try
    Given goto page of change
      And select language "es"
     When set credentials of "UserC"
      And set "password" to "Passw0rdMock"
      And set new password to "Passw0rd1"
      And send 4 request
     Then LDAP node "Gbl" has error
      But message in node "Gbl" contain "total de intentos ha superado el máximo permitido"