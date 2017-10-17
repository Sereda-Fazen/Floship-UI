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


TC1069 - Create B2C Piece pick rates (empty fields)
    Go To                       ${ADMIN}rates/b2cpiecepickrate/
    wait until page contains        Select B2C Piece pick rate to change
    wait element and click          xpath=//a[contains(.,"Add B2C Piece pick rate")]
    wait until page contains        Add B2C Piece pick rate
    click button                    name=_save
    wait error this is required (Admin)         To value          This field is required
    wait error this is required (Admin)         Cost          This field is required
    wait error this is required (Admin)         Additional cost          This field is required

TC1070 - Create B2C Piece pick rates (invalid data)
    Go To                          ${ADMIN}rates/b2cpiecepickrate/add/
    wait until page contains        Add B2C Piece pick rate
    input text                      id=id_to_value                         abc
    click button                    name=_save
    wait error this is required (Admin)         To value          Enter a whole number

TC1068 - Create B2C Piece pick rates
    Go To                          ${ADMIN}rates/b2cpiecepickrate/add/
    wait until page contains       Add B2C Piece pick rate
    input text                     id=id_to_value                 4
    input text                     id=id_cost                     10
    input text                     id=id_additional_cost           20
    click button                    name=_save
    wait until page contains        The B2C Piece pick rate "4 rate: 10" was added successfully
    wait element and click          xpath=//a[contains(.,"Add B2C Piece pick rate")]
    wait until page contains        Add B2C Piece pick rate
    input text                     id=id_to_value                 20
    input text                     id=id_cost                     5
    input text                     id=id_additional_cost           8
    click button                   name=_save
    wait until page contains        The B2C Piece pick rate "20 rate: 5" was added successfully


TC1073 - Edit B2C Piece pick rates
    Go To                          ${ADMIN}rates/b2cpiecepickrate/
    wait until page contains       Select B2C Piece pick rate to change
    click exist b2c                   5           8
    wait until page contains       Change B2C Piece pick rate
     input text                    id=id_to_value                 20
    input text                     id=id_cost                     5
    input text                     id=id_additional_cost           8
    click button                   name=_save
    wait until page contains       The B2C Piece pick rate "20 rate: 5" was changed successfully

TC1073 - Exist B2C Piece pick rates
    Go To                          ${ADMIN}rates/b2cpiecepickrate/add/
    wait until page contains        Add B2C Piece pick rate
    input text                    id=id_to_value                 20
    click button                   name=_save
    wait error this is required (Admin)       To value      B2C Piece pick rate with this To value already exists
    Logout Client



TC1067 - Preparation. Step 1- Create order
    Go To                                ${SERVER}/inventory/products
    Login                              ${rand_client}               12345678
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

    ${id_order_cli}=                           Get Rand ID              ${order_id}
    log to console                         ${id_order_cli}
    Go To                                  ${SERVER}/orders
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
    logout client

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

   Go To                               ${SERVER}/orders
   Login                              ${rand_client}          12345678
   Wait Until Page Contains            Dashboard

   Approve Order                      ${fs_order_cl}       Approve
   Confirm Approve
   wait until page contains           Action was performed successfully
   Go To                              ${SERVER}/orders
   Find Order Change Status           ${fs_order_cl}       Pending Fulfillment
   Logout Client


TC1075 - Preparation. Step 2 - fulfill order
     [Tags]                           Mark
     Go To                     ${ADMIN}orders/warehousependingfulfillmentorder/
     Login                      ${rand_3pl_client}        12345678
     Check Item in Search                        ${fs_order_cl}
     Sleep                      30 sec
     reload page
     Check Data fulfilled                   ${fs_order_cl}         	${client_order}          Pending Fulfillment        WMP YAMATO
     Mark                           Mark as fulfilled
     wait until page contains        Orders have been updated
     Check does not Data fulfilled          ${fs_order_cl}         	${client_order}          Pending Fulfillment        WMP YAMATO
     Logout Client

TC600 - Upload file without Actual cost value
   Go To                        ${ADMIN}
   Login                         ${login_admin}         ${pass_admin}
   Mouse over and Click         Tools                          /admin-backend/tools/salesordercostupload/
   Check colums Sales order cost uploads     Title   Created at      Invoice date    Carrier invoice number     Courier     Amount     Entered in fp    Upload file    Status
   Check the fields in sales order cost upload      Invoice date    Carrier invoice number    Courier    Amount    Entered in fp   Errors    Upload file   Status
   Add sales order cost uploads                   1234          UPS          UPS
   ${actual_cost}=                 sales order cost               ${fs_order_cl}
   Upload File For Sales Order Cost      File_without_actual_cost.xlsx
   Sleep                            2 sec
   wait element and click           name=_save
   wait until page contains         The sales order cost upload "Upload
   ${file_name}=                   get element attribute                   xpath=//tr[@class="row1"]//a@text
   log to console                  ${file_name}
   set suite variable              ${update_file}                    ${file_name}

TC602 - Update Sales Order Cost Upload
   Go To                        ${ADMIN}tools/salesordercostupload/
   Generate report                 ${update_file}       Change sales order cost upload       Update Sales Order Cost Upload
   wait until page contains        The sales order cost upload "${update_file}" was changed successfully


TC1085 - Add Vendor bill upload (empty fields)
     Mouse over and Click                       Tools          /admin-backend/tools/vendorbillupload/
     wait until page contains                   Select vendor bill upload to change
     wait element and click                    xpath=//a[contains(.,"Add vendor bill upload")]
     wait until page contains                   Add vendor bill upload
     click button                  name=_save
     wait error this is required (Admin)          Courier          This field is required
     wait error this is required (Admin)          Bill date          This field is required
     wait error this is required (Admin)          Carrier invoice number          This field is required

TC1084 - Add Vendor bill upload
    Go To                         ${ADMIN}tools/vendorbillupload/add/
    wait until page contains           Add vendor bill upload
    Select Fields                   Courier             WMP YAMATO            WMP YAMATO
    Data Today                 1
    input text                  id=id_carrier_invoice_number                 123
    ${vendor_cost}=              vendor cost               ${fs_order_cl}
    choose file                xpath=//input[@type="file"]        ${CURDIR}/cost_sales_order/vendor_bill_template.csv
    Sleep                         3 sec
    click button                  name=_save
    wait until page contains        The vendor bill upload
    wait until page contains element                 xpath=//tr[@class="row1" and contains(.,"Pending")]//th/a

TC1086 - Update Vendor bill upload
    Go To                        ${ADMIN}tools/vendorbillupload/
    wait element and click         xpath=//tr[@class="row1" and contains(.,"Pending")]//th/a
    wait until page contains      Change vendor bill upload
    ${upload}=                      get text                xpath=//li[@class="active"]/span[contains(.,"Upload")]
    log to console                 ${upload}
     set suite variable         ${upload_vendor_bill}               ${upload}
    wait element and click        xpath=//input[contains(@value,"Update Vendor Bill Upload")]
    wait until page contains      The vendor bill upload
    Sleep                         3 sec
    Go To                        ${ADMIN}tools/vendorbillupload/
    wait until page contains element                 xpath=//tr[@class="row1" and contains(.,"Saved")]

TC601 - Check values for updated sales order
    Go To                          ${ADMIN}
    Mouse over and Click           Orders               /admin-backend/orders/salesorderaccountinginfo/
    wait until page contains       Select sales order accounting info to change
    Sales Order Cost in Table                  ${fs_order_cl}      10.00              4.20          3.10      	7.30        	2.70
    Open Check Order                ${fs_order_cl}
    Summary block (Order)              Pick and Pack                $ 10.00
    Summary block (Order)              Estimated	                $ 109.55
    wait until page contains element    xpath=//div[@class="panel-body"][contains(.,"Actual Weight") and contains(.,"7")]
    wait until page contains element    xpath=//div[@class="panel-body"][contains(.,"Total") and contains(.,"$ 10.00")]

TC1093 - Check Vendor bill item
    Go To                                     ${ADMIN}tools/vendorbillitem/
    wait until page contains                   Select vendor bill item to change
    Vendor bill item in Table      12345        ${fs_order_cl}     10    10      10        7.000         3.10       4.20

TC1097 - Add Vendor bill item (empty fields)
     Go To                         ${ADMIN}
     Mouse over and Click                       Tools          /admin-backend/tools/vendorbillitem/
     wait until page contains                   Select vendor bill item to change
     wait element and click                    xpath=//a[contains(.,"Add vendor bill item")]
     wait until page contains                   Add vendor bill item
     click button                  name=_save
     wait error this is required (Admin)          Bill          This field is required
     wait error this is required (Admin)          Bill reference          This field is required
     wait error this is required (Admin)          Order number          This field is required
     wait error this is required (Admin)          Tracking number          This field is required
     wait error this is required (Admin)          Length          This field is required
     wait error this is required (Admin)          Width          This field is required
     wait error this is required (Admin)          Height          This field is required
     wait error this is required (Admin)          Weight          This field is required
     wait error this is required (Admin)          Labor cost          This field is required
     wait error this is required (Admin)          Shipping cost          This field is required


TC1097 - Add Vendor bill item (invalid data)
    Go To                             ${ADMIN}tools/vendorbillitem/add/
    wait until page contains           Add vendor bill item
    input text                  id=id_length                 1.5
    input text                  id=id_width                 1.6
    input text                  id=id_height                 1.7
    input text                  id=id_weight                 1.8
    click button                  name=_save
    wait error this is required (Admin)          Length          Enter a whole number
    wait error this is required (Admin)          Width          Enter a whole number
    wait error this is required (Admin)          Height          Enter a whole number


TC1098 - Add Vendor bill item
    ${fs}=                        Get Rand ID       ${fo}
    ${refer_vendor}=                     Get Rand ID       123
    Go To                         ${ADMIN}tools/vendorbillitem/add/
    wait until page contains           Add vendor bill item
    Select Fields                   Bill                ${upload_vendor_bill}                   ${upload_vendor_bill}
    input text                  id=id_bill_reference             ${refer_vendor}
    input text                  id=id_order_number                ${fs}
    input text                  id=id_tracking_number              1234
    input text                  id=id_length                 1
    input text                  id=id_width                 2
    input text                  id=id_height                 3
    input text                  id=id_weight                 4
    input text                  id=id_labor_cost                 10
    input text                  id=id_shipping_cost                 20
    click button                  name=_save
    wait until page contains       The vendor bill item "VendorBillItem object" was added successfully
    Vendor bill item in Table      ${refer_vendor}         ${fs}     1    2      3        4         10       20
    set suite variable              ${edit_refer}           ${refer_vendor}
    set suite variable               ${fs_vendor}            ${fs}

TC1099 - Edit Vendor bill item
    Go To                                     ${ADMIN}tools/vendorbillitem/
    wait until page contains                   Select vendor bill item to change
    Open Check Order                ${edit_refer}
    wait until page contains         Change vendor bill item
    input text                  id=id_length                 1
    input text                  id=id_width                  2
    input text                  id=id_height                 3
    input text                  id=id_weight                 4
    click button                  name=_save
    wait until page contains      The vendor bill item "VendorBillItem object" was changed successfully
    Vendor bill item in Table      ${edit_refer}        ${fs_vendor}     1    2      3        4         10       20


TC1102 - Check costs for created order
   Go To                     ${ADMIN}orders/salesorder/
   wait until page contains        Select sales order to change
   Check Item in Search            ${fs_order_cl}
   show in table           ${fs_order_cl}          ${client_order}    	Fulfilled        Tracking integrations notified
   Open Check Order                ${fs_order_cl}
   wait until page contains          Order ${fs_order_cl} Details

    Check Package Item (Order)           Sku                  SHIP-READY
    Check Package Item (Order)           Dimensions                  System
    Check Package Item (Order)           Length                20
    Check Package Item (Order)           Width                20
    Check Package Item (Order)           Height                 100
    Check Package Item (Order)           Weight                5.1
    Check Package Item (Order)           Shipping Label                Download
    Check Package Item (Order)           Commercial Invoice               Download

    wait element and click           xpath=//a[contains(.,"System")]
    wait element and click           xpath=//div[@role="menu"]/a[contains(.,"Vendor")]

    Check Package Item (Order)           Sku                  SHIP-READY
    Check Package Item (Order)           Dimensions                  Vendor
    Check Package Item (Order)           Length                10
    Check Package Item (Order)           Width                10
    Check Package Item (Order)           Height                 10
    Check Package Item (Order)           Weight                7
    Check Package Item (Order)           Shipping Label                Download
    Check Package Item (Order)           Commercial Invoice               Download

    wait element and click           xpath=//a[@class="dropdown-toggle"]/span[contains(.,"Vendor")]
    wait element and click           xpath=//div[@role="menu"]/a[contains(.,"Warehouse")]

    Check Package Item (Order)           Sku                  SHIP-READY
    Check Package Item (Order)           Dimensions                  Warehouse
    Check Package Item (Order)           Length                N/A
    Check Package Item (Order)           Width                N/A
    Check Package Item (Order)           Height                 N/A
    Check Package Item (Order)           Weight                N/A
    Check Package Item (Order)           Shipping Label                Download
    Check Package Item (Order)           Commercial Invoice               Download


TC1071 - Delete B2C Piece pick rates
    Go To                     ${ADMIN}rates/b2cpiecepickrate/
   Open Check Order          5
   wait element and click     xpath=//a[contains(.,"Delete")]
   wait until page contains      Are you sure you want to delete the B2C Piece pick rate "20 rate: 5.00"?
   wait element and click       xpath=//*[@value="Yes, I'm sure"]
    wait until page contains        The B2C Piece pick rate "20 rate: 5.00" was deleted successfully

TC1072 - Delete B2C Piece pick rates (bulk action)
     Go To                     ${ADMIN}rates/b2cpiecepickrate/
     wait element and click          xpath=//tr[contains(.,"1") and contains(.,"4") and contains(.,"10") and contains(.,"20")]//../label
     wait until page contains        1 of
     Delete                     Delete selected B2C Piece pick rates


TC1095 - Delete Vendor bill item
   Go To                     ${ADMIN}tools/vendorbillitem/
  # Login                      ${login_admin}        ${pass_admin}
   Open Check Order           ${edit_refer}
   wait element and click     xpath=//a[contains(.,"Delete")]
   wait until page contains     Are you sure you want to delete the vendor bill item "VendorBillItem object
   wait element and click       xpath=//*[@value="Yes, I'm sure"]
    wait until page contains     The vendor bill item "VendorBillItem object" was deleted successfully


TC1096 - Delete Vendor bill item (bulk action)
     Go To                          ${ADMIN}tools/vendorbillitem/
     wait element and click          xpath=(//tr[contains(@class,"row")]//../label)[1]
     wait until page contains        1 of
     Delete                     Delete selected vendor bill items


TC1088 - Delete Vendor bill
   Go To                     ${ADMIN}tools/vendorbillupload/
   wait element and click    xpath=(//tr[contains(@class,"row")]//a)[1]
   wait element and click     xpath=//a[contains(.,"Delete")]
   wait until page contains     Are you sure you want to delete the vendor bill upload "${upload_vendor_bill}"
   wait element and click       xpath=//*[@value="Yes, I'm sure"]
    wait until page contains        The vendor bill upload "${upload_vendor_bill}" was deleted successfully.


TC1089 - Delete Vendor bill upload (bulk action)
     Go To                          ${ADMIN}tools/vendorbillupload/
     wait element and click          xpath=(//tr[contains(@class,"row")]//../label)[1]
     wait until page contains        1 of
     Delete                     Delete selected vendor bill uploads
