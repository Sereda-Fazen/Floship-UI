*** Settings ***
Documentation                           FloShip UI testing
Resource                                resource.robot
Suite Setup                             Setup Tests
Suite Teardown                          Close All Browsers
*** Test Cases ***


TC700 - Create Shipping option (empty fields)
     Go To                     ${ADMIN}
     Login                     test+rmozilym@floship.com                 12345678
     Wait Until Page Contains         Dashboard











