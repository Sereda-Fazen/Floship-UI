*** Settings ***
Documentation                           FloShip UI testing
Resource                                resource.robot
Suite Setup                             Setup Tests
Suite Teardown                          Close All Browsers
*** Test Cases ***


TC700 - Create Shipping option (empty fields)
     Go To                     ${ADMIN}
     Login                     test+rmozilym@floship.com                 12345678
#     Mouse over and Click          Customers                  /admin-backend/preferences/clientshippingoption/
#     wait until page contains             Select client shipping option to change
#     click element                 xpath=//a[contains(.,"Add client shipping option")]
#     wait until page contains          Add client shipping option
#     click button                  name=_save
#     #wait error this is required (Admin)                Client              This field is required
#
#TC697 - Create Shipping option
#    ${ship_op}=                        Get Rand ID            ${shipping_name}
#    log to console                     ${ship_op}
#    Go To                           ${ADMIN}preferences/clientshippingoption/add/
#    wait until page contains          Add client shipping option
#    Select Fields Country SO            United States of America
#    input text                       name=shipping_option                  ${ship_op}
#    Select Fields (Client, Courier) SO          select2-id_client-container           Client for autotests_1246789
#    Select Fields (Client, Courier) SO          select2-id_courier_service-container                       WMP YAMATO
#    click element                  name=_save
#    wait until page contains             The client shipping option "Client for autotests_1246789 - ${ship_op}" was added successfully

TC702 - Search
    Go To                           ${ADMIN}preferences/clientshippingoption/
    Check Item in Search       SOM01_1409402
    show in table             SOM01_1409402      Client for autotests_1246789           WMP YAMATO      United States of America
    Open Check Order          SOM01_1409402

TC701 - Edit Shipping option
    wait until page contains               Change client shipping option
    Select Fields (Client, Courier) SO          select2-id_client-container           Client for autotests_1246789
    Select Fields Country SO            Australia
    click element                  name=_save
    wait until page contains             The client shipping option "Client for autotests_1246789 - SOM01_1409402" was changed successfully


TC703 - Filters


TC704 - Sorting


TC705 - Bulk actions















