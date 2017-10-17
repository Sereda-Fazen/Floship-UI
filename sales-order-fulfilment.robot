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
    set suite variable          ${ch_name}        ${name}
    set suite variable          ${ch_lname}       ${lname}
    Create User                   ${rand_client}              12345678             12345678
    wait until page contains      The user "${rand_client}" was added successfully. You may edit it again below.
    Settings User                ${ch_name}    	${ch_lname}        ${rand_client}
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


TC620 - Prepare product (Out of Stock)
   [Tags]                       ProductOutOfStock
   ${sku}=                             Get Rand Sku
   ${desc}=                            Get Rand Desc
   set suite variable                  ${sku_}      ${sku}
   set suite variable                  ${desc_}     ${desc}
   log to console                      ${sku}
   log to console                      ${desc}
   Go to                               ${SERVER}
   Login                               ${rand_client}               12345678
   wait until page contains            Dashboard
   go to                               ${SERVER}/inventory/products
   wait element and click              ${add}
   Valid Data                          ${sku_}        ${desc_}       Mobile phone         1234567
   Inner Carton
   Master Carton
   Save
   Go To                               ${SERVER}/inventory/products
   show in table bulk upload           ${sku_}      ${desc_}

TC469 - Add Sales Order with Base Item (out of stock)
   [Tags]                             OrderStock
   ${id}=                              Get Rand ID       ${order_id}
   set suite variable                  ${id_order}        ${id}
   #Login                               test+saaizdcy@floship.com         12345678
   Wait Until Page Contains            Dashboard
   Go To                               ${SERVER}/orders
   wait element and click              ${add}
   Valid Data Order                    ${id_order}    WMP YAMATO     ${sku_}      ${sku_}   Base Item
   wait until page contains             Order Saved Successfully
   Go To                                ${SERVER}/orders
   log to console                      ${id_order}
   show order                          FS           ${id_order}          Pending Approval            Out of stock
   ${id_fs}=                           Get Id Order
   log to console                      ${id_fs}
   set suite variable                  ${fsn}             ${id_fs}
   Logout Client

TC470 - Add stock adjustment for remove "out of stock" exception
   [Tags]                                Adjustment
   Go To                         ${ADMIN}stock_adjustment/stockadjustment/
   Login                          ${login_admin}         ${pass_admin}
   wait until page contains      Select stock adjustment to change
   Add Stock Adjustment          ${sku_}            ${sku_} -- Base Item
   ${status}=                     Get Id Adjustment         Draft
   log to console                 ${status}
   wait until page contains      The stock adjustment "${status}" was added successfully
   Approve stock adjustment        ${status}
   wait until page contains      ${status} successfully set to Approved
   Logout Client

TC471 - Add stock adjustment for remove "out of stock" exception
    [Tags]                             FinfProduct
   go to                               ${SERVER}/inventory/products
   Login                             ${rand_client}              12345678
   Find Product Stock                  ${sku_}            1

TC472 - Check product after adding stock adjustment
  [Tags]                               FindOrderStatus
   Go To                               ${SERVER}/orders
   Wait Until Page Contains            Dashboard
   Does not find Out of Stock           	${fsn}              Out of stock
   Find Product Stock                   	${fsn}            Pending Fulfillment

TC474 - Approve order with valid item
   [Tags]                             Approve
   Approve Order                      ${fsn}       Approve
   Confirm Approve
   wait until page contains           Action was performed successfully
   Go To                              ${SERVER}/orders
   Find Order Change Status           ${fsn}       Pending Fulfillment

TC476 - Open order for check as admin
   [Tags]                             CheckOrder
   Go To                              ${SERVER}/orders
   wait until page contains           Order List
   show order                         ${fsn}           ${id_order}     WMP YAMATO     Pending Fulfillment
   Logout Client

TC477 - Mark order as fulfilled
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
#
TC478 - Check fulfillment order
    [Tags]                            CheckFullOrder
    go to                     ${ADMIN}
    Mouse over and Click             Order                  /admin-backend/orders/warehousefulfilledorder/
    Check Data fulfilled                    ${fsn}         	${id_order}          Fulfilled        WMP YAMATO
    Open Check Order                 ${fsn}
    Change Fulfilled Order    tax_paid_by_             Tax paid by          DDU
    Header link Admin         Shipping Info            Courier Service
    Change Fulfilled Order    ship_via                 Courier Service        WMP YAMATO
    Header link Admin         Shipping Address         Shipping address :
    Change Fulfilled Order    shipping_address_        Name                  ${first name}${last name}
    Change Fulfilled Order    shipping_address_        Address               ${address_1}
    Change Fulfilled Order    shipping_address_        Country               ${country}
    Change Fulfilled Order    shipping_address_        City                  ${city}
    Change Fulfilled Order    shipping_address_        State                 ${state}
    Change Fulfilled Order    shipping_address_        Postal Code           ${post_code}
    Change Fulfilled Order    shipping_address_        Phone                 ${phone}

    Header link Admin         Packages                  Packaging item
    Change Fulfilled Order    packaging_item            Packaging item       SHIP-READY -- Packaging Item - No Product
    Change Fulfilled Order    length_                   Length               20 cm
    Change Fulfilled Order    width_                    Width                20 cm
    Change Fulfilled Order    height_                   Height               100 cm
    Change Fulfilled Order    weight_                   Weight               5.100 kg
    Change Fulfilled Order    tracking_number           Tracking number       ${fsn}
    Change Fulfilled Order    shipping_label_           Shipping label        Open
    Change Fulfilled Order    commercial_invoice_ djn-form-row-last           Commercial invoice          Open

    Header link Admin         Sales order lines           Add another Sales order line

    Change Fulfilled Order    quantity                  Quantity                1
    Change Fulfilled Order    client                    Client              ${client_name}
    Change Fulfilled Order    sku                       Sku                   ${sku_}
    Change Fulfilled Order    description               Description          ${desc_}
    Change Fulfilled Order    gross_weight              Gross weight         0.10
    Change Fulfilled Order    gross_length              Gross length         10.00
    Change Fulfilled Order    gross_width               Gross width          5.00
    Change Fulfilled Order    gross_height              Gross height         1.00
    Go To                              ${ADMIN}
    Logout Client


TC741 - Open order for check as admin
   Go To                                ${ADMIN}orders/salesorder/
   Login                              ${rand_staff}           12345678
   Check Item in Search                ${id_order}
   Open Check Order                 ${id_order}
   wait until page contains           Order ${fsn} Details

   show status order               Tracking Number              ${fsn}
   show status order               Source              Fulfillment Portal
   show status order               Courier             WMP YAMATO
   show status order               Status              Fulfilled

   check labels order (Admin)              Company

   Show data in order                Full Name	         SteveVai
   Show data in order                Address	        Street 1

   Show data in order               Phone	            1234567890
   check labels order (Admin)               Email

    Show data in order             Client              ${client_name}
    Show data in order                Floship ID	         ${fsn}
    Show data in order               Order ID	             ${id_order}

    Show data in order             Crowdfunding Number	          -
    Show data in order             State	                   Tracking Integrations Notified
    Show data in order             Tax Paid By	               DDU

    Show data in order             Reason Of Export	            Purchase
    Show data in order             Insurance Value	            $ 0.00

    Show data in order             Sent To 3pl	                YES
    Show data in order             Is Workshop	                 NO
    Show data in order             Order Type	                b2c

    wait until page contains element      xpath=(//td[contains(.,"Transaction Date")])[1]
    check labels order (Admin)              Update Date
    check labels order (Admin)              Original Transaction Date
    check labels order (Admin)              Approval Eligibility Date

    Summary block (Order)           Pick and Pack           $ 567.00
    Summary block (Order)           Estimated           $ 0.00
    wait until page contains element    xpath=//div[@class="panel-body"][contains(.,"Total") and contains(.,"$ 567.00")]

    check item(SKU) after edit            SKU            ${sku_}
    check item(SKU) after edit            Unit Type       	Base Item
    check item(SKU) after edit            Unit Qty      1
    check item(SKU) after edit            Description       ${desc_}
    check item(SKU) after edit            Customs Value       $ 99.99
    check item(SKU) after edit            QTY       1
    check item(SKU) after edit            Total Qty       1

    Check Package Item (Order)           Sku                  SHIP-READY
    Check Package Item (Order)           Dimensions                  System
    Check Package Item (Order)           Length                20
    Check Package Item (Order)           Width                20
    Check Package Item (Order)           Height                 100
    Check Package Item (Order)           Weight                5.1
    Check Package Item (Order)           Tracking Number                ${fsn}
    Check Package Item (Order)           Shipping Label                Download
    Check Package Item (Order)           Commercial Invoice               Download


Logout
    Go To                              ${ADMIN}
    Logout Client

## Inner Carton

TC488 - Add Sales Order with Inner carton
   [Tags]                             OrderStock
   ${id_inner}=                              Get Rand ID       ${order_id}
   set suite variable                  ${id_order_inner}        ${id_inner}
   Go To                               ${SERVER}/orders
   Login                               ${rand_client}                    12345678
   Wait Until Page Contains            Dashboard
   wait element and click              ${add}
   Valid Data Order                    ${id_order_inner}    WMP YAMATO     ${sku_}   ${sku_}   Inner carton
   wait until page contains             Order Saved Successfully
   Go To                                ${SERVER}/orders
   log to console                      ${id_order_inner}
   show order                          FS           ${id_order_inner}     WMP YAMATO      Pending Fulfillment
   ${id_fs_inner}=                           Get Id Order
   log to console                      ${id_fs_inner}
   set suite variable                  ${fsn_inner}             ${id_fs_inner}
   Logout Client

TC942 - Add stock adjustment for remove "out of stock"
   [Tags]                                Adjustment
   Go To                         ${ADMIN}stock_adjustment/stockadjustment/
   Login                          ${login_admin}         ${pass_admin}
   wait until page contains      Select stock adjustment to change
   Add Stock Adjustment          ${sku_}        ${sku_} -- Inner carton
   ${status}=                     Get Id Adjustment         Draft
   log to console                 ${status}
   wait until page contains      The stock adjustment "${status}" was added successfully
   Approve stock adjustment        ${status}
   wait until page contains      ${status} successfully set to Approved
   Logout Client

TC944 - Check product after adding stock adjustment
    [Tags]                             FinfProduct
   go to                               ${SERVER}/inventory/products
   Login                               ${rand_client}                    12345678
   Find Product Stock                  ${sku_}            18

TC945 - Check order after adding stock adjustment
  [Tags]                               FindOrderStatus
   Go To                               ${SERVER}/orders
   Wait Until Page Contains            Dashboard
   Does not find Out of Stock           	${fsn_inner}              Out of stock
   Find Product Stock                   	${fsn_inner}            Pending Fulfillment
   Logout Client

TC493 - Mark order as pending fulfilled - inner carton
   [Tags]                             CheckOrder
   Go To                              ${ADMIN}orders/salesorder/
   Login                              ${rand_staff}               12345678
   wait until page contains           Select sales order to change
   Check Item in Search                        ${fsn_inner}
   Check Data Order                   ${fsn_inner}     ${id_order_inner}              Pending Fulfillment             WMP YAMATO
   Logout Client


TC491 - Check order in the list of orders as admin - inner carton
   [Tags]                             CheckOrder
   Go To                              ${SERVER}/orders
   Login                               ${rand_client}            12345678
   wait until page contains           Order List
   show order                         ${fsn_inner}           ${id_order_inner}     WMP YAMATO     Pending Fulfillment
   Logout Client


TC493 - Mark order as fulfilled - inner carton
     [Tags]                           Mark
     Go To                     ${ADMIN}orders/warehousependingfulfillmentorder/
     Login                            ${rand_3pl_client}              12345678
     Check Item in Search                        ${fsn_inner}
     Sleep                      30 sec
     reload page
     Check Data fulfilled                    ${fsn_inner}          	 ${id_order_inner}          Pending Fulfillment        WMP YAMATO
     Mark                           Mark as fulfilled
     wait until page contains        Orders have been updated
     Check does not Data fulfilled          ${fsn_inner}          	 ${id_order_inner}         Pending Fulfillment        WMP YAMATO

TC494 - Check fulfillment order - inner carton
    [Tags]                            CheckFullOrder
    go to                     ${ADMIN}
    Mouse over and Click             Order                 /admin-backend/orders/warehousefulfilledorder/
    Check Data fulfilled                    ${fsn_inner}          	 ${id_order_inner}         Fulfilled        WMP YAMATO
    Open Check Order                 ${fsn_inner}
    Change Fulfilled Order    tax_paid_by_             Tax paid by          DDU
    Header link Admin         Shipping Info            Courier Service
    Change Fulfilled Order    ship_via                 Courier Service        WMP YAMATO
    Header link Admin         Shipping Address         Shipping address :
    Change Fulfilled Order    shipping_address_        Name                  ${first name}${last name}
    Change Fulfilled Order    shipping_address_        Address               ${address_1}
    Change Fulfilled Order    shipping_address_        Country               ${country}
    Change Fulfilled Order    shipping_address_        City                  ${city}
    Change Fulfilled Order    shipping_address_        State                 ${state}
    Change Fulfilled Order    shipping_address_        Postal Code           ${post_code}
    Change Fulfilled Order    shipping_address_        Phone                 ${phone}

    Header link Admin         Packages                  Packaging item
    Change Fulfilled Order    packaging_item            Packaging item       SHIP-READY -- Packaging Item - No Product
    Change Fulfilled Order    length_                   Length               20 cm
    Change Fulfilled Order    width_                    Width                20 cm
    Change Fulfilled Order    height_                   Height               100 cm
    Change Fulfilled Order    weight_                   Weight               12.000 kg
    Change Fulfilled Order    tracking_number           Tracking number      ${fsn_inner}
    Change Fulfilled Order    shipping_label_           Shipping label        Open
    Change Fulfilled Order    commercial_invoice_ djn-form-row-last           Commercial invoice          Open

    Header link Admin         Sales order lines           Add another Sales order line

    Change Fulfilled Order    quantity                  Quantity                1
    Change Fulfilled Order    client                    Client               ${client_name}
    Change Fulfilled Order    sku                       Sku                  ${sku_}
    Change Fulfilled Order    description               Description          ${desc_}
    Change Fulfilled Order    gross_weight              Gross weight         7.00
    Change Fulfilled Order    gross_length              Gross length         333.00
    Change Fulfilled Order    gross_width               Gross width          111.00
    Change Fulfilled Order    gross_height              Gross height         222.00
    Logout Client

#### Master Carton

TC495 - Add Sales Order with Master carton
   [Tags]                             OrderStock
   ${id_master}=                              Get Rand ID       ${order_id}
   set suite variable                  ${id_order_master}        ${id_master}
   Login                               ${rand_client}         12345678
   Wait Until Page Contains            Dashboard
   Go To                               ${SERVER}/orders
   wait element and click              ${add}
   Valid Data Order                    ${id_order_master}   WMP YAMATO      ${sku_}        ${sku_}   Master carton
   wait until page contains             Order Saved Successfully
   Go To                                ${SERVER}/orders
   log to console                      ${id_order_master}
   show order                          FS           ${id_order_master}         WMP YAMATO      Pending Fulfillment
   ${id_fs_master}=                           Get Id Order
   log to console                      ${id_fs_master}
   set suite variable                  ${fsn_master}             ${id_fs_master}
   Logout Client

TC946 - Add stock adjustment for remove "out of stock"
   [Tags]                                Adjustment
   Go To                         ${ADMIN}stock_adjustment/stockadjustment/
    Login                          ${login_admin}         ${pass_admin}
   wait until page contains      Select stock adjustment to change
   Add Stock Adjustment          ${sku_}            ${sku_} -- Master carton
   ${status}=                     Get Id Adjustment         Draft
   log to console                 ${status}
   wait until page contains      The stock adjustment "${status}" was added successfully
   Approve stock adjustment        ${status}
   wait until page contains      ${status} successfully set to Approved
   Logout Client

TC948 - Check product after adding stock adjustment
    [Tags]                             FinfProduct
   go to                               ${SERVER}/inventory/products
   Login                               ${rand_client}             12345678
   Find Product Stock                  ${sku_}            36

TC949 - Check order after adding stock adjustment
  [Tags]                               FindOrderStatus
   Go To                               ${SERVER}/orders
   Wait Until Page Contains            Dashboard
   Does not find Out of Stock           	${fsn_master}              Out of stock
   Find Product Stock                   	${fsn_master}           Pending Fulfillment
   Logout Client


TC497 - Check order in the list of orders as admin - master carton
   [Tags]                             CheckOrder
   Go To                              ${ADMIN}orders/salesorder/
   Login                              ${rand_staff}              12345678
   wait until page contains           Select sales order to change
   Check Item in Search                        ${fsn_master}
   Check Data Order                   ${fsn_master}     ${id_order_master}              Pending Fulfillment             WMP YAMATO
   Logout Client


TC498 - Open order for check as admin
   [Tags]                             CheckOrder
   Go To                              ${SERVER}/orders
   Login                             ${rand_client}         12345678
   wait until page contains           Order List
   show order                         ${fsn_master}     ${id_order_master}     WMP YAMATO     Pending Fulfillment
   Logout Client

TC499 - Mark order as fulfilled - master carton
     [Tags]                           Mark
     Go To                     ${ADMIN}orders/warehousependingfulfillmentorder/
     Login                        ${rand_3pl_client}           12345678
     Check Item in Search                        ${fsn_master}
     Sleep                      30 sec
     reload page
     Check Data fulfilled                    ${fsn_master}           	 ${id_order_master}          Pending Fulfillment        WMP YAMATO
     Mark                           Mark as fulfilled
     wait until page contains        Orders have been updated
     Check does not Data fulfilled         ${fsn_master}          	 ${id_order_master}          Pending Fulfillment        WMP YAMATO

TC500 - Check fulfillment order - master carton
    [Tags]                            CheckFullOrder
    go to                     ${ADMIN}
    Mouse over and Click             Order                 /admin-backend/orders/warehousefulfilledorder/
    Check Data fulfilled                    ${fsn_master}           	 ${id_order_master}          Fulfilled        WMP YAMATO
    Open Check Order                ${fsn_master}
    Change Fulfilled Order    tax_paid_by_             Tax paid by          DDU
    Header link Admin         Shipping Info            Courier Service
    Change Fulfilled Order    ship_via                 Courier Service        WMP YAMATO
    Header link Admin         Shipping Address         Shipping address :
    Change Fulfilled Order    shipping_address_        Name                  ${first name}${last name}
    Change Fulfilled Order    shipping_address_        Address               ${address_1}
    Change Fulfilled Order    shipping_address_        Country               ${country}
    Change Fulfilled Order    shipping_address_        City                  ${city}
    Change Fulfilled Order    shipping_address_        State                 ${state}
    Change Fulfilled Order    shipping_address_        Postal Code           ${post_code}
    Change Fulfilled Order    shipping_address_        Phone                 ${phone}

    Header link Admin         Packages                  Packaging item
    Change Fulfilled Order    packaging_item            Packaging item       SHIP-READY -- Packaging Item - No Product
    Change Fulfilled Order    length_                   Length               20 cm
    Change Fulfilled Order    width_                    Width                20 cm
    Change Fulfilled Order    height_                   Height               100 cm
    Change Fulfilled Order    weight_                   Weight               13.000 kg
    Change Fulfilled Order    tracking_number           Tracking number      ${fsn_master}
    Change Fulfilled Order    shipping_label_           Shipping label        Open
    Change Fulfilled Order    commercial_invoice_ djn-form-row-last           Commercial invoice          Open

    Header link Admin         Sales order lines           Add another Sales order line

    Change Fulfilled Order    quantity                  Quantity              1
    Change Fulfilled Order    client                    Client               ${client_name}
    Change Fulfilled Order    sku                       Sku                   ${sku_}
    Change Fulfilled Order    description               Description          ${desc_}
    Change Fulfilled Order    gross_weight              Gross weight         8.00
    Change Fulfilled Order    gross_length              Gross length         334.00
    Change Fulfilled Order    gross_width               Gross width          112.00
    Change Fulfilled Order    gross_height              Gross height         223.00
    Go To                      ${ADMIN}
    Logout Client
