*** Settings ***
Documentation                           FloShip UI testing
Resource                                resource.robot
Suite Setup                             Setup Tests
Test Teardown                           Delete All Cookies
Suite Teardown                          Close All Browsers

*** Test Cases ***
Login and create new user
    [Tags]                               Login
    ${email}=                           Get Email Address
    Set Suite Variable                  ${REG_EMAIL}                ${email}
    Login                               cutoreno@p33.org         qw1as2zx3po
    #Wait Until Page Contains            Login Successful
    Wait Until Page Contains            Floship Administration
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Wait Until Element Is Visible       ${Add user}
    click element                       ${Add user}
    Create a new user                   ${REG_EMAIL}              user_12345
    Wait Until Page Contains            User ${REG_EMAIL} is created
    log to console                      ${REG_EMAIL}
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Logout                              Thanks for spending some quality time with the Web site today.
    Capture Page Screenshot             ${TEST NAME}-{index}.png


#Reset Password
#    [Tags]                              ResetPass
#    Go To                               ${SERVER}
#    Wait Until Page Contains Element    xpath=//h3[contains(.,"Login")]
#    click Element                       xpath=//div[@class="form-group"]//a[contains(.,"Forgot")]
#    Wait Until Page Contains            Password reset
#    Capture Page Screenshot             ${TEST NAME}-{index}.png
#    Input text                          name=email                     ${REG_EMAIL}
#    Click Button                        Reset my password
#    Wait Until Page Contains            Password reset sent
#    Capture Page Screenshot             ${TEST NAME}-{index}.png
#    ${res}=                             Wait Until Keyword Succeeds     3 min       5 sec          Check Mail   ${REG_EMAIL}    ${0}
#    ${link}=                            Get Mail link           ${res}
#    log to console                      ${link}
#    Go To                               ${link}
#    Reset Password                      Enter new password      ${reset_pass}       ${reset_pass}             Password reset complete
#    set suite variable                  ${REG PASS}             ${reset_pass}
#    Click Element                       ${Log in}
#    Wait Until Page Contains Element    xpath=//h3[contains(.,"Login")]
#    Login                               ${REG_EMAIL}         qw1as2zx3po
#    wait until page contains            Login or password incorrect
#    Capture Page Screenshot             ${TEST NAME}-{index}.png
#    Login                               ${REG EMAIL}        ${REG PASS}
#    wait until page contains            Company Details
#    wait until page contains            Company Address
#    Capture Page Screenshot             ${TEST NAME}-{index}.png

Registration for new user
    [Tags]                              Register
    Go To                               ${SERVER}
    ${rand_company}=                    Get Rand Company
    log to console                      ${rand_company}
    Login                               ${REG EMAIL}         12345678
    wait until page contains            Company Details
    wait until page contains            Company Address
    click button                        Register
    Registration Empty Fields           8

    ##Invalid Data Email
    Registration Invalid Data           client_address.email           test
    Registration Invalid Data           website                        test
    Registration Invalid Data           client_contact.email           test
    click button                        Register

    ##Validation
    Check Errors                        Enter a valid email address
    Check Errors                        Enter a valid URL.
    Check Errors                        Enter a valid email address

    ##Normal data

    Full Valid Data                 ${rand_company}         ${REG EMAIL}
    wait until page contains         Welcome to Floship!

    # Payment method

    Wait Element And Click              ${agree}
    click button                        Continue

    Invalid Card Number                 This field may not be blank           A valid integer is required           This field may not be blank
    Create Card Number                  ${card num}       ${exp date}           ${cvv}
    wait until page contains            We are preparing your warehouse

Dashboard (New Product)
    [Tags]                              Product
    Go To                                ${SERVER}
    Login                               nxzxv7@p33.org         12345678
#    Wait Until Page Contains            Introduction
#    Add New Product                     Add Product
#    Go To                                ${SERVER}
#    Header title block                  Advanced Shipping Notice
#    Add New ASN                         Add ASN          XM          FASN
#    ${id_ship}=                         Get Id
#    log to console                      ${id_ship}
#    Header link                         Shipping Options
#    Add Shipping Options                Add Shipping Option       SMO1           HKPost Parcel
#    Add Group Items List                Add Group Items           XM            XMO1
    Add Order                           Add Order           XM       XMO1      F
