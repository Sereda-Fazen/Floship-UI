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
    Wait Until Page Contains Element       xpath=//h3[contains(.,"Login")]
    Input Text                          ${login_email}               ${login_admin}
    Input Text                          ${login_pass}                ${pass_admin}
    Click Element                       ${Signup}
    Wait Until Page Contains            Dashboard