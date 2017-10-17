*** Settings ***
Documentation                           FloShip UI testing Client part
Resource                                resource.robot
Suite Setup                             Setup Tests
Suite Teardown                          Close All Browsers




*** Test Cases ***
TC195 - Login in Admin Panel (valid)
    [Tags]                               Login
    ${email}=                          Get Email
    Set Suite Variable                  ${REG_EMAIL}                ${email}
    Login                               ${login_admin}        ${pass_admin}
    Wait Until Page Contains            Dashboard
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Wait Until Element Is Visible       ${Add user}
    click element                       ${Add user}

TC196 - Create a new client in Admin panel
    Create a new user                   ${REG_EMAIL}              user_12345
    Payment                             100
    Wait Until Page Contains            User ${REG_EMAIL} is created
    log to console                      ${REG_EMAIL}
    Capture Page Screenshot             ${TEST NAME}-{index}.png

TC197 - Logout in Admin Panel
    Logout Client
    Wait Until Page Contains Element       xpath=//h3[contains(.,"Login")]
    Capture Page Screenshot             ${TEST NAME}-{index}.png

TC523,TC524, TC526 - Create password as a user
    [Tags]                              ResetPass
    Go To                               ${SERVER}
    Wait Until Page Contains Element    xpath=//h3[contains(.,"Login")]
    click Element                       xpath=//div[@class="form-group"]//a[contains(.,"Forgot")]
    Wait Until Page Contains            Password reset
    Capture Page Screenshot             ${TEST NAME}-{index}.png

TC527 - Create password as a user - Success

    Input text                          name=email                    ${REG_EMAIL}
    Click Button                        Reset my password
    Wait Until Page Contains            Password reset sent
    Capture Page Screenshot             ${TEST NAME}-{index}.png

    Open Mailbox                        host=${MAIL_HOST}       user=${MAIL_USER}          password=${MAIL_PASSWORD}
    ${LATEST}=	             Wait for Mail	        	    recipient=${REG_EMAIL}	       timeout=150
    ${body}=	             get email body	       ${LATEST}
    #log to console           ${body}
    ${pass_link}=	             Get Mail link Gmail 	      ${body}
    log to console           ${pass_link}
    Delete Email                         ${LATEST}
    Close Mailbox
    Go To                               ${pass_link}
    Reset Password                      Enter new password      ${reset_pass}       ${reset_pass}             Password reset complete
    set suite variable                  ${REG PASS}             ${reset_pass}
    Click Element                       ${Log in}
    Wait Until Page Contains Element    xpath=//h3[contains(.,"Login")]
    Login                               ${REG EMAIL}        ${REG PASS}
    wait until page contains            Company Details
    wait until page contains            Company Address
    Capture Page Screenshot             ${TEST NAME}-{index}.png

TC293 - Login as a user
    [Tags]                              Register
    Go To                               ${SERVER}
    ${rand_company}=                    Get Rand Company
    log to console                      ${rand_company}
    set suite variable                  ${get_company}            ${rand_company}
    wait until page contains            Company Details
    wait until page contains            Company Address

