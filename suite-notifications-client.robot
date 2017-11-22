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


TC1161 - Notification about Out of stock products - Step 1
   ${sku}=                             Get Rand Sku
   ${desc}=                            Get Rand Desc
   set suite variable                  ${sku_}      ${sku}
   set suite variable                  ${desc_}     ${desc}
   log to console                      ${sku}
   log to console                      ${desc}
   go to                               ${SERVER}/inventory/products
   Login                              ${rand_client}               12345678
   wait element and click              ${add}
   Valid Data                          ${sku_}        ${desc_}       Mobile phone         1234567
   Save
   Go To                               ${SERVER}/inventory/products
   show in table bulk upload           ${sku_}      ${desc_}

TC1163 - Check notification settings
   Go To                              ${SERVER}
   Wait settings and Click            Preferences
   Check notifications                Notifications
   Check enable notifications         ASN Received
   Check enable notifications         Order Fulfilled
   Check enable notifications         Incomplete Orders
   Check enable notifications         Low stock
   Save
   wait until page contains         Successfully updated preferences
   Go To                              ${SERVER}
   Logout Client

TC1161 - Notification about Out of stock products (Stock Adjastments)
   Go To                         ${ADMIN}stock_adjustment/stockadjustment/
   Login                         ${login_admin}         ${pass_admin}
   wait until page contains      Select stock adjustment to change
   Add Stock Adjustment          ${sku_}            ${sku_} -- Base Item     3
   ${status}=                     Get Id Adjustment         Draft
   log to console                 ${status}
   wait until page contains      The stock adjustment "${status}" was added successfully
   Approve stock adjustment        ${status}
   wait until page contains      ${status} successfully set to Approved
   Logout Client

TC471 - Add stock adjustment for remove "out of stock" exception
   go to                               ${SERVER}/inventory/products
   Sleep                             5 sec
   Login                            ${rand_client}           12345678
   Find Product Stock                ${sku_}            3


TC1162 - Notification about ASN received (Pending Approval)
   Go To                                 ${SERVER}/advanced-shipping-notices
   #Login                                client+xabkekor@floship.com                  12345678
   wait element and click           xpath=//a[contains(.,"Add ASN")]
   Valid Data ASN                ${sku_}
   Save
   wait until page contains element       xpath=//table//td[contains(.,"Draft")]
   ${id_ship}=                         Get Id ASN
   log to console                      ${id_ship}
   set suite variable                  ${fasn_id}               ${id_ship}

   wait element and click         xpath=//a[contains(.,"${fasn_id}")]
   Approve ASN                  ${fasn_id}
   Success Approved             ${fasn_id}                       Pending Arrival
   Go To                                 ${SERVER}/advanced-shipping-notices
   Logout Client


TC666 - Create ASN (approve)
    Go To                            ${ADMIN}asns/asn/
    Login                            ${rand_staff}             12345678
    Check Item in Search                        ${fasn_id}
    Check ASN Approve                ${fasn_id}    In Review Asn
    wait until page contains         ${fasn_id} successfully set to In Review

    Go To                            ${ADMIN}asns/asn/
    Check Item in Search             ${fasn_id}
    Check ASN Approve                ${fasn_id}  Approve Asn
    wait until page contains         ${fasn_id} successfully set to Approve
    Go To                            ${ADMIN}
    Logout Client

TC1160 - Notification about Fulfilled orders (Order should be fulfilled)
    Go to                               ${SERVER}/orders
    Login                               ${rand_client}                  12345678
    ${id}=                              Get Rand ID       ${order_id}
   set suite variable                  ${id_order}        ${id}
   Wait Until Page Contains            Dashboard
   wait element and click              ${add}
   Valid Data Order                    ${id_order}    WMP YAMATO    ${country}   ${sku_}      ${sku_}   Base Item
   wait until page contains             Order Saved Successfully
   Go To                                ${SERVER}/orders
   log to console                      ${id_order}
   show order                          FS           ${id_order}       WMP YAMATO      Pending Fulfillment
   ${id_fs}=                           Get Id Order
   log to console                      ${id_fs}
   set suite variable                  ${fsn}             ${id_fs}

TC1161 - Notification about Out of stock products
    Go To                                ${SERVER}/orders
    Notifications Client               You have 1 products with low stock quantity
    Go To                            ${SERVER}/orders
    Logout Client



TC477 - Mark order as fulfilled
     [Tags]                           Mark
     Go To                     ${ADMIN}orders/warehousependingfulfillmentorder/
     Login                         ${login_admin}        ${pass_admin}
     Check Item in Search                        ${fsn}
     Sleep                      40 sec
     reload page
     Check Data fulfilled                    ${fsn}         	${id_order}          Pending Fulfillment        WMP YAMATO
     Mark                           Mark as fulfilled
     wait until page contains        Orders have been updated
     Check does not Data fulfilled           ${fsn}         	${id_order}          Pending Fulfillment        WMP YAMATO
     Logout Client


TC1160 - Notification about Fulfilled orders
    Go To                           ${SERVER}/orders
    Login                                ${rand_client}                  12345678
    Notifications Client                Order was fulfilled ${fsn}
TC1162 - Notification about ASN received
    Notifications Client             We received your ASN ${fasn_id}
    Logout Client


TC1149 - Upload .csv file
    Go To                         ${ADMIN}orders/workshopordersimportrecord/
    Login                         ${login_admin}         ${pass_admin}
    Workshop Order CSV Upload         order_incomplete.csv       Client Company
    wait until page contains       Workshop orders Upload
    show buttons in bulk form           Valid 1    Invalid 0    All 1
    wait element and click              xpath=//div[@class="btn-group"]/label[contains(.,"Valid 1")]
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Valid")]
    Check Order Workshop                           Order ID	               OpderCSV_1
    Check Order Workshop                   Shipping Option                       my ship name
    Check Order Workshop                   Insurance Value	                   	USD30.00
    Check Order Workshop                      Packaging SKU	               SHIP-READY
    Check Order Workshop                      Company                      ACME INC
    Check Order Workshop                      Name                      	JOHN DOE
    Check Order Workshop                        Address Line 1	           456 ACME LANE
    Check Order Workshop                       Address Line 2              ${EMPTY}
    Check Order Workshop                       City	                       SAMPLE CITY 2
    Check Order Workshop                       State                       ${EMPTY}
    Check Order Workshop                       Postal Code	               12345
    Check Order Workshop                       Country	                    US
    Check Order Workshop                          Phone	                   (555) 555-5555
    Check Order Workshop                          Email	                   JOHN@EXAMPLE.COM

    Check Item in Workshop        Row        2
    Check Item in Workshop        SKU        NS_1
    Check Item in Workshop        QTY        3
    Check Item in Workshop        Value      USD7.89
    wait element and click                  css=button.close > span
    wait until page does not contain element         css=button.close > span
    page should contain element          xpath=//input[contains(@value,"Save Orders Workshop Orders Import Record")]

#TC1150 - Upload .xls file
#    Go To                         ${ADMIN}orders/workshopordersimportrecord/
#    Workshop Order CSV Upload         2_order_success_xls.xls       Client Company
#    wait until page contains       Workshop orders Upload
#    show buttons in bulk form           Valid 1    Invalid 0    All 1
#    wait element and click              xpath=//div[@class="btn-group"]/label[contains(.,"Valid 1")]
#    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Valid")]
#    Check Order Workshop                           Order ID	               	OrderXLS_1
#    Check Order Workshop                   Shipping Option                       my ship name
#    Check Order Workshop                   Insurance Value	                   	USD30.00
#    Check Order Workshop                      Packaging SKU	               SHIP-READY
#    Check Order Workshop                      Company                      ACME INC
#    Check Order Workshop                      Name                      	JOHN DOE
#    Check Order Workshop                        Address Line 1	           456 ACME LANE
#    Check Order Workshop                       Address Line 2              ${EMPTY}
#    Check Order Workshop                       City	                       SAMPLE CITY 2
#    Check Order Workshop                       State                       ${EMPTY}
#    Check Order Workshop                       Postal Code	               12345
#    Check Order Workshop                       Country	                    US
#    Check Order Workshop                          Phone	                   (555) 555-5555
#    Check Order Workshop                          Email	                   JOHN@EXAMPLE.COM
#
#    Check Item in Workshop        Row        2
#    Check Item in Workshop        SKU        NS_1
#    Check Item in Workshop        QTY        3
#    Check Item in Workshop        Value      USD7.89
#    wait element and click                  css=button.close > span
#    wait until page does not contain element         css=button.close > span
#    page should contain element          xpath=//input[contains(@value,"Save Orders Workshop Orders Import Record")]

TC1152 - Upload file without Order ID and Qty
    Go To                         ${ADMIN}orders/workshopordersimportrecord/
    Workshop Order CSV Upload         4_order_without_OrderID_and_Qty.xlsx       Client Company
    wait until page contains       Workshop orders Upload
    show buttons in bulk form           Valid 0    Invalid 2    All 2
    wait element and click              xpath=(//div[@class="row ng-scope"]//span[contains(.,"Invalid")])[1]
    Check Item in Workshop        QTY        A valid integer is required
    wait element and click              xpath=(//div[@class="row ng-scope"]//span[contains(.,"Invalid")])[2]
    Check Order Workshop                           Order ID	               	OrderID can't be blank
    wait element and click                  css=button.close > span
    wait until page does not contain element          xpath=//input[contains(@value,"Save Orders Workshop Orders Import Record")]


TC1153 - Upload file with formatting
    Go To                         ${ADMIN}orders/workshopordersimportrecord/
    Workshop Order CSV Upload         4_empty_file_with_formatting.xlsx       Client Company
    wait until page contains element      xpath=//div[@class="form-row field-status" and contains(.,"Status") and contains(.,"Failed")]


TC1154 - Upload file with Order ID and Qty
    Go To                         ${ADMIN}orders/workshopordersimportrecord/
    #Login                           ${login_admin}        ${pass_admin}
    Workshop Order CSV Upload         6_orders_with_orderID_and_qty.xlsx            ${client_name}
    wait until page contains       Workshop orders Upload
    show buttons in bulk form           Valid 2    Invalid 0    All 2
    wait element and click                  css=button.close > span
    Wait Element And Click          xpath=//input[contains(@value,"Save Orders Workshop Orders Import Record")]
    Go To                         ${ADMIN}orders/workshopordersimportrecord/
    Logout Client


TC1155 - Check Incompete Notification
    Go To                         ${SERVER}/orders
    Login                          ${rand_client}              12345678
    Notifications Client           You have 2 incomplete orders

TC1156 - Check Incompete order
    wait element and click         xpath=//span[@ng-bind="notification.text" and contains(.,"You have 2 incomplete orders")]
    Show data in order              22102017-2         Incomplete
    Show data in order              22102017-1        Incomplete
    wait element and click          xpath=//a[contains(.,"22102017-2")]
    wait element and click          xpath=//a[contains(.,"Edit")]
    wait until page contains        Invalid order line. Please replace with an existing item from the dropdown menu below

    wait error this is required       order     shipping_address.addressee                              Please input an addressee
    wait error this is required       order     shipping_address.address_1                              This is a required field
    wait error this is required       order     shipping_address.city                              Please input your city
    wait error this is required       order     shipping_address.postal_code                          A valid postcode is required
    wait error this is required       order     shipping_address.country                             This field may not be blank
    wait error this is required       order     shipping_address.phone                         A valid phone number is required
    wait error this is required       order     ship_via_id                          This field can't be blank
    Go To                             ${SERVER}/orders

TC1157 - Upload 10 orders
    Go To                         ${ADMIN}orders/workshopordersimportrecord/
    Login                           ${login_admin}        ${pass_admin}
    Workshop Order CSV Upload         7_10_orders_success_xlsx.xlsx         ${client_name}
    wait until page contains       Workshop orders Upload
    show buttons in bulk form           Valid 10    Invalid 0    All 10
    wait element and click                  css=button.close > span
    Wait Element And Click          xpath=//input[contains(@value,"Save Orders Workshop Orders Import Record")]
    Sleep                           30 sec

TC1158 - Check order
    Go To                         ${ADMIN}orders/salesorder/
    Show Order in sequence         1        Order_10          ${client_name}
    Show Order in sequence         2        Order_9           ${client_name}
    Show Order in sequence         1        Order_8           ${client_name}
    Show Order in sequence         2        Order_7           ${client_name}
    Show Order in sequence         1        Order_6           ${client_name}
    Show Order in sequence         2        Order_5           ${client_name}
    Show Order in sequence         1        Order_4           ${client_name}
    Show Order in sequence         2        Order_3           ${client_name}
    Show Order in sequence         1        Order_2           ${client_name}
    Show Order in sequence         2        Order_1           ${client_name}
    Logout Client


TC1164 - Notification are switched off
   Go To                              ${SERVER}
   Login                              ${rand_client}            12345678
   Wait settings and Click            Preferences
   Check notifications                Notifications
   Check disable notifications         ASN Received
   Check disable notifications         Order Fulfilled
   Check disable notifications        Incomplete Orders
   Check disable notifications         Low stock
   Save
   wait until page contains         Successfully updated preferences
   reload page

TC1167 - Check that notification about stock does not display - Step 1
   ${sku}=                             Get Rand Sku
   ${desc}=                            Get Rand Desc
   set suite variable                  ${sku__}      ${sku}
   set suite variable                  ${desc__}     ${desc}
   log to console                      ${sku}
   log to console                      ${desc}
   go to                               ${SERVER}/inventory/products
   #Login                              ${rand_client}               12345678
   wait element and click              ${add}
   Valid Data                          ${sku__}        ${desc__}       Mobile phone         1234567
   Save
   Go To                               ${SERVER}/inventory/products
   show in table bulk upload           ${sku__}      ${desc__}
   Logout Client

   Go To                         ${ADMIN}stock_adjustment/stockadjustment/
   Login                         ${login_admin}         ${pass_admin}
   wait until page contains      Select stock adjustment to change
   Add Stock Adjustment          ${sku__}            ${sku__} -- Base Item     3
   ${status}=                     Get Id Adjustment         Draft
   log to console                 ${status}
   wait until page contains      The stock adjustment "${status}" was added successfully
   Approve stock adjustment        ${status}
   wait until page contains      ${status} successfully set to Approved
   Logout Client

   go to                               ${SERVER}/inventory/products
   Sleep                             5 sec
   Login                            ${rand_client}           12345678
   Find Product Stock                ${sku__}            3


TC1169 - Check that notification about ASN received does not display - Create
   Go To                                 ${SERVER}/advanced-shipping-notices
   #Login                                client+xabkekor@floship.com                  12345678
   wait element and click           xpath=//a[contains(.,"Add ASN")]
   Valid Data ASN                ${sku__}
   Save
   wait until page contains element       xpath=//table//td[contains(.,"Draft")]
   ${id_ship}=                         Get Id ASN
   log to console                      ${id_ship}
   set suite variable                  ${fasn_id}               ${id_ship}

   wait element and click         xpath=//a[contains(.,"${fasn_id}")]
   Approve ASN                  ${fasn_id}
   Success Approved             ${fasn_id}                       Pending Arrival
   Go To                                 ${SERVER}/advanced-shipping-notices
   Logout Client


TC1169 - Check that notification about ASN received does not display - In Review Asn
    Go To                            ${ADMIN}asns/asn/
    Login                            ${rand_staff}             12345678
    Check Item in Search                        ${fasn_id}
    Check ASN Approve                ${fasn_id}    In Review Asn
    wait until page contains         ${fasn_id} successfully set to In Review

    Go To                            ${ADMIN}asns/asn/
    Check Item in Search             ${fasn_id}
    Check ASN Approve                ${fasn_id}  Approve Asn
    wait until page contains         ${fasn_id} successfully set to Approve
    Go To                            ${ADMIN}
    Logout Client

    Go to                               ${SERVER}/orders
    Login                               ${rand_client}                  12345678
    ${id}=                              Get Rand ID       ${order_id}
   set suite variable                  ${id_order}        ${id}
   Wait Until Page Contains            Dashboard
   wait element and click              ${add}
   Valid Data Order                    ${id_order}    WMP YAMATO    ${country}   ${sku__}      ${sku__}   Base Item
   wait until page contains             Order Saved Successfully
   Go To                                ${SERVER}/orders
   log to console                      ${id_order}
   show order                          FS           ${id_order}       WMP YAMATO      Pending Fulfillment
   ${id_fs}=                           Get Id Order
   log to console                      ${id_fs}
   set suite variable                  ${fsn}             ${id_fs}

TC1167 - Check that notification about stock does not display
    Go To                                ${SERVER}/orders
    Notifications disapper Client               You have 1 products with low stock quantity
    Go To                            ${SERVER}/orders
    Logout Client


TC1168 - Check that notification about fulfilled orders does not display
     Go To                     ${ADMIN}orders/warehousependingfulfillmentorder/
     Login                         ${login_admin}        ${pass_admin}
     Check Item in Search                        ${fsn}
     Sleep                      30 sec
     reload page
     Check Data fulfilled                    ${fsn}         	${id_order}          Pending Fulfillment        WMP YAMATO
     Mark                           Mark as fulfilled
     wait until page contains        Orders have been updated
     Check does not Data fulfilled           ${fsn}         	${id_order}          Pending Fulfillment        WMP YAMATO
     Logout Client

    Go To                           ${SERVER}/orders
    Login                                ${rand_client}                  12345678
    Notifications disapper Client                Order was fulfilled ${fsn}

TC1169 - Check that notification about ASN received does not display - Approve
    Notifications disapper Client             We received your ASN ${fasn_id}
    Logout Client


TC1165 - Check that notification about Incomplete orders does not display
    Go To                         ${ADMIN}orders/workshopordersimportrecord/
    Login                           ${login_admin}        ${pass_admin}
    Workshop Order CSV Upload         6_orders_with_orderID_and_qty.xlsx            ${client_name}
    wait until page contains       Workshop orders Upload
    show buttons in bulk form           Valid 2    Invalid 0    All 2
    wait element and click                  css=button.close > span
    Wait Element And Click          xpath=//input[contains(@value,"Save Orders Workshop Orders Import Record")]
    Go To                         ${ADMIN}orders/workshopordersimportrecord/
    Logout Client

    Go To                         ${SERVER}/orders
    Login                          ${rand_client}              12345678
    Notifications disapper Client           You have 2 incomplete orders