*** Settings ***
Documentation                           FloShip UI testing
Resource                                resource.robot
Suite Setup                             Setup Tests
Test Teardown                           Delete All Cookies
Suite Teardown                          Close All Browsers

*** Test Cases ***
TC195 - Login in Admin Panel (valid)
    [Tags]                               Login
    ${email}=                          Get Email
    Set Suite Variable                  ${REG_EMAIL}                ${email}
    Login                               ${login_admin}        ${pass_admin}
    Wait Until Page Contains            Dashboard