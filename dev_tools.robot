*** Settings ***
Documentation                           FloShip UI testing
Resource                                resource.robot
Suite Setup                             Open Browser with Dev Tools     ${SERVER}
Suite Teardown                          Close All Browsers
*** Test Cases ***


Reports FSM refactoring
    Login                               ${login_admin}        ${pass_admin}
    Wait Until Page Contains            Dashboard
