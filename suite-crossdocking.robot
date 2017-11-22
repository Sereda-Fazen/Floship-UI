*** Settings ***
Documentation                           FloShip UI testing Client part
Resource                                resource.robot
Suite Setup                             Setup Tests
Suite Teardown                          Close All Browsers




*** Test Cases ***
TC825 - Preparing (create client)
    [Tags]                        CreateUser
    ${email}=                     Get Email Client     ${cli_role}
    set suite variable            ${rand_client}        ${email}
    log to console                ${rand_client}
    Login                         ${login_admin}        ${pass_admin}
    Wait Until Page Contains      Dashboard
    Capture Page Screenshot       ${TEST NAME}-{index}.png
    Go To                         ${ADMIN}auth/user/
    wait element and click            xpath=//a[contains(.,"Add user")]
    wait until page contains          Add user
    ${name}=                    Get Rand ID          FName_
    ${lname}=                    Get Rand ID          LName_
    set suite variable          ${ch_name_client}        ${name}
    set suite variable          ${ch_lname_client}       ${lname}
    log to console              ${ch_name_client}
    log to console              ${ch_lname_client}
    Create User                   ${rand_client}              12345678             12345678
    wait until page contains      The user "${rand_client}" was added successfully. You may edit it again below.
    Settings User                ${ch_name_client}    	${ch_lname_client}        ${rand_client}
    click element                 name=_save
    wait until page contains      The user "${rand_client}" was changed successfully.
    ${client_}=                   Get Rand ID           ${client_role}
    ${rand_refer_client}=                Get Rand ID        ${refer}
    set suite variable            ${client_name}    ${client_}
    log to console                ${client_name}
    Go To                         ${ADMIN}floship/client/
    Create Client                ${client_}        ${rand_client}            ${rand_client}       ${rand_refer_client}
    wait until page contains      The client "${client_}" was added successfully


TC824 - Preparing (create 3PL User)
    ${3pl_client}=                     Get Email Client     ${3pl_client}
    set suite variable            ${rand_3pl_client}        ${3pl_client}
    log to console                ${rand_3pl_client}
    Go To                         ${ADMIN}
    Wait Until Page Contains      Dashboard
    Capture Page Screenshot       ${TEST NAME}-{index}.png
    ${name}=                    Get Rand ID          FName_
    ${lname}=                    Get Rand ID          LName_
    set suite variable          ${ch_name}        ${name}
    set suite variable          ${ch_lname}       ${lname}
    mouse over and click             Customers               /admin-backend/auth/user/
    wait element and click            xpath=//a[contains(.,"Add user")]
    wait until page contains          Add user
    Create User                   ${rand_3pl_client}              12345678             12345678
    wait until page contains      The user "${rand_3pl_client}" was added successfully. You may edit it again below.
    Settings User                ${ch_name}    	${ch_lname}        ${rand_3pl_client}
    Select role (3pl user)
    wait until page contains      The user "${rand_3pl_client}" was changed successfully.
    Go To                          ${ADMIN}floship/threepl/
    wait until page contains       Select 3PL to change
    Change Three pl               Geodis       ${rand_3pl_client}
    input text                   css=#id_threeplcontact_set-0-first_name               ${ch_name}3pl
    input text                   css=#id_threeplcontact_set-0-last_name               ${ch_lname}3pl
    input text                   css=#id_threeplcontact_set-0-email                    ${rand_3pl_client}
    click element                   name=_save
    wait until page contains      The 3PL "Geodis" was changed successfully


TC829 - Preparing (staff user)
    ${staff}=                     Get Email Client     ${staff_user}
    set suite variable            ${rand_staff}        ${staff}
    log to console                ${rand_staff}
    Go To                          ${ADMIN}
    Wait Until Page Contains      Dashboard
    Capture Page Screenshot       ${TEST NAME}-{index}.png
    ${name}=                    Get Rand ID          FName_
    ${lname}=                    Get Rand ID          LName_
    set suite variable          ${ch_name}        ${name}
    set suite variable          ${ch_lname}       ${lname}
    mouse over and click             Customers               /admin-backend/auth/user/
    wait element and click            xpath=//a[contains(.,"Add user")]
    wait until page contains          Add user
    Create User                   ${rand_staff}              12345678             12345678
    wait until page contains      The user "${rand_staff}" was added successfully. You may edit it again below.
    Settings User                ${ch_name}    	${ch_lname}        ${rand_staff}
    Select role (staff user)
    wait until page contains      The user "${rand_staff}" was changed successfully.
    Logout Client

Set manual approve in Preference (Client)
    Go To                              ${SERVER}
    Login                              ${rand_client}             12345678
    Wait settings and Click            Preferences
    Radio button Approve                Manual Approval
    Go To                                ${SERVER}
    Logout Client

TC1170 - Create user with Cross-Docking Order type
    Go To                              ${ADMIN}floship/client/
    Login                              ${rand_staff}             12345678
    Check Item in Search               ${client_name}
    Open Check Order                   ${client_name}
    wait until page contains           Change client
    header link admin                  Client preferences        Order approval type
    Check client's preference             Manual Approval
    Select Fields                     Default order type      Cross-docking      Cross-docking
    click button                       name=_save
    wait until page contains          The client "${client_name}" was changed successfully
    Logout Client

TC1171 - Check item fields
    ${id}=                              Get Rand ID       ${cross_dock_id}
    set suite variable                  ${id_order}        ${id}
    log to console                      ${id_order}
    Go To                               ${SERVER}/orders
    Login                               ${rand_client}             12345678
    wait element and click              ${add}
    wait until page contains            New Order
    wait until page contains            No items selected

TC1178 - Empty fields
    click button                        Add item
    Save
    wait error this is required (cross)        order_line     customs_description               This field is required
    wait error this is required (cross)         order_line     country_of_manufacture               This field is required
    wait error this is required (cross)         order_line     quantity               This field is required
    wait error this is required (cross)         order_line     customs_value.amount               This field is required
    wait error this is required (cross)         order_line     gross_weight               This field is required
    check labels and fileds             Customs Description       Country Of Manufacture        Qty      Customs Value     Weight

TC1179 - Incorrect values
    input text                          //*[@ng-model="order_line.quantity"]               1.2
    input text                          //*[@ng-model="order_line.customs_value.amount"]               1/2
    input text                          //*[@ng-model="order_line.gross_weight"]               1/2
    Save

    wait error this is required (cross)         order_line     quantity               A valid integer is required
    wait error this is required (cross)         order_line     customs_value.amount          A valid integer is required
    wait error this is required (cross)         order_line     gross_weight         Ensure that there are no more than 3 decimal places


TC1172 - Save cross-docking order
   input text                          //*[@ng-model="order_line.customs_description"]               Test Description
   click element                    //*[@placeholder="Select a country"]/..//input
   input text                        //*[@placeholder="Select a country"]/..//input                  China
   click element                      //div[@class="option ui-select-choices-row-inner" and contains(.,"China")]
   input text                          //*[@ng-model="order_line.quantity"]               10
   input text                          //*[@ng-model="order_line.customs_value.amount"]               100
   input text                          //*[@ng-model="order_line.gross_weight"]               1.5
   Order for crossdocking                     ${country}   ${id_order}    WMP YAMATO
   Save
   wait until page contains             Order Saved Successfully

TC1173 - Edit order
   [Tags]                               Edit
   Go To                                ${SERVER}/orders
   show data in order                    ${id_order}              Pending Approval
   wait element and click                xpath=//a[contains(.,"${id_order}")]
   wait element and click                xpath=//a[contains(.,"Edit")]
   wait until page contains               Edit Order
   click button                        Add item

   input text                          xpath=(//*[@ng-model="order_line.customs_description"])[2]               Test Description 2
   click element                    xpath=(//*[@placeholder="Select a country"]/..//input)[2]
   input text                        xpath=(//*[@placeholder="Select a country"]/..//input)[2]                  China
   click element                      xpath=//div[@class="option ui-select-choices-row-inner" and contains(.,"China")]
   input text                          xpath=(//*[@ng-model="order_line.quantity"])[2]               20
   input text                          xpath=(//*[@ng-model="order_line.customs_value.amount"])[2]               100
   input text                          xpath=(//*[@ng-model="order_line.gross_weight"])[2]               1.8

   click button                        Add item

   input text                          xpath=(//*[@ng-model="order_line.customs_description"])[3]               Test Description 3
   click element                    xpath=(//*[@placeholder="Select a country"]/..//input)[3]
   input text                        xpath=(//*[@placeholder="Select a country"]/..//input)[3]                  China
   click element                      xpath=//div[@class="option ui-select-choices-row-inner" and contains(.,"China")]
   input text                          xpath=(//*[@ng-model="order_line.quantity"])[3]               30
   input text                          xpath=(//*[@ng-model="order_line.customs_value.amount"])[3]               100
   input text                          xpath=(//*[@ng-model="order_line.gross_weight"])[3]               1.9

   input text                       ${address_1_field_order}                  ${address_1}
    input text                       ${city_field_order}                        ${city}
    input text                       ${state_field_order}                       ${state}

    Save
    wait until page contains             Order Saved Successfully


TC1174 - Approve order
   [Tags]                              Edit
   Go To                               ${SERVER}/orders
   show order                         FS          ${id_order}    WMP YAMATO      Pending Approval
   ${id_fs}=                           Get Id Order
   log to console                      ${id_fs}
   set suite variable                  ${fsn}             ${id_fs}

   Approve Order                      ${fsn}       Approve
   Confirm Approve
   wait until page contains           Action was performed successfully


TC1175 - Check order in the order's list
   Go To                              ${SERVER}/orders
   show order                         ${fsn}          ${id_order}    ${fsn}      Pending Fulfillment
   logout client

TC1177 - Fulfill order
     [Tags]                           Mark
     Go To                     ${ADMIN}orders/warehousependingfulfillmentorder/
     Login                         ${rand_3pl_client}               12345678
     Check Item in Search                        ${fsn}
     Sleep                      30 sec
     reload page
     Check Data fulfilled                    ${fsn}         	${id_order}          Pending Fulfillment        WMP YAMATO
     Mark                           Mark as fulfilled
     wait until page contains        Orders have been updated
     Check does not Data fulfilled           ${fsn}         	${id_order}          Pending Fulfillment        WMP YAMATO
  #####
     go to                     ${ADMIN}
     Mouse over and Click             Order                  /admin-backend/orders/warehousefulfilledorder/
     Check Data fulfilled                    ${fsn}         	${id_order}          Fulfilled        WMP YAMATO
     Logout Client

TC1176 - Check order in admin part

     Go To                            ${ADMIN}orders/salesorder/
     Login                              ${rand_staff}                   12345678
     Check Item in Search             ${id_order}
     Open Check Order                 ${id_order}

    Show data in order             Sent To 3pl	                YES
    Show data in order             Is Workshop	                 NO
    Show data in order             Order Type	                crossdocking

    wait until page contains element          xpath=//a[contains(.,"Edit")]
    #wait until page contains element        xpath=//button[contains(.,"Regenerate")]
    wait until page contains element       xpath=//a[contains(.,"BACK")]
    wait until page contains element       xpath=//a[contains(.,"More")]
    wait until page contains element       xpath=//button[contains(.,"Copy")]
    wait until page contains element        xpath=//a[contains(.,"History")]
    Go To                                   ${ADMIN}
    Logout Client


TC1184 - Add Shipping option
    Go To                                  ${SERVER}/shipping-options
    Login                               ${rand_client}             12345678
    wait element and click              xpath=//a[contains(.,"Add Shipping Option")]
    ${ship_op}=                        Get Rand ID            ${shipping_name}
    log to console                     ${ship_op}
    Valid Data Shipping Cross               ${ship_op}      Hong Kong     WMP YAMATO
    set suite variable                 ${edit_ship}         ${ship_op}

TC1182 - Successful upload, all fields
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     1_cross_docking_order_all_fields.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                       40 sec
    wait until page contains            All orders are valid, you can view the data by clicking on "Valid" button below
    show buttons in bulk form           Valid 1    Invalid 0    All 1
    Confirm
    wait until page contains            Bulk upload was approved successfully               50 sec
    Go To                               ${SERVER}/orders
    Find Product Stock                  CD_ORDER           Pending Approval
    click bulk                          CD_ORDER
    wait until page contains            mobile phone2
    Check data in crossdocking          Customs Description         mobile phone2
    Check data in crossdocking          Customs Description         mobile phone1

    Check data in crossdocking          Country Of Manufacture      CN
    Check data in crossdocking          Country Of Manufacture      CN

    Check data in crossdocking          Qty      2
    Check data in crossdocking          Qty      1

    Check data in crossdocking          Customs Value      $ 4.56
    Check data in crossdocking          Customs Value      $ 266.00

    Check data in crossdocking          Weight      1.220 kg
    Check data in crossdocking          Weight      1.110 kg


TC1183 - Successful upload, only required fields
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     2_cross_docking_order_reqiered_fields.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                       40 sec
    wait until page contains            All orders are valid, you can view the data by clicking on "Valid" button below
    show buttons in bulk form           Valid 1    Invalid 0    All 1
    Confirm
    wait until page contains            Bulk upload was approved successfully               50 sec
    Go To                               ${SERVER}/orders
    Find Product Stock                  OID_1          Pending Approval
    click bulk                          OID_1
    wait until page contains            mobile phone

    Check data in crossdocking          Customs Description         mobile phone
    Check data in crossdocking          Country Of Manufacture      CN
    Check data in crossdocking          Qty     10
    Check data in crossdocking          Customs Value      123,45
    Check data in crossdocking          Weight     3,456 kg


TC1185 - Missing Order ID
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     3_cross_docking_order_missing_OrderID_value.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                      50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data which are not correct    Order ID	              This field may not be blank


TC1186 - Missing Name
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     4_cross_docking_order_missing_Contact_Name_value.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                      50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data which are not correct    Name	              This field may not be blank


TC1187 - Missing Address Line 1
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     5_cross_docking_order_missing_Address_1_value.xls
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                      50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data which are not correct    Address Line 1	              This field may not be blank


TC1188 - Missing City
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     6_cross_docking_order_missing_City_value.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                      50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data which are not correct    City	              This field may not be blank



TC1189 - Missing Country
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     7_cross_docking_order_missing_Country_Code_value.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                      50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data which are not correct    Country	              This field may not be blank



TC1190 - Missing Phone
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     8_cross_docking_order_missing_Phone_value.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                      50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data which are not correct    Phone	              This field may not be blank



TC1191 - Missing Value
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     9_cross_docking_order_missing_Value_value.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                      50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data for order (crossdocking)    Value	              A valid number is required




TC1192 - Missing QTY
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     10_cross_docking_order_missing_Quantity_value.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                      50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data for order (crossdocking)    QTY	             A valid integer is required



TC1193 - Missing C.Description
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     11_cross_docking_order_missing_Customs_Description_value.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                      50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data for order (crossdocking)    C.Description	              This field may not be blank


TC1194 - Missing Weight
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     12_cross_docking_order_missing_Weight_value.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                      50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data for order (crossdocking)                Weight	              A valid number is required.

TC1195 - Missing Manufacture
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     13_cross_docking_order_missing_Country_value.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                      50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data for order (crossdocking)                 Manufacture	              This field may not be blank