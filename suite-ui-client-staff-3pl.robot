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


TC826 - Preparing Product (create order with "Pending Approval" state as Client)
    Go To                                ${SERVER}/inventory/products
    Login                             ${rand_client}                12345678
    wait element and click             xpath=//a[contains(.,"Add Product")]
    wait until page contains            New Product
    ${sku}=                      Get Rand ID             ${sku}
    ${desc}=                     Get Rand ID             ${sku_desc}
    log to console              ${sku}
    log to console              ${desc}
    Valid Data                  ${sku}    ${desc}     test_desc       123456
    set suite variable         ${client_desc}         ${desc}
    set suite variable         ${client_sku}          ${sku}
    Save
    wait until page contains          Product ${client_sku}
#
#
TC826 - Preparing Two Orders (create order with "Pending Approval" state as Client)
    ${id_order_cli}=                           Get Rand ID              ${order_id}
    log to console                         ${id_order_cli}
    Go To                                  ${SERVER}/orders
    #Login                             client+gumotmyl@floship.com                   12345678
    wait element and click             xpath=//a[contains(.,"Add Order")]
    wait until page contains            New Order
    Valid Data Order          ${id_order_cli}   WMP YAMATO    ${client_sku}     ${client_sku}   Base Item
    wait until page contains             Order Saved Successfully
    Go To                                ${SERVER}/orders
    show order is created                ${id_order_cli}          WMP YAMATO        Pending Approval          Out of stock
    ${fs_cl}=                                Get Id Order
    log to console                       ${fs_cl}
    set suite variable                   ${fs_order_cl}           ${fs_cl}
    set suite variable                   ${client_order}       ${id_order_cli}

    ${id_order_cli_2}=                           Get Rand ID              ${order_id}
    log to console                         ${id_order_cli_2}
    Go To                                  ${SERVER}/orders
    wait element and click             xpath=//a[contains(.,"Add Order")]
    wait until page contains            New Order
    Valid Data Order          ${id_order_cli_2}   FAKE   ${client_sku}     ${client_sku}   Base Item
    wait until page contains             Order Saved Successfully
    Go To                                ${SERVER}/orders
    show order is created                ${id_order_cli_2}          FAKE        Pending Approval          Out of stock
    ${fs_cl_2}=                                Get Id Order
    log to console                       ${fs_cl_2}
    set suite variable                   ${fs_order_cl_2}           ${fs_cl_2}
    set suite variable                   ${client_order_2}       ${id_order_cli_2}

TC826 - Preparing Pending Approval(create order with "Pending Approval" state as Client)
   Go To                                ${SERVER}/orders
   Edit Order                          ${client_order}     ${client_sku}            Base Item      ${client_sku}
   input text                       xpath=//input[@ng-model="$ctrl.order.shipping_address.company"]              MyCompany
   input text                       xpath=//input[@ng-model="$ctrl.order.shipping_address.address_2"]              Street 2
   input text                       xpath=//input[@ng-model="$ctrl.order.shipping_address.email"]              test@test.com
   input text                       xpath=//input[@ng-model="$ctrl.order.insurance_value.amount"]               100
   click button                      Save
   wait until page contains            Order Saved Successfully
   Show data in order                 Company            MyCompany
    Show data in order                Full Name	         SteveVai
    Show data in order                Address	        Street 1
    Show data in order                Address           Street 2
    Show data in order               Phone	            1234567890
    Show data in order              Email	            test@test.com
    Show data in order              Floship ID	         ${fs_order_cl}
    Show data in order             Order ID	             ${client_order}
    Show data in order             Exceptions	         Out of stock
    Show data in order             Shipping Option             ${EMPTY}
    wait until page contains element          xpath=//tbody[contains(.,"${client_sku}")]
   wait element and click              xpath=//a[contains(.,"BACK TO ORDERS")]
   show order is created              ${client_order}         WMP YAMATO        Pending Approval          Out of stock
   reload page
   Logout Client

#TC887 - Preparing (create order with "Pending Approval" state as Staff User) - 1
#    ${id_staff}=                              Get Rand ID       ${order_id}
#    set suite variable                  ${id_order_staff}        ${id_staff}
#    Go To                         ${ADMIN}orders/salesorder/
#    Login                         ${rand_staff}        12345678
#    wait until page contains       Select sales order to change
#   wait element and click              ${add}
#   Valid Data Order                    ${id_order_staff}   ${edit_sku}   ${edit_sku}   Base Item
#   wait until page contains             Order Saved Successfully
#   Go To                                ${SERVER}/orders
#   log to console                      ${ADMIN}orders/salesorder/
#   show order                          FS           ${id_order_staff}          Pending Approval            Out of stock
#   ${id_fs}=                           Get Id Order
#   log to console                      ${id_fs}
#   set suite variable                  ${fsn}             ${id_fs}


TC887 - Preparing (create order with "Pending Approval" state as Staff User)
    Go To                         ${ADMIN}orders/salesorder/
    Login                      ${rand_staff}        12345678
    wait until page contains       Select sales order to change
    Check Item in Search          ${client_order}
    show in table                 ${fs_order_cl}        ${client_order}                Pending Approval        Pending Approval
    Open Check Order             ${client_order}
    wait until page contains element          xpath=//a[contains(@ng-if,"$ctrl.order.is_order_editable")]
    wait until page contains element         xpath=//button[contains(@ng-repeat,"action in actions")]
    wait until page contains element       xpath=//a[contains(.,"BACK TO ORDERS")]

    show status order               Status              Pending Approval
    Show data in order                 Company            MyCompany
    Show data in order                Full Name	         SteveVai
    Show data in order                Address	        Street 1
    Show data in order                Address           Street 2
    Show data in order               Phone	            1234567890
    Show data in order              Email	            test@test.com
    Show data in order             Client               ${client_name}
    Show data in order                Floship ID	      ${fs_order_cl}
    Show data in order               Order ID	            ${client_order}

    Show data in order             Crowdfunding Number	          -
    Show data in order             State	                   Pending Approval
    Show data in order             Tax Paid By	               DDU

    Show data in order             Reason Of Export	            Purchase
    Show data in order             Insurance Value	            $ 100.00
    Show data in order             Shipping Exceptions	         Out of stock
    Show data in order             Shipping Exceptions	         Out of stock
    Show data in order             Sent To 3pl	                 NO
    Show data in order             Is Workshop	                 NO
    #Show data in order             Order Type	                b2c

TC842 - Check links for “More” action
    reload page
    wait until page contains element       xpath=//a[contains(.,"More")]

TC878 - “Back ” from edit mode (Staff User)
   Go To                              ${ADMIN}orders/salesorder/
   Wait Until Page Contains      Dashboard
   Check Item in Search          ${client_order}
   show in table                 ${fs_order_cl}        ${client_order}               Pending Approval        Pending Approval
   Open Check Order             ${client_order}
   wait element and click             xpath=//a[contains(.,"Edit")]
   wait until page contains          Edit Order
   wait until page contains element      ${full_name_field_order}
   input text                       ${full_name_field_order}                  ${first name}${last name}
   input text                       ${address_1_field_order}                  ${address_1}
   input text                       xpath=//input[@ng-model="$ctrl.order.shipping_address.address_2"]              Stre
   click button                     Back
   wait until page contains element         css=ng-map.map > div:first-child


Logout from staff user (temporarily)
   Go To                               ${ADMIN}
   Logout Client

TC879 - “Back ” from edit mode (Client)
   Go To                                ${SERVER}/orders
   Login                             ${rand_client}                12345678
   Wait Until Page Contains      Dashboard
   Edit Order                          ${client_order}     ${client_sku}            Base Item     ${client_sku}
   input text                       xpath=//input[@ng-model="$ctrl.order.shipping_address.address_2"]              Stre
   click button                     Back
   wait until page contains element         css=ng-map.map > div:first-child

TC844 - “Cancel” action (Client)
   Go To                               ${SERVER}/orders
    wait element and click            xpath=//a[contains(.,"${client_order}")]
    wait until page contains element        xpath=//button[contains(@ng-repeat,"action in actions")]
    click button                    Cancel Order
    Confirm Cancel Order            Are you sure you want to perform "Cancel"? This action is not reversible
    wait until page contains        Action was performed successfully
    show status order               Status          Canceled
    wait element and click              xpath=//a[contains(.,"BACK TO ORDERS")]
    show order is created               ${client_order}         WMP YAMATO        Canceled          Out of stock
   Go To                               ${SERVER}/orders
   wait element and click            xpath=//a[contains(.,"${client_order}")]
   wait until page does not contain element        xpath=//button[contains(@ng-repeat,"action in actions")]
   wait until page does not contain element        xpath=//a[contains(@ng-if,"$ctrl.order.is_order_editable")]
   wait element and click              xpath=//a[contains(.,"BACK TO ORDERS")]

TC882 - Check link for "SKU" on the dashboard (Client)
   Go To                               ${SERVER}/orders
   wait element and click            xpath=//a[contains(.,"${client_order}")]
   wait element and click            xpath=//td/a[contains(.,"${client_sku}")]
   wait until page contains          Product ${client_sku}
   Go To                                ${SERVER}/orders
   Logout Client



TC881 - Check link for "SKU" on the dashboard (Staff User)
    Go To                         ${ADMIN}orders/salesorder/
    Login                         ${rand_staff}        12345678
    wait until page contains       Select sales order to change
    Check Item in Search          ${client_order}
    show in table                 ${fs_order_cl}       ${client_order}               Canceled         Canceled
    Open Check Order             ${client_order}

    wait until page does not contain element          xpath=//a[contains(@ng-if,"$ctrl.order.is_order_editable")]
    wait until page does not contain element         xpath=//button[contains(@ng-repeat,"action in actions")]
    wait until page contains element       xpath=//a[contains(.,"BACK TO ORDERS")]
    wait until page contains element       xpath=//a[contains(.,"More")]
    show status order               Status          Canceled
    Show data in order                 Company            MyCompany
    Show data in order                Full Name	         SteveVai
    Show data in order                Address	        Street 1
    Show data in order                Address           Street 2
    Show data in order               Phone	            1234567890
    Show data in order              Email	            test@test.com
    Show data in order             Client              ${client_name}
    Show data in order                Floship ID	         ${fs_order_cl}
    Show data in order               Order ID	             ${client_order}

    Show data in order             Crowdfunding Number	          -
    Show data in order             State	                   Canceled
    Show data in order             Tax Paid By	               DDU

    Show data in order             Reason Of Export	            Purchase
    Show data in order             Insurance Value	            $ 100.00
    #Show data in order             Order Type	                b2c

    wait until page contains element           xpath=//tbody/tr[contains(.,"Transaction Date")]/td[contains(@ng-bind,"order.create_date")]
    wait until page contains element           xpath=//tbody/tr[contains(.,"Update Date")]/td[contains(@ng-bind,"order.update_date")]
    wait until page contains element           xpath=//tbody/tr[contains(.,"Original Transaction Date")]/td[contains(@ng-bind,"order.original_transaction_date")]
    wait until page contains element           xpath=//tbody/tr[contains(.,"Approval Eligibility Date")]/td[contains(@ng-bind,"order.approval_eligibility_date")]

    wait until page contains element          xpath=//tbody[contains(.,"${client_sku}")]
    Logout Client

TC470 - Add stock adjustment for remove "out of stock" exception
   [Tags]                                Adjustment
   Go To                         ${ADMIN}stock_adjustment/stockadjustment/
   Login                         ${login_admin}        ${pass_admin}
   wait until page contains      Select stock adjustment to change
   Add Stock Adjustment          ${client_sku}                    ${client_sku} -- Base Item
   ${status}=                     Get Id Adjustment         Draft
   log to console                 ${status}
   wait until page contains      The stock adjustment "${status}" was added successfully
   Approve stock adjustment        ${status}
   wait until page contains      ${status} successfully set to Approved
   Logout Client


TC846 - Preparing (create order with "Pending Fulfillment" state as Client)
   Go To                             ${SERVER}/orders
   Login                             ${rand_client}                12345678
   Approve Order                      ${fs_order_cl_2}       Approve
   Confirm Approve
   wait until page contains           Action was performed successfully
   show status order               Status          Pending Fulfillment
   Show data in order             Exceptions               ${EMPTY}
   wait element and click         xpath=//a[contains(.,"BACK TO ORDERS")]
   Find Order Change Status           ${fs_order_cl_2}       Pending Fulfillment
   Does not find Out of Stock           	 ${fs_order_cl_2}              Out of stock
   click element                   xpath=//a[contains(.,"${fs_order_cl_2}")]
   wait until page does not contain element        xpath=//a[contains(.,"Edit")]
   wait until page does not contain element        xpath=//button[contains(.,"Cancel Order")]
   wait until page does not contain element        xpath=//button[contains(.,"Approve")]
   wait element and click         xpath=//a[contains(.,"BACK TO ORDERS")]
   reload page
   Logout Client


TC887 - Preparing (create order with "Pending Fulfillment" state as Staff User)
    Go To                         ${ADMIN}orders/salesorder/
    Login                      ${rand_staff}        12345678
    wait until page contains       Select sales order to change
    Sleep                         5 sec
    reload page
    Check Item in Search          ${client_order_2}
    show in table                 ${fs_order_cl_2}        ${client_order_2}                Pending Fulfillment        Pending fulfillment


TC849 - “Edit” action (Staff user)
   Open Check Order             ${client_order_2}
   wait until page contains element          xpath=//a[contains(.,"Edit")]
   wait until page contains element         xpath=//button[contains(.,"Cancel Order")]
   wait until page contains element        xpath=//button[contains(.,"Regenerate")]
   wait until page contains element       xpath=//a[contains(.,"BACK TO ORDERS")]
   wait until page contains element       xpath=//a[contains(.,"More")]
   wait element and click             xpath=//a[contains(.,"Edit")]
   wait until page contains          Edit Order
   input text                       xpath=//input[@ng-model="$ctrl.order.shipping_address.company"]              MyCompanyStaff
   input text                       xpath=//input[@ng-model="$ctrl.order.shipping_address.address_2"]              Street 2
   input text                       xpath=//input[@ng-model="$ctrl.order.shipping_address.email"]              test@test.com
   input text                       xpath=//input[@ng-model="$ctrl.order.insurance_value.amount"]               100
   input text                       xpath=//input[@ng-model="order.cost.actual_weight"]                        10

   click button                      Save
   wait until page contains            Order Saved Successfully
    show status order               Status              Pending Fulfillment
    Show data in order                 Company            MyCompanyStaff
    Show data in order                Full Name	         SteveVai
    Show data in order                Address	        Street 1
    Show data in order                Address           Street 2
    Show data in order               Phone	            1234567890
    Show data in order              Email	            test@test.com
    Show data in order             Client               ${client_name}
    Show data in order                Floship ID	      ${fs_order_cl_2}
    Show data in order               Order ID	            ${client_order_2}

    Show data in order             Crowdfunding Number	          -
    Show data in order             State	                   Pending Fulfillment
    Show data in order             Tax Paid By	               DDU

    Show data in order             Reason Of Export	            Purchase
    Show data in order             Insurance Value	            $ 100.00
    Show data in order             Order Type               	   b2c
    Show data in order             Shipping Exceptions	         Shipping Errors
    Show data in order             Sent To 3pl	                 NO
    Show data in order             Is Workshop	                 NO
    wait element and click         xpath=//a[contains(.,"BACK TO ORDERS")]
    wait until page contains        Select sales order to change


TC852 - Preparing (create order with "Generating shipping labels" state as Staff user)
    Go To                        ${ADMIN}orders/salesorder/
    Check Item in Search          ${client_order_2}
    show in table                 ${fs_order_cl_2}        ${client_order_2}                Pending Fulfillment        Pending fulfillment
    Open Check Order             ${client_order_2}
    wait until page contains element        xpath=//button[contains(.,"Regenerate")]
    wait element and click             xpath=//a[contains(.,"Edit")]
    wait element and click                 xpath=//div[@placeholder="Select or search a courier in the list..."]
    input text                      //input[@type="search"][@aria-label="Choose a Courier Service"]            WMP YAMATO
    sleep                           1 sec
    wait element and click       xpath=//div[@ng-show='$select.open']//div[@class='ng-binding ng-scope']
    wait element and click            xpath=//button[contains(.,"Save")]
    wait until page contains          Order Saved Successfully
    wait element and click        xpath=//button[contains(.,"Regenerate")]
    wait until page contains          Are you sure you want to perform "Regenerate"? This action is not reversible
    click button                      OK
    wait until page contains          Action was performed successfully
    show status order               Status              Pending Fulfillment
    show data in order              State	            Generating Shipping Labels
    #wait until page does not contain element             xpath=//div[@class="panel-body" and contains(.,"Shipping Exceptions") and contains(.,"Shipping Errors")]

    reload page
    wait until page contains element       xpath=//a[contains(.,"More")]
    wait element and click                  xpath=//a[contains(.,"BACK TO ORDERS")]
    wait until page does not contain element     xpath=//a[contains(.,"Edit")]

TC621 - Create item (cvs)
    ${sku}=                      Get Rand ID             ${sku}
    set suite variable           ${sku_role}               ${sku}
    log to console               ${sku_role}
    ${include_sku}=              include sku for role          ${sku_role}
    Check Item CSV Upload             for_roles_sku.csv       ${client_name}       Items Csv Upload
    wait until page contains       Items Csv Upload
    show buttons in bulk form           Valid 1    Invalid 0    All 1
    click element                  css=button.close > span
    wait element and click         xpath=//input[contains(@value,"Save Items Item Csv Upload")]
    wait until page contains       The item csv upload "${save_item_csv}" was changed successfully
    Sleep                          3 sec

    ${id_order}=                 Get Rand ID              ${order_id}
    set suite variable           ${order_role}               ${id_order}
    log to console               ${order_role}
    ${include_order}=            include order id for role       ${order_role}           ${sku_role}    Free Shipping
    Check Order CSV Upload       for_roles_order.csv      ${client_name}     Order Csv Upload
    #wait until page contains       Order Csv Upload
    show buttons in bulk form           Valid 1    Invalid 0    All 1
    click element                  css=button.close > span
    click element                  name=_save
    wait until page contains       The order csv upload "${save_item_csv}" was changed successfully
    show in table                  ${save_item_csv}       ${client_name}         Download           Valid
    Logout Client

TC470 - Add stock adjustment for remove "out of stock" exception
   [Tags]                                Adjustment
   Go To                         ${ADMIN}stock_adjustment/stockadjustment/
   Login                         ${login_admin}        ${pass_admin}
   wait until page contains      Select stock adjustment to change
   Add Stock Adjustment          ${sku_role}                    ${sku_role} -- Base Item
   ${status}=                     Get Id Adjustment         Draft
   log to console                 ${status}
   wait until page contains      The stock adjustment "${status}" was added successfully
   Approve stock adjustment        ${status}
   wait until page contains      ${status} successfully set to Approved
   Logout Client
#
#
#
TC962 - Preparing (create order with "Labels generated" state as Staff user - step 1)
    Go To                         ${ADMIN}
    Login                     staff+zcragksz@floship.com                   12345678
    Mouse over and Click               Orders                  /admin-backend/crowd_funding/crowdfundingorder/
    wait until page contains           Select crowd funding order to change
    Add report                   Add crowd funding order                 Add crowd funding order
    Select Fields                  Client              ${client_name}        ${client_name}
    Data Today                     1
    wait element and click            name=_save
    wait until page contains        The crowd funding order
    Show Product                   ${client_name}         Pending
    ${crowd}=                      get element attribute                  xpath=//*[@class="row1"]//a@text
    log to console                 ${crowd}
    set suite variable              ${crowd_}          ${crowd}


TC962 - Preparing (create order with "Labels generated" state as Staff user - step 2)
    ${crowd_role}=                 include data crowd          ${order_role}                ${sku_role}
    Go To                          ${ADMIN}crowd_funding/crowdfundingorder/
    wait element and click         xpath=//*[@class="row1"]//a[contains(.,"${crowd_}")]
    Header link Admin              Order csv uploads             Add another Order csv upload
    click element                  xpath=//a[contains(.,"Add another Order csv upload")]
    choose file                    xpath=//input[@type="file"]                 ${CURDIR}/crowd.csv
    Select Client Crowd            ${client_name}
    wait until page contains       Remove
    wait element and click         name=_save
    wait until page contains       The crowd funding order "${crowd_}" was changed successfully.
    Show Product                   ${client_name}         Pending

TC823 - Preparing (create order with "Labels generated" state as Staff user - step 3)
    Go To                            ${ADMIN}orders/ordercsvupload/
    wait until page contains         Select order csv upload to change
    wait element and click        xpath=//tr[@class="row1" and contains(.,"${client_name}") and contains(.,"Pending")]/..//a[contains(.,"Upload")]
    wait element and click        name=_fsmtransition-status-validate
    wait until page contains     The order csv upload
    Sleep                          3 sec
    wait element and click        xpath=//tr[@class="row1" and contains(.,"${client_name}")]/..//a[contains(.,"Upload")]
    sleep                          2 sec
    execute javascript             jQuery("input[name=_fsmtransition-status-save_orders]").click();
    wait until page contains       The order csv upload

    Go To                          ${ADMIN}orders/salesorder/
    wait until page contains       Select sales order to change
    Sleep                          5 sec
    Check Item in Search          ${order_role}
    wait element and click         xpath=//tr[@class="row1" and contains(.,"${client_name}")]/..//a[contains(.,"${order_role}")]
    wait element and click         xpath=//a[contains(.,"Edit")]
    wait until page contains                               This field can't be blank
    Select Post Order              WMP YAMATO
    click button                      Save
    wait until page contains       Order Saved Successfully
    wait element and click              xpath=//a[contains(.,"BACK TO ORDERS")]

    Go To                          ${ADMIN}crowd_funding/crowdfundingorder/
    wait element and click         xpath=//*[@class="row1"]//a[contains(.,"${crowd_}")]
    wait element and click          name=_fsmtransition-status-approve
    wait until page contains        ${crowd_} successfully set to Approved
#


TC854 - Preparing (create order with "Labels generated" state as Staff user - step 4)
    Go To                          ${ADMIN}orders/salesorder/
    wait until page contains       Select sales order to change
    Sleep                          15 sec
    Check Item in Search          ${order_role}
    show in table                 ${order_role}                Pending Fulfillment        Labels Generated        ${client_name}

    Open Check Order             ${order_role}
    wait until page contains element          xpath=//a[contains(.,"Edit")]
    wait until page contains element         xpath=//button[contains(.,"Cancel Order")]
    wait until page contains element        xpath=//button[contains(.,"Regenerate")]
    wait until page contains element       xpath=//a[contains(.,"BACK TO ORDERS")]
    wait until page contains element       xpath=//a[contains(.,"More")]

    show status order               Status              Pending Fulfillment
    Show data in order             State	            Labels Generated

TC859 - “Regenerate” action (Staff user)
    wait element and click               xpath=//button[contains(.,"Regenerate")]
    wait until page contains          Are you sure you want to perform "Regenerate"? This action is not reversible
    click button                      OK
    wait until page contains          Action was performed successfully
    show status order               Status              Pending Fulfillment
    show data in order              State	            Generating Shipping Labels
    Sleep                           30 sec
    reload page
    show data in order              State	            Labels Generated
    Go To                           ${ADMIN}



TC867 - Preparing (create order with "Sent to 3PL" state)
    Go To                        ${ADMIN}orders/salesorder/
    Check Item in Search          ${client_order_2}
    show in table                 ${fs_order_cl_2}        ${client_order_2}                Pending Fulfillment        3PL
#    wait until page contains element                          xpath=//tr[@class="row1"][contains(.,"${fs_order_cl_2}") and contains(.,"Sent to 3PL") or contains(.,"Notifying 3pl")]
    Open Check Order             ${client_order_2}
    wait until page contains element        xpath=//button[contains(.,"Regenerate")]
    wait until page contains element        xpath=//a[contains(.,"Edit")]
    wait until page contains element        xpath=//button[contains(.,"Send Warehouse Documents")]
    wait until page contains element        xpath=//button[contains(.,"Cancel Order")]
    wait until page contains element        xpath=//a[contains(.,"BACK TO ORDERS")]
    wait until page contains element        xpath=//a[contains(.,"More")]


    show status order               Status              Pending Fulfillment
    Show data in order                 Company            MyCompanyStaff
    Show data in order                Full Name	         SteveVai
    Show data in order                Address	        Street 1
    Show data in order                Address           Street 2
    Show data in order               Phone	            1234567890
    Show data in order              Email	            test@test.com
    Show data in order             Client               ${client_name}
    Show data in order                Floship ID	      ${fs_order_cl_2}
    Show data in order               Order ID	            ${client_order_2}

    Show data in order             Crowdfunding Number	          -
    Show data in order             State	                   Sent To 3pl
    Show data in order             Tax Paid By	               DDU

    Show data in order             Reason Of Export	            Purchase
    Show data in order             Insurance Value	            $ 100.00
    Show data in order             Order Type               	   b2c
    Show data in order             Sent To 3pl	                 YES
    Show data in order             Is Workshop	                 NO


TC869 - “Edit” action (Staff user)
    Go To                        ${ADMIN}orders/salesorder/
    wait element and click             xpath=//a[contains(.,"${client_order_2}")]
    Wait Element And Click                xpath=//a[contains(.,"Edit")]
    wait until page contains element      xpath=//button[contains(.,"Save")]
    input text                            xpath=//input[@ng-model="$ctrl.order.shipping_address.company"]              MyCompanyStaffSentTo3pl
    input text                            xpath=//*[@ng-model="order.cost.pick_pack_cost"]                             1
    input text                            xpath=//*[@ng-model="order.cost.actual_cost"]                             1
    input text                            xpath=//*[@ng-model="order.cost.fuel_surcharge"]                             1
    input text                            xpath=//*[@ng-model="order.cost.actual_weight"]                             1
    wait until page contains element      xpath=//button[contains(.,"Save")]
    click button                          Save
    wait until page contains            Order Saved Successfully
    Show data in order                 Company            MyCompanyStaffSentTo3pl

TC870 - “Regenerate” action (Staff user)
    reload page
    wait element and click               xpath=//button[contains(.,"Regenerate")]
    wait until page contains          Are you sure you want to perform "Regenerate"? This action is not reversible
    click button                      OK
    wait until page contains          Action was performed successfully
    show status order               Status              Pending Fulfillment
    show data in order              State	            Generating Shipping Labels
    Sleep                           30 sec
    reload page
    show data in order              State	            Sent To 3pl

TC872 - “Sent warehouse documents” action (Staff user)
    wait element and click               xpath=//button[contains(.,"Send Warehouse Documents")]
    wait until page contains          Are you sure you want to perform "Send Warehouse Documents"? This action is not reversible
    click button                      OK
    wait until page contains          Action was performed successfully
    show data in order            State	                 Notifying 3pl
    wait until page contains element        xpath=//button[contains(.,"Regenerate")]
    wait until page does not contain element        xpath=//a[contains(.,"Edit")]
    wait until page does not contain element        xpath=//button[contains(.,"Send Warehouse Documents")]
    wait until page does not contain element        xpath=//button[contains(.,"Cancel Order")]
    wait until page contains element        xpath=//a[contains(.,"BACK TO ORDERS")]
    wait until page contains element        xpath=//a[contains(.,"More")]
    Sleep                              20 sec
    reload page
    show data in order            State	                 Sent To 3pl
    wait until page contains element        xpath=//button[contains(.,"Regenerate")]
    wait until page contains element       xpath=//a[contains(.,"Edit")]
    wait until page contains element        xpath=//button[contains(.,"Send Warehouse Documents")]
    wait until page contains element        xpath=//button[contains(.,"Cancel Order")]
    wait until page contains element        xpath=//a[contains(.,"BACK TO ORDERS")]
    wait until page contains element        xpath=//a[contains(.,"More")]
    Logout Client


TC477 - Mark order as fulfilled (3pl user)
     [Tags]                           Mark
     Go To                     ${ADMIN}orders/warehousependingfulfillmentorder/
     Login                               ${rand_3pl_client}               12345678
     Check Item in Search                      ${client_order_2}
     Check Data fulfilled                    FS         	${client_order_2}          Pending Fulfillment        WMP YAMATO
     Mark                           Mark as fulfilled
     wait until page contains        Orders have been updated
     Check does not Data fulfilled          FS          	${client_order_2}          Pending Fulfillment        WMP YAMATO


TC876 - “Edit” action (3PL User)
     Go To                      ${ADMIN}
     wait until page does not contain element            xpath=//a[@href="/admin-backend/orders/salesorder/"]
     wait until page contains element                    xpath=//a[@href="/admin-backend/orders/warehousependingfulfillmentorder/"]
     Logout Client


TC874 - Preparing (create order with "Fulfilled" state)
    Go To                         ${ADMIN}orders/salesorder/
    Login                      ${rand_staff}        12345678
    wait until page contains       Select sales order to change
    Check Item in Search          ${client_order_2}
    show in table                 ${fs_order_cl_2}        ${client_order_2}                Fulfilled        Tracking integrations notified
    Open Check Order             ${client_order_2}
    wait until page contains element          xpath=//a[contains(.,"Edit")]
    wait until page does not contain element         xpath=//button[contains(.,"Cancel Order")]
    wait until page contains element        xpath=//a[contains(.,"Tracking Info")]
    wait until page does not contain element        xpath=//button[contains(.,"Regenerate")]
    wait until page contains element       xpath=//a[contains(.,"BACK TO ORDERS")]
    wait until page contains element       xpath=//a[contains(.,"More")]
    #wait element and click             xpath=//a[contains(.,"Edit")]

    show status order               Status              Fulfilled
    show data in order              State	            Tracking Integrations Notified

TC886 - Check Tracking info (Staff User)
    wait element and click            xpath=//a[contains(.,"Tracking Info")]
    wait until page contains          Order ${fs_order_cl_2}
    Show processing by tracking number         Shipped          In Transit     Delivered
    click button                      Back
    wait until page contains          Order ${fs_order_cl_2} Details
    Logout Client


TC875 - “Edit” action (Client) after Fulfilled
     Go To                             ${SERVER}/orders
     Login                             ${rand_client}                12345678
     Show data in order                ${client_order_2}                 Fulfilled
     wait element and click            xpath=//a[contains(.,"${client_order_2}")]

     wait until page contains element        xpath=//a[contains(.,"Tracking Info")]
     wait until page contains element        xpath=//a[contains(.,"BACK TO ORDERS")]
     wait until page does not contain element        xpath=//a[contains(.,"Edit")]
     show status order               Status              Fulfilled
     wait element and click                      xpath=//a[contains(.,"BACK TO ORDERS")]
     Show data in order                ${client_order_2}                 Fulfilled

TC885 - Check Tracking info (Client)
     Go To                             ${SERVER}/orders
     Search in Client                  ${client_order_2}
     Show data in order                ${client_order_2}                 Fulfilled
     wait element and click            xpath=//tbody//td//a[contains(@href,"/tracking") and contains(.,"${fs_order_cl_2}")]
     wait until page contains          Order ${fs_order_cl_2}
     Show processing by tracking number         Shipped          In Transit     Delivered
     click button                      Back
     wait until page contains          Order ${fs_order_cl_2} Details
     #Logout Client





