from behave import given, when, then
from tests.pageobjects.password import PasswordPageObject
from nose.tools import assert_in, assert_equal, assert_true, assert_false

@given('goto page of change')
def step_impl(context):
    context.current_page = PasswordPageObject()
    context.current_page.open().waitToDrawSection().setElements()

@given  ('select language "{langugeId}"')
def step_impl(context, langugeId):
    context.current_page.setLanguage(langugeId).waitToDrawSection()

@when('set credentials of "{userId}"')
def step_impl(context, userId):
    credential = context.current_page.getConfigSection(userId)
    context.current_page.credential = credential
    context.current_page.username.text = credential['username']
    context.current_page.password.text = credential['password']

@when('set new password to "{value}"')
def step_impl(context, value):
    context.current_page.newPassword = value
    context.current_page.passwordA.text = value
    context.current_page.passwordB.text = value

@when('send request')
def step_impl(context):
    assert_false(context.current_page.fornIsInvalid(), "Form is invalid, new password is invalid")
    if context.current_page.fornIsInvalid() is False:
        context.current_page.saveBtn.click()
        context.current_page.waitToServerResponse()

@when('send 4 request')
def step_impl(context):
    username = context.current_page.username.text
    password = context.current_page.password.text
    passwordA = context.current_page.passwordA.text
    passwordB = context.current_page.passwordB.text
    context.current_page.clearBtn.click()
    context.execute_steps(u'When save user (%s, %s, %s, %s)' % (username, password, passwordA, passwordB))
    context.current_page.waitToSendRequestAndActiveOkBoton()
    context.current_page.saveBtn.click()
    context.execute_steps(u'When save user (%s, %s, %s, %s)' % (username, password, passwordA, passwordB))
    context.current_page.waitToSendRequestAndActiveOkBoton()
    context.current_page.saveBtn.click()
    context.execute_steps(u'When save user (%s, %s, %s, %s)' % (username, password, passwordA, passwordB))
    context.current_page.waitToSendRequestAndActiveOkBoton()
    context.current_page.saveBtn.click()
    context.execute_steps(u'When save user (%s, %s, %s, %s)' % (username, password, passwordA, passwordB))

@when('save user ({username}, {password}, {newPassword}, {newPasswordCopy})')
def step_impl(context, username, password, newPassword, newPasswordCopy):
    context.current_page.username.text = username
    context.current_page.password.text = password
    context.current_page.passwordA.text = newPassword
    context.current_page.passwordB.text = newPasswordCopy
    context.execute_steps(u'When send request')

@when('set "{property}" to "{value}"')
def step_impl(context, property, value):
    getattr(context.current_page, property).text = value

@then('before exit set original password')
def step_impl(context):
    credential = context.current_page.credential
    newPassword = context.current_page.newPassword
    context.current_page.waitToSendRequestAndActiveOkBoton()
    # show and reset form (use same button of save)
    context.current_page.saveBtn.click()
    context.execute_steps(u'When set "username" to "%s"' % (credential['username']))
    context.execute_steps(u'When set "password" to "%s"' % (newPassword))
    context.execute_steps(u'When set new password to "%s"' % (credential['password']))
    context.execute_steps(u'When send request')
    context.execute_steps(u'Then LDAP node "Gbl" is ok')

@then('LDAP node "{nodeId}" has error')
def step_impl(context, nodeId):
    assert_true(context.current_page.nodeHasError(nodeId), "Node %s don't have error")

@then('LDAP node "{nodeId}" is ok')
def step_impl(context, nodeId):
    assert_false(context.current_page.nodeHasError(nodeId))

@then('PasswordA is valid')
def step_impl(context):
    assert_false(context.current_page.newPasswordHasError())

@then('PasswordA is invalid')
def step_impl(context):
    assert_true(context.current_page.newPasswordHasError())

@then('PasswordB is invalid')
def step_impl(context):
    assert_true(context.current_page.newPasswordCopyHasError())

@then('message in node "{nodeId}" contain "{message}')
def step_impl(context, nodeId, message):
    messageResponse = context.current_page.getMessageOfNode(nodeId) + ''
    assert_true(message in messageResponse, u'orignal message is `%s`' % messageResponse)