*** Settings ***
Documentation                           FloShip UI testing Admin part
Resource                                resource.robot
Suite Setup                             Setup Tests
Suite Teardown                          Close All Browsers

*** Test Cases ***

Create a new user and client
    [Tags]                        CreateUser
    ${email}=                     Get Email Client     ${client mail}
    set suite variable            ${rand_email}        ${email}
    log to console                ${rand_email}
    Login                         ${login_admin}        ${pass_admin}
    Wait Until Page Contains      Dashboard
    Capture Page Screenshot       ${TEST NAME}-{index}.png

    Go To                         ${ADMIN}auth/user/
    Invalid User Name         test @.        Enter a valid username. This value may contain only letters, numbers and @/./+/-/_ characters.      This field is required

    ${name}=                    Get Rand ID          FName_
    ${lname}=                    Get Rand ID          LName_
    set suite variable          ${ch_name}        ${name}
    set suite variable          ${ch_lname}       ${lname}
    Create User                   ${rand_email}              12345678             12345678
    wait until page contains      The user "${rand_email}" was added successfully. You may edit it again below.
    Settings User                ${ch_name}    	${ch_lname}        ${rand_email}
    Select role (super user)
    wait until page contains      The user "${rand_email}" was changed successfully.

    ${client_}=                   Get Rand ID        ${client}
    ${rand_refer_client}=                Get Rand ID        ${refer}
    set suite variable            ${rand_client_name}    ${client_}
    log to console                ${rand_client_name}
    Go To                         ${ADMIN}floship/client/
    Create Client                ${rand_client_name}        ${rand_email}            ${rand_email}       ${rand_refer_client}
    wait until page contains      The client "${rand_client_name}" was added successfully

#################### Product (Admin)

TC612 - Create product (Out of Stock)
    ${sku}=                            Get Rand Sku
    ${desc}=                           Get Rand ID        ${sku_desc}
    set suite variable                 ${search_sku}        ${sku}
    set suite variable                 ${search_desc}       ${desc}
    Go To                             ${ADMIN}inventory/product/add/
    Create Product Admin                   ${rand_client_name}             ${search_sku}          ${search_desc}
    Add SKU and Item for Product (Admin)           ${rand_client_name}            ${search_sku}
    log to console                  ${search_sku}
    log to console                  ${search_desc}
    wait until page contains        The product "${search_desc}" was added successfully.
    Show Product                    ${search_sku}        ${search_desc}

TC614 - Edit product
    Go To                          ${ADMIN}inventory/product/
    Edit Product Admin             ${search_sku}      ${rand_client_name}             ${search_sku}          ${search_desc}
    wait until page contains        The product "${search_desc}" was changed successfully

#### Sales Order

TC1064 - Click on "Add Order" button
    [Tags]                             AdminSearch
    ${id_order_admin}                           Get Rand ID              ${order_id}
    log to console                         ${id_order_admin}
    set suite variable                      ${order_admin_id}             ${id_order_admin}
    Go to                               ${ADMIN}orders/salesorder/
    wait element and click              ${add}

    ## Check all checks to the order's page

    show status order               Tracking Number              N/A
    show status order               Source              N/A
    show status order               Courier              N/A
    show status order               Status              N/A
    check fields in order (item)            SKU
    check fields in order (item)            Unit Type
    check fields in order (item)            Unit Qty
    check fields in order (item)            Description
    check fields in order (item)            Customs Value
    check fields in order (item)            Qty
    check fields in order (item)            Total Qty
    check fields in order (item)            Stock

    check labels order                      Company
    check labels order                      Full Name *
    check labels order                      Address Line 1 *
    check labels order                      Address Line 2
    check labels order                      City *
    check labels order                      State/Province
    check labels order                      Postal Code *
    check labels order                      Country *
    check labels order                     Phone Number *
    check labels order                      Email
    check labels order                      Save to address book
    page should contain element              xpath=//a[contains(.,"Address Book")]
    check labels order                      Order ID *
    check labels order                      Insurance Value
    check labels order                      Courier *
    check labels order                      Client *

    check labels order                      Shipping Exceptions
    check labels order                      ThreePL Exceptions
    check labels order                      Reason Of Export
    check labels order                      Status Notes

    check labels order                      Pick pack cost
    check labels order                      Actual cost
    check labels order                      Estimated cost
    check labels order                      Fuel surcharge
    check labels order                      Actual weight

TC757 - Add Sales Order (empty fields)
    Save
    wait error this is required       order     shipping_address.addressee                              This field is required
    wait error this is required       order     shipping_address.address_1                              This field is required
    wait error this is required       order     shipping_address.city                              This field is required
    wait error this is required       order     shipping_address.postal_code                              This field is required
    wait error this is required       order     shipping_address.country                              This field is required
    wait error this is required       order     shipping_address.phone                              This field is required
    wait error this is required       order     client_po                              This field is required
    wait error this is required       order     ship_via_id                              This field is required
    wait until page contains element   xpath=//*[@ng-model="order.client_id"]/..//li[contains(.,"This field is required")]


TC734 - Add Sales Order with Base Item (out of stock)
    [Tags]                           OrderAdmin
    reload page
    Create Sales Order             ${phone}       ${order_admin_id}     ${rand_client_name}    	${search_sku}    ${search_sku}   Base Item
    wait until page contains             Order Saved Successfully
    Sleep                               30 sec
    Go To                                ${ADMIN}orders/salesorder/
    show in table                       ${order_admin_id}          WMP YAMATO        Pending Approval        ${rand_client_name}
    ${get_fs_order}=                      Get Smt
    set suite variable                 ${get_fs}           ${get_fs_order}

TC759 - Edit Sales Order (Add Costs)
   Go To                                 ${ADMIN}orders/salesorder/
   Search and Click Item                        ${order_admin_id}
   Edit Order                         ${order_admin_id}        ${search_sku}            Base Item      ${search_sku}
   wait until page contains element       xpath=//*[@ng-model="order.cost.pick_pack_cost"]
   input text                            xpath=//*[@ng-model="order.cost.pick_pack_cost"]                             40
   input text                            xpath=//*[@ng-model="order.cost.actual_cost"]                             100
   input text                            xpath=//*[@ng-model="order.cost.fuel_surcharge"]                             10
   input text                            xpath=//*[@ng-model="order.cost.actual_weight"]                             8
   wait element and click             xpath=//button[contains(.,"Save")]
   Sleep                                10 sec
   Go To                                ${ADMIN}orders/salesorder/
   wait until page contains             Select sales order to change
   Go To                                ${ADMIN}orders/salesorder/
   Check Item in Search                ${order_admin_id}
   show in table                     ${get_fs}         ${order_admin_id}         WMP YAMATO       Pending Approval

TC760 - Edit Sales Order (Add Packages)
   Go To                                 ${ADMIN}orders/salesorder/
   Search and Click Item                        ${order_admin_id}
   Edit Order                         ${order_admin_id}        ${search_sku}            Base Item      ${search_sku}
   wait element and click              xpath=//button[contains(.,"Add")]
   wait until page contains element    xpath=//input[@ng-model="package.length"]
   input text                         xpath=//input[@ng-model="package.length"]           20
   input text                         xpath=//input[@ng-model="package.width"]            15
   input text                         xpath=//input[@ng-model="package.height"]           10
   input text                         xpath=//input[@ng-model="package.weight"]            5
   wait element and click             xpath=//button[contains(.,"Save")]
   Sleep                                10 sec
   Go To                                ${ADMIN}orders/salesorder/
   wait until page contains             Select sales order to change
   Go To                                ${ADMIN}orders/salesorder/
   Check Item in Search                ${order_admin_id}
   show in table                     ${get_fs}         ${order_admin_id}         WMP YAMATO      Pending Approval


############  Stock Adjustment

TC735 - Add stock adjustment for remove "out of stock" exception - step 1
   [Tags]                                Adjustment
   Go To                         ${ADMIN}stock_adjustment/stockadjustment/
   wait until page contains      Select stock adjustment to change
   Add Stock Adjustment          ${search_sku}            ${search_sku} -- Base Item
   ${status}=                     Get Id Adjustment         Draft
   log to console                 ${status}
   wait until page contains      The stock adjustment "${status}" was added successfully
   set suite variable             ${get_status}            ${status}
   Approve stock adjustment        ${get_status}
   wait until page contains      ${get_status} successfully set to Approved

TC735 - Add stock adjustment for remove "out of stock" exception - step 2
   Go To                         ${ADMIN}inventory/product/
   Check Item in Search          ${search_sku}
   Check Data Row                ${search_sku}       ${search_desc}       ${rand_client_name}    1
   Go To                         ${ADMIN}stock_adjustment/stockadjustment/
   Check Item in Search         ${get_status}
   wait until page contains     1 stock adjustment
   check stock adjustment       ${get_status}              Approved


TC739 - Approve order with valid item
   [Tags]                             Approve
   Go To                                 ${ADMIN}orders/salesorder/
   Check Item in Search             ${get_fs}
   Open Check Order                 ${get_fs}
   wait until page contains    Order ${get_fs} Details
   wait element and click      xpath=//button[contains(.,"Approve")]
   Confirm Approve
   wait until page contains           Action was performed successfully
   Go To                              ${ADMIN}orders/salesorder/
   show in table                 ${get_fs}         ${order_admin_id}       WMP YAMATO        Pending Fulfillment


TC742 - Mark order as fulfilled
     [Tags]                           Mark
     Go To                     ${ADMIN}orders/warehousependingfulfillmentorder/
     Check Item in Search                       ${get_fs}
     Sleep                      30 sec
     reload page
     Check Data fulfilled                    ${get_fs}         	${order_admin_id}          Pending Fulfillment        WMP YAMATO
     Mark                           Mark as fulfilled
     wait until page contains        Orders have been updated
     Check does not Data fulfilled           ${get_fs}          	${order_admin_id}          Pending Fulfillment        WMP YAMATO
#