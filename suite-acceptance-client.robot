*** Settings ***
Documentation                           FloShip UI testing Client part
Resource                                resource.robot
Suite Setup                             Setup Tests
Suite Teardown                          Close All Browsers
#test



*** Test Cases ***
TC195 - Login in Admin Panel (valid)
    ${email}=                          Get Email
    Set Suite Variable                  ${REG_EMAIL}                ${email}
    Login                               ${login_admin}        ${pass_admin}
    Wait Until Page Contains            Dashboard
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Wait Until Element Is Visible       ${Add user}
    click element                       ${Add user}

TC196 - Create a new client in Admin panel
    Create a new user                   ${REG_EMAIL}              user_12345
    Payment                             100
    Wait Until Page Contains            User ${REG_EMAIL} is created
    log to console                      ${REG_EMAIL}
    Capture Page Screenshot             ${TEST NAME}-{index}.png

TC197 - Logout in Admin Panel
    Logout Client
    Wait Until Page Contains Element       xpath=//h3[contains(.,"Login")]
    Capture Page Screenshot             ${TEST NAME}-{index}.png

TC523,TC524, TC526 - Create password as a user
    [Tags]                              ResetPass
    Go To                               ${SERVER}
    Wait Until Page Contains Element    xpath=//h3[contains(.,"Login")]
    click Element                       xpath=//div[@class="form-group"]//a[contains(.,"Forgot")]
    Wait Until Page Contains            Password reset
    Capture Page Screenshot             ${TEST NAME}-{index}.png

TC525 - Create password as a user - Invalid passwords
    [Tags]                             InvalidPass
    Invalid Email - Reset Password      test@test                Enter a valid email address

TC527 - Create password as a user - Success

    Input text                          name=email                    ${REG_EMAIL}
    Click Button                        Reset my password
    Wait Until Page Contains            Password reset sent
    Capture Page Screenshot             ${TEST NAME}-{index}.png

    Open Mailbox                        host=${MAIL_HOST}       user=${MAIL_USER}          password=${MAIL_PASSWORD}
    ${LATEST}=	             Wait for Mail	        	    recipient=${REG_EMAIL}	       timeout=200
    ${body}=	             get email body	       ${LATEST}
    #log to console           ${body}
    ${pass_link}=	             Get Mail link Gmail  	      ${body}    /password/reset       \r\n      ${SERVER}/password/reset
    log to console           ${pass_link}
    #Delete Email                         ${LATEST}
    Close Mailbox
    Go To                               ${pass_link}
    Reset Password                      Enter new password      ${reset_pass}       ${reset_pass}             Password reset complete
    set suite variable                  ${REG PASS}             ${reset_pass}
    Click Element                       ${Log in}
    Wait Until Page Contains Element    xpath=//h3[contains(.,"Login")]
    Login                               ${REG EMAIL}        ${REG PASS}
    wait until page contains            Company Details
    wait until page contains            Company Address
    Capture Page Screenshot             ${TEST NAME}-{index}.png

Password reset unsuccessful
    [Tags]                    Pass
    Open Mailbox                        host=${MAIL_HOST}       user=${MAIL_USER}          password=${MAIL_PASSWORD}
    ${LATEST}=	             Wait for Mail	        	    recipient=${REG_EMAIL}	       timeout=10
    ${body}=	             get email body	       ${LATEST}
    #log to console           ${body}
    ${pass_link}=	             Get Mail link Gmail  	      ${body}    /password/reset       \r\n      ${SERVER}/password/reset
    log to console           ${pass_link}
    Delete Email                         ${LATEST}
    Close Mailbox
    Go To                               ${pass_link}
    wait until page contains           Password reset unsuccessful

TC293 - Login as a user
    [Tags]                              Register
    Go To                               ${SERVER}
    ${rand_company}=                    Get Rand Company
    log to console                      ${rand_company}
    set suite variable                  ${get_company}            ${rand_company}
    wait until page contains            Company Details
    wait until page contains            Company Address

TC297 - Register new client - Enter data (valid)
    ##Normal data
    Full Valid Data                 ${get_company}        ${REG_EMAIL}
    wait until page contains         Welcome
    # Payment method

TC530 - Continue register new client (Terms of Service) - Success
    Wait Element And Click              ${agree}
    click button                        Continue


TC300 - Continue register (Payment Method) - Enter data (valid)
    Create Card Number                  ${card num}       ${exp date}           ${cvv}
    click button                     Continue


TC508,TC509 - Continue register (Prepayment Method)
    Check Payment Request               Pre-payment Request             $100.00 USD
    wait until page contains            We are preparing your warehouse
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    delete all cookies


Account Registration Completed
    [Tags]                        Welcome
    Open Mailbox                        host=${MAIL_HOST}       user=${MAIL_USER}          password=${MAIL_PASSWORD}
    ${LATEST}=	             Wait for Mail	        	    recipient=${REG_EMAIL}	       timeout=30
    ${HTML}=	      get email body	${LATEST}
    should contain        "${HTML}"      A notification will be sent to you within 24 hours once your warehouse assignment is completed
    Delete Email                         ${LATEST}
    Close Mailbox

Welcome to Floship
    [Tags]                        Welcome
    Open Mailbox                        host=${MAIL_HOST}       user=${MAIL_USER}          password=${MAIL_PASSWORD}
    ${LATEST}=	             Wait for Mail	        	    recipient=${REG_EMAIL}	       timeout=30
    ${HTML}=	      get email body	${LATEST}
    should contain        "${HTML}"      Dear user_12345!
    should contain        "${HTML}"      Welcome to Floship! Thanks so much for joining us
    should contain        "${HTML}"      Your username is: ${REG_EMAIL}
    ${pass_link}=	             Get Mail link Gmail  	      ${HTML}    /password/reset       \r\n      ${SERVER}/password/reset
    log to console           ${pass_link}
    Delete Email                         ${LATEST}
    Close Mailbox


TC301 - Login to Administration page
    [Tags]                             NewCompany
    Go To                               ${SERVER}
    Login                               ${login_admin}        ${pass_admin}
    Wait Until Page Contains             Dashboard
    Capture Page Screenshot              ${TEST NAME}-{index}.png

TC302 - TC307 - Search company in Administration page in Flochip>Clients section
    ${rand_refer_client}=                Get Rand ID        ${refer}
    Search New Company In Admin Panel    Onboarding 3pl Step        ${get_company}       Braintree       ${rand_refer_client}
    wait until page contains             The client "${get_company}" was changed successfully.
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    delete all cookies









TC309 - TC310 - Click "Add Product" on the "Product List" page
    Go To                                ${SERVER}
    Login                             ${REG EMAIL}               12345678
    Add New Product                     Add Product
    wait until page contains            New Product
    # required fields

TC311 - Add new product - Enter data (valid)
    ${sku}=                      Get Rand ID             ${sku}
    ${desc}=                     Get Rand ID             ${sku_desc}
    log to console              ${sku}
    log to console              ${desc}
    reload page
    Valid Data                      ${sku}    ${desc}     test_desc       123456
    set suite variable         ${edit_desc}         ${desc}
    set suite variable         ${edit_sku}          ${sku}
    Save

TC536 - Edit product
    Edit Product                     ${edit_sku}   ${edit_desc}
    wait element and click           xpath=//button[contains(.,"Close")]


TC335 - Go to "Address Book" page
# Add New Address
    [Tags]                            Address
    Go To                               ${SERVER}/address-book
    wait element and click              xpath=//a[contains(.,"Add Address")]

TC338 - Add new address - Enter data (valid)
    Valid Data Address Book

TC568 - Change address
   Go To                              ${SERVER}/address-book
   Edit Address                      ${first name} ${last name}


Warehouse Assigned (check mail)
    [Tags]                        Welcome
    Open Mailbox                        host=${MAIL_HOST}       user=${MAIL_USER}          password=${MAIL_PASSWORD}
    ${LATEST}=	             Wait for Mail	        	    recipient=${REG_EMAIL}	       timeout=30
    ${HTML}=	      get email body	${LATEST}
    should contain        "${HTML}"      The warehouse address where you should send your product to is listed below
    Delete Email                         ${LATEST}
    Close Mailbox


##ASN

TC313,TC314 Click "Add ASN" in the "Advanced Shipping Notice List" page
    [Tags]                              ASN
    Go To                               ${SERVER}
    Header title block                  Advanced Shipping Notice
    click Add new                       Add ASN

TC1111 - TC1112 - Check Warehouse local address

    wait until page contains             New ASN
    wait until page contains             140 Link Road, , Mongkok, Hong Kong 12345, HK
    wait until page contains             仓库本地地址18

TC315,TC317 - Add new ASN- Enter data and choose address from address book (valid)
    reload page
    Valid Data ASN Address               ${first name}   ${post_code}          ${edit_sku}          FASN
    ${id_ship}=                         Get Id ASN
    log to console                      ${id_ship}
    set suite variable                  ${asn_id}               ${id_ship}

TC503 - Edit ASN
    [Tags]                              EditAsn
    Go To                               ${SERVER}/advanced-shipping-notices
    #Edit ASN                            ${asn_id}    ${long_symbols_255}     ${long_symbols_255} 	${edit_sku}         ${asn_id}
    Edit ASN                            ${asn_id}    ${first name}     ${state} 	${edit_sku}         ${asn_id}

TC320,TC321 - Click "Add Shipping Option" button
    Go To                               ${SERVER}
    Header link                         Shipping Options
    wait element and click              xpath=//a[contains(.,"Add Shipping Option")]

TC322 - Add new Shipping Option - Enter data (valid)
    ${ship_op}=                        Get Rand ID            ${shipping_name}
    log to console                     ${ship_op}
    Valid Data Shipping                ${ship_op}      ${select_all_counties}      WMP YAMATO
    set suite variable                 ${edit_ship}         ${ship_op}

TC831 - Edit Shipping Option
    Go To                              ${SERVER}/shipping-options
    Edit Shipping Options             ${edit_ship}


# Add Group Items

TC542,TC543 - Click "Add Group Items" on the "Group Items List" page
    Go To                               ${SERVER}
    mouse over and click                 Inventory            /inventory/group-items
    wait element and click              xpath=//a[contains(.,"Add Group Items")]

TC327 - Add new Group Item - Enter data (valid)
    ${group_id_}=                         Get Rand ID       ${group}
    set suite variable                  ${id_group_variable}        ${group_id_}
    Valid Data Group Items         ${id_group_variable}      test     ${edit_sku}       ${edit_sku}

TC548 - Edit group items
   Go To                              ${SERVER}/inventory/group-items
   Edit Group Items                   ${id_group_variable}       test       ${edit_sku}       ${edit_sku}

TC331 - Click on "Add Order" button
    Go To                               ${SERVER}/orders
    wait element and click                     xpath=//a[contains(.,"Add Order")]
    wait until page contains         New Order

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


TC562 - Add new order - Enter data and choose address from address book (valid)
    ${id_order}=                           Get Rand ID              ${order_id}
    log to console                         ${id_order}
    Valid Data Order via Address          ${phone}       ${id_order}    ${edit_sku}     ${edit_sku}   Base Item    ${id_order}
    wait until page contains             Order Saved Successfully
    Go To                                ${SERVER}/orders
    show order is created                ${id_order}          WMP YAMATO        Pending Approval          Out of stock
    ${fs}=                   Get Id Order
    log to console                       ${fs}
    set suite variable                   ${fs_order}           ${fs}
    set suite variable                   ${edit_order}       ${id_order}

TC832 - Edit Order
   [Tags]                              EditOrder
   Go To                               ${SERVER}/orders
   Edit Order                           ${edit_order}     ${edit_sku}            Base Item      ${edit_sku}
   click button                      Save
   wait until page contains             Order Saved Successfully
   Go To                                ${SERVER}/orders
   show order is created                ${edit_order}          WMP YAMATO        Pending Approval          Out of stock


TC569,TC341-TC345 - Check "Orders" menu item
    Go To                              ${SERVER}
    Check Links Orders

TC347,TC570,TC348,TC349,TC571,TC572 - Open submenu of "Inventory" menu
    Check Links Inventory


TC351 - TC354 Open submenu of "Settings" menu
    Check Links Billing


## Shopify

TC355 - Open "Add Integration" menu
    Go To                    ${SERVER}
    wait until page contains     Dashboard
    Wait settings and Click                 Integration
TC356 - TC357 - Form "New Shopify Integration" - Empty fields
    Check Links in Shopify
TC965 - Form "New Shopify Integration" - Invalid data
    Check Enter data Integration        example123!@#.myshopify.com
    wait error this is required          shopify    shop_domain        shop domain is invalid, it can only contain any of the following characters
TC358 - Close "New Shopify Integration" form
   wait element and click               css=button.close > span


## Magento

TC359 - Open "Magento Integration" form
   Wait settings and Click                 Integration
TC360 - Form "Magento Integration" - Empty fields
   Check Links in Magento

TC970 - Form "Magento Integration" - Invalid data
    Check Enter data Integration Magento        example123!@#.myshopify.com          test         test
    wait error this is required     magento          shop_url      This field may not be blank
TC361 - Close "Magento Integration" form
    wait element and click               css=button.close > span

## Magento 2

TC362 - Open "Magento 2 Integration" form
   Wait settings and Click                 Integration
TC363 - Form "Magento 2 Integration" - Empty fields
   Check Links in Magento 2
TC966 - Form "Magento 2 Integration" - Invalid data
    Check Enter data Integration Magento 2        example123!@#.myshopify.com       test           test
    wait error this is required     magento2         base_url        Enter a valid URL
TC364 - Close "Magento 2 Integration" form
    wait element and click               css=button.close > span

##   Woocommerce

TC365 - Open "WooCommerce Integration" form
   Wait settings and Click                 Integration
TC366 - Form "WooCommerce Integration" - Empty fields
   Check Links in Woocommerce
TC967 - Form "WooCommerce Integration" - Invalid data
   Check Enter data Woocommerce        example123!@#.myshopify.com       test           test
   wait error this is required     woocommerce          shop_url      Enter a valid URL
TC367 - Close "WooCommerce Integration" form
   wait element and click               css=button.close > span

## Aftership


TC368 - Open "Aftership Integration" form
  Wait settings and Click                 Integration
TC369 - Form "Aftership Integration" - Empty fields
  Check Links in Aftership
TC370 - Close "Aftership Integration" form
   wait element and click               css=button.close > span

## Amason

TC968 - Open "Amazon Integration" form
    Wait settings and Click                 Integration
TC969 - Form "Amazon Integration" - Empty fields
    Check Links in Amason
TC1001 - Close "Amazon Integration" form
   wait element and click               css=button.close > span


## Shipstation

TC1002 - Open "ShipStation Integration" form
    Wait settings and Click                 Integration
TC1003 - Form "ShipStation Integration" - Empty fields
    Check Links in Shipstation

TC1004 - Close "ShipStation Integration" form
   wait element and click               css=button.close > span

TC372 - Open "Change password" page
    [Tags]                            ChangePassword
    Go To                             ${SERVER}
    wait until page contains          Dashboard
TC373 - Change password - Incorrect input of old password
    Old password incorectly           12345678         12345678

TC374 - Change password - Password do not match
    Password do not match             12345678         12345678

TC375 - Change password - Correct input
    Change Password                   12345678         qwerty123!          qwerty123!
    delete all cookies

TC376 - Login as a user with a wrong password
   [Tags]                            NewPass
    Go To                            ${SERVER}
    Login                           ${REG_EMAIL}        12345678
    wait until page contains         Login or password incorrect

TC377 - Login as a user with a right password
    Login                            ${REG EMAIL}         qwerty123!
    wait until page contains         Dashboard


####BULK UPLOAD


TC386 - Product bulk upload: successful upload
    #### PROD_1
    Go To                               ${SERVER}/inventory/products/bulk
    Bulk Upload                         Product Bulk Upload      product      original2.xlsx
    wait until page contains            File uploaded successfully

TC387 - Product bulk upload: successful upload - step 3: Save upload
    wait until page contains            Items Bulk Upload                       40 sec
    wait until page contains            All items are valid, you can view the data by clicking on "Valid" button below.
    show buttons in bulk form           Valid 6    Invalid 0    All 6

TC388 - Product bulk upload: successful upload - step 4: Confirm upload
    Confirm
    wait until page contains            Bulk upload was approved successfully               50 sec

TC411 - Product bulk upload: successful upload - step 5: Check uploaded product
    show in table bulk upload           PROD_1                          PROD_1
    check data                          SKU	                       PROD_1
    check data                          Description	               A product one
    check data                          Customs Description	       A product one
    check data                          Packaging Type	           Ship ready
    check data                          UPC/EAN/MPN	               1234567890
    check data                          Country of Manufacture	   CN
    check data                          Customs Value	           USD123.45

    check data                          Has Battery	               Yes
    check data                          Has Liquid	               No
    check data                          Has Expiry Date	           No
    check data                          Customs Value	           USD123.45

    check data                          Width	                   12.00 cm
    check data                          Height	                   8.00 cm
    check data                          Length	                   10.00 cm
    check data                          Weight	                   0.500 kg
    check new bulk upload               Base Item      1      PROD_1     Ship ready      12.00 cm         8.00 cm     10.00 cm      0.50 kg
    check new bulk upload               Inner Carton      10      PROD_1     Ship ready      30.00 cm         20.00 cm     20.00 cm      10.00 kg
    check new bulk upload               Master Carton      100      PROD_1     Ship ready      40.00 cm         40.00 cm     40.00 cm      20.00 kg
    wait element and click              css=button.close > span

    show in table bulk upload           PROD_2                     PROD_2
    check data                          SKU	                       PROD_2
    check data                          Description	               A product two
    check data                          Customs Description	       A product two
    check data                          Packaging Type	           Ship ready
    check data                          UPC/EAN/MPN	               1234567890
    check data                          Country of Manufacture	   CN
    check data                          Customs Value	           USD111.00

    check data                          Has Battery	               Yes
    check data                          Has Liquid	               No
    check data                          Has Expiry Date	           No
    check data                          Customs Value	           USD111.00

    check data                          Width	                   12.00 cm
    check data                          Height	                   8.00 cm
    check data                          Length	                   10.00 cm
    check data                          Weight	                   0.500 kg
    check new bulk upload               Base Item      1      PROD_2     Ship ready      12.00 cm         8.00 cm     10.00 cm      0.50 kg
    check new bulk upload               Inner Carton      10      PROD_2     Ship ready      30.00 cm         20.00 cm     20.00 cm      10.00 kg
    check new bulk upload               Master Carton      100      PROD_2     Ship ready      40.00 cm         40.00 cm     40.00 cm      20.00 kg
    wait element and click              css=button.close > span

TC416 - Order bulk upload: successful upload: Save upload
    [Tags]                              Order
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     1_success.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                       40 sec
    wait until page contains            All orders are valid, you can view the data by clicking on "Valid" button below
    show buttons in bulk form           Valid 2    Invalid 0    All 2

TC417 - Order bulk upload: successful upload: confirm
    Confirm
    #wait until page contains            Bulk upload was approved successfully               50 sec

    #ORDER 1
TC418 - TC419 - Order bulk upload: successful upload
    show in table bulk upload           SAMPLE ORDER 1             SAMPLE ORDER 1
    Check Order Data                          Order ID	               SAMPLE ORDER 1
    Check Order Data                          Company	                   ACME INC
    Check Order Data                          Full Name	               JANE DARE
    Check Order Data                          Address	                   123 ACME LANE
    Check Order Data                         Phone	                   (555) 555-5555
    Check Order Data                          Email	                   JANE@EXAMPLE.COM
    Check Data Tracking                          Source	                   Fulfillment Portal CSV

    check new bulk upload order        PROD_2         Base Item      1       	A product two            2
    check new bulk upload order        PROD_1         Base Item      1       	A product one            1
    go back

    #ORDER 2

    show in table bulk upload           SAMPLE ORDER 2             SAMPLE ORDER 2
    Check Order Data                          Order ID	               SAMPLE ORDER 2
    Check Order Data                          Company	                   ACME INC
    Check Order Data                          Full Name	               JOHN DOE
    Check Order Data                          Address	                   456 ACME LANE
    Check Order Data                          Phone	                   (555) 555-5555
    Check Order Data                          Email	                   JOHN@EXAMPLE.COM
    Check Data Tracking                          Source	                   Fulfillment Portal CSV
    check new bulk upload order        PROD_1         Base Item      1       	A product one            3
    go back


TC444 - ASN bulk upload: successful upload - step 1: file upload
    Go To                               ${SERVER}/advanced-shipping-notices/new/bulk
    Bulk Upload ASN                     ASN Bulk Upload     asn     1_success.xlsx
    wait until page contains            File uploaded successfully
TC446 - ASN bulk upload: successful upload - step 2: save upload
    wait until page contains            Bulk Upload                       40 sec
    show buttons in bulk form           Valid 2    Invalid 0    All 2
    click button                        Add Items
TC465 - ASN bulk upload: successful upload - step 3: save ASN
    check new bulk upload asn        PROD_2         Inner carton      10       	A product two            2
    check new bulk upload asn        PROD_1         Base Item      1       	    A product one            1

    Wait Element And Click               ${calendar_button}
    wait element and click               ${today_button}
    #click element                       ${upload_file}
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Sleep                               2 sec
    choose file                         xpath=//input[@type="file"]        ${CURDIR}/test_file.pdf
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    wait until page contains             File uploaded successfully
    input text                           ${contact_name_field}               ${first name}
    input text                           ${full_name_field}                  ${last name}
    input text                          ${address_1_field}                  ${address_1}
    input text                         ${city_field}                       ${city}
    input text                         ${postal_code_field}               ${post_code}
    input text                         ${state_field}                       ${state}
    Select Country                     ${country}
    click button                       Save
    Sleep                               3 sec
    reload page
    ${id_ship}=                         Get Id ASN
    set suite variable               ${bulk_id_ship}       ${id_ship}

TC466 - ASN bulk upload: successful upload - step 4: check ASN
    show asn in table                 ${bulk_id_ship}
    wait until page contains           ASN ${bulk_id_ship}
    check data                         Floship ID	               ${bulk_id_ship}
    check data                         Contact Name	               ${first name}
    check data                         Address                     ${last name}
    check new bulk upload order        PROD_1         Base Item      1       	A product one            1
    check new bulk upload order        PROD_2         Inner carton      10       	A product two            2
    wait element and click              css=button.close > span
    set suite variable                 ${fasn_for_approve}         ${bulk_id_ship}

TC504 - Approve ASN (Cancel)
    Go To                             ${SERVER}/advanced-shipping-notices
    Cancel before approving ASN        ${fasn_for_approve}

TC505 - Approve ASN (Confirm)
    Approve ASN                  ${fasn_for_approve}
    Success Approved             ${fasn_for_approve}                       Pending Arrival
    log to console               ${fasn_for_approve}

ASN was created (check mail)
    [Tags]                        Test
    Open Mailbox                        host=${MAIL_HOST}       user=${MAIL_USER}          password=${MAIL_PASSWORD}
    ${LATEST}=	             Wait for Mail	        	    recipient=${REG_EMAIL}	       timeout=30
    ${HTML}=	      get email body	${LATEST}
    should contain        "${HTML}"      ASN ${fasn_for_approve}: Pending Arrival
    should contain        "${HTML}"      Dear ${get_company}
    Delete Email                         ${LATEST}
    close mailbox


#    # success
TC456 - SO bulk upload: successful upload - file upload
    Go To                               ${SERVER}/shipping-options/bulk
    Bulk Upload                         Shipping Options Bulk Upload   shipping     1_success.xlsx
TC457 - SO bulk upload: successful - step 2: Save upload
    wait until page contains            File uploaded successfully
    wait until page contains            Bulk Upload                       40 sec
    show buttons in bulk form           Valid 3    Invalid 0    All 3

TC458 - SO bulk upload: successful upload - Confirm upload
    Confirm
    wait until page contains            Bulk upload was approved successfully
    show shipping in table              Express        FedEx IE              US
    show shipping in table              Fast           FedEx IE              US
    show shipping in table              Free           DPEX                  US

    click bulk                          Free
    check bulk shipping option          Courier                    DPEX
    wait element and click              css=button.close > span

    click bulk                          Fast
    check bulk shipping option          Courier                    FedEx IE
    wait element and click              css=button.close > span

    click bulk                          Express
    check bulk shipping option          Courier                    FedEx IE
    wait element and click              css=button.close > span


Approve orders immediately Step 1 (upload product)
    ${sku_app}=                      Get Rand ID             ${sku11}
    set suite variable           ${sku_app_immediat}               ${sku_app}
    log to console                ${sku_app_immediat}
    ${sku_for_appr_immediatlly}=             include sku for role      ${sku_app_immediat}
    Go To                               ${SERVER}/inventory/products/bulk
    Bulk Upload                         Product Bulk Upload      product      for_roles_sku.csv
    wait until page contains            File uploaded successfully

    wait until page contains            Items Bulk Upload                       40 sec
    wait until page contains            All items are valid, you can view the data by clicking on "Valid" button below.
    show buttons in bulk form           Valid 1    Invalid 0    All 1
    Confirm
    wait until page contains            Bulk upload was approved successfully               50 sec
    Go to                         ${SERVER}/inventory/products
    show data in order                 ${sku_app_immediat}           A product one
    Logout Client

Approve orders immediately Step 2 (add stock adjastment)
    Go To                         ${ADMIN}stock_adjustment/stockadjustment/
    Login                         ${login_admin}        ${pass_admin}
    wait until page contains      Select stock adjustment to change
    Add Stock Adjustment          ${sku_app_immediat}                   ${sku_app_immediat} -- Base Item   10
    ${status}=                     Get Id Adjustment         Draft
    log to console                 ${status}
    wait until page contains      The stock adjustment "${status}" was added successfully
    Approve stock adjustment        ${status}
    wait until page contains      ${status} successfully set to Approved
    Logout Client

#Approve orders immediately Step 3 (upload shipping options)
#    Go To                               ${SERVER}/shipping-options/bulk
#    Login                               ${REG EMAIL}               qwerty123!
#    Bulk Upload                         Shipping Options Bulk Upload   shipping     4_order_without_OrderID_and_Qty.xlsx
#    wait until page contains            File uploaded successfully
#    wait until page contains            Bulk Upload                       40 sec
#    show buttons in bulk form           Valid 3    Invalid 0    All 3
#    Confirm
#    show shipping in table              Express        WMP YAMATO              US
#    show shipping in table              Fast           FedEx IE              US
#    show shipping in table              Free           DPEX                  US

Approve orders immediately Step 4 (upload order and check pending fulfilment)
    ${id_order_appr_immed}=                 Get Rand ID              ${order_id}
    log to console               ${id_order_appr_immed}
    set suite variable           ${order_approval_bulk}               ${id_order_appr_immed}
    ${include_order}=            include order id for role       ${order_approval_bulk}           ${sku_app_immediat}      Express
    Go To                               ${SERVER}/orders/bulk
    Login                               ${REG EMAIL}               qwerty123!
    Bulk Upload                         Order Bulk Upload     order    for_roles_order.csv
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                       40 sec
    wait until page contains            All orders are valid, you can view the data by clicking on "Valid" button below
    show buttons in bulk form          Valid 1    Invalid 0    All 1
    Confirm
    wait until page contains            Bulk upload was approved successfully               50 sec
    Go To                              ${SERVER}/orders
    show shipping in table              ${order_approval_bulk}              FS           Pending Fulfillment

## Search + Sort and Filters

TC538 - Check search on products page
    Go To                         ${SERVER}/inventory/products
    wait until page contains      Product List
    Search in Client              Prod_1
    Sleep                        2 sec
    show shipping in table         PROD_1              A product one          1234567890
    Search in Client              Prod_2
    Sleep                        2 sec
    show shipping in table         PROD_2              A product two          1234567890
    Search in Client              ${sku_app_immediat}
    Sleep                        2 sec
    show shipping in table       ${sku_app_immediat}              A product one          9
    Search in Client             ${edit_sku}
    Sleep                        2 sec
    show shipping in table             ${edit_sku}             ${edit_desc}           	123456

TC537 - Check filters on products page
    Go To                         ${SERVER}/inventory/products
    Check Filter in Client         123456
    show shipping in table             ${edit_sku}             ${edit_desc}           	123456
    Click x in filter                123456
    Go To                         ${SERVER}/inventory/products

    Check Filter in Client        	987654321
    show shipping in table         PROD_1              A product one          987654321
    show shipping in table         PROD_2              A product two          987654321
    show shipping in table         ${sku_app_immediat}	       A product one	      987654321
    Click x in filter              987654321
    Go To                         ${SERVER}/inventory/products

    Check Filter in Client        	Out of stock
    show shipping in table         PROD_1              A product one        0
    show shipping in table         PROD_2              A product two        0
    show shipping in table         ${edit_sku}	${edit_desc}	                0
    Click x in filter             Out of stock
    Go To                         ${SERVER}/inventory/products

    Check Filter in Client        1 - 20
    show shipping in table        ${sku_app_immediat}	A product one		9
    Click x in filter             1 - 20
    Go To                         ${SERVER}/inventory/products

    Check Filter in Client        21 - 100
    wait until page does not contain element    xpath=//tbody//a[contains(.,"PROD_1")]
    wait until page does not contain element    xpath=//tbody//a[contains(.,"PROD_2")]
    wait until page does not contain element    xpath=//tbody//a[contains(.,"${sku_app_immediat}")]
    wait until page does not contain element    xpath=//tbody//a[contains(.,"${edit_sku}")]
    Click x in filter             21 - 100
    Go To                         ${SERVER}/inventory/products

    Check Filter in Client        Has Batteries
    show shipping in table         PROD_1              A product one          987654321
    show shipping in table         PROD_2              A product two          987654321
    show shipping in table         ${sku_app_immediat}	       A product one	      987654321
    Click x in filter             Has Batteries
    Go To                         ${SERVER}/inventory/products

    Check Filter in Client        China
    show shipping in table         PROD_1              A product one          987654321
    show shipping in table         PROD_2              A product two          987654321
    show shipping in table         ${sku_app_immediat}	       A product one	      987654321
    show shipping in table             ${edit_sku}             ${edit_desc}           	123456

TC539 - Check sorting on products page
    Go To                         ${SERVER}/inventory/products
    Sorting in Client             SKU

    wait until page contains element        xpath=//tbody/tr[1][contains(.,"PROD_1")]
    wait until page contains element        xpath=//tbody/tr[2][contains(.,"PROD_2")]
    wait until page contains element        xpath=//tbody/tr[3][contains(.,"${sku_app_immediat}")]
    wait until page contains element        xpath=//tbody/tr[4][contains(.,"${edit_sku}")]

    Sorting in Client             SKU
    wait until page contains element        xpath=//tbody/tr[1][contains(.,"${edit_sku}")]
    wait until page contains element        xpath=//tbody/tr[2][contains(.,"${sku_app_immediat}")]
    wait until page contains element        xpath=//tbody/tr[3][contains(.,"PROD_2")]
    wait until page contains element        xpath=//tbody/tr[4][contains(.,"PROD_1")]

    Sorting in Client             Stock

    wait until page contains element        xpath=//tbody/tr[1][contains(.,"9")]
    wait until page contains element        xpath=//tbody/tr[2][contains(.,"0")]
    wait until page contains element        xpath=//tbody/tr[3][contains(.,"0")]
    wait until page contains element        xpath=//tbody/tr[4][contains(.,"0")]

TC541 - Export
    Go To                         ${SERVER}/inventory/products
    wait element and click         xpath=//tbody//a[contains(.,"PROD_1")]/../..//input
    wait until page contains element       xpath=//a[contains(.,"Export")]


TC837 - Check search on Order page
    Go To                         ${SERVER}/orders
    wait until page contains      Order List
    Search in Client              ${edit_order}
    Sleep                        2 sec
    show shipping in table       ${fs_order}  	${edit_order}			Pending Approval
    Search in Client             ${fs_order}
    Sleep                        2 sec
    show shipping in table       ${fs_order}  	${edit_order}			Pending Approval

TC838 - Check search on Order page (invalid)
    Search in Client             test
    sleep                       1 sec
    wait until page contains         You don't have any orders here

TC836 - Check filters on Order page
    Go To                         ${SERVER}/orders
    Check Filter in Client - Order          Pending Fulfillment
    Sleep                        1 sec
    show shipping in table        	FS	 ${order_approval_bulk}		Pending Fulfillment
    Click x in filter               Pending Fulfillment
    Go To                         ${SERVER}/orders

    Check Filter in Client        	WMP YAMATO
    Sleep                        1 sec
    show shipping in table        ${edit_order}		WMP YAMATO	      Pending Approval
    Click x in filter             	WMP YAMATO
    Go To                         ${SERVER}/orders

    Check Filter in Client        Fulfillment Portal
    Sleep                        1 sec
    show shipping in table       ${edit_order}		  WMP YAMATO	    Pending Approval
    Click x in filter             Fulfillment Portal
    Go To                         ${SERVER}/orders

    Check Filter in Client       Out of stock
    Sleep                        1 sec
    show shipping in table       SAMPLE ORDER 2			Pending Approval	Out of stock
    show shipping in table       SAMPLE ORDER 1			Pending Approval	Out of stock
    show shipping in table       ${edit_order}		Pending Approval        Out of stock
    Click x in filter            Out of stock
    Go To                         ${SERVER}/orders

    Check Filter in Client        Express
    Sleep                        1 sec
    show shipping in table        	${order_approval_bulk}		FedEx IE	     Pending Fulfillment
    Click x in filter             Express
    Go To                         ${SERVER}/orders

    Check Filter in Client        Free Shipping
    Sleep                        1 sec
    show shipping in table         SAMPLE ORDER 1			Pending Approval	    Out of stock
    Click x in filter             Free Shipping
##
TC835 - Check sorting on Order page
    Go To                         ${SERVER}/orders
    Sorting in Client             	Order ID
    wait until page contains element         xpath=//tbody/tr[1][contains(.,"ID_")]
    wait until page contains element         xpath=//tbody/tr[2][contains(.,"ID_")]
    wait until page contains element         xpath=//tbody/tr[3][contains(.,"SAMPLE ORDER 1")]
    wait until page contains element         xpath=//tbody/tr[4][contains(.,"SAMPLE ORDER 2")]


TC556 - Check search on ASN page
    Go To                         ${SERVER}/advanced-shipping-notices
    wait until page contains      Advanced Shipping Notice List
    Search in Client              ${asn_id}
    Sleep                        1 sec
    show shipping in table 2 arg        ${asn_id}			Draft

TC557 - Check search on ASN page (invalid)
    Search in Client             test
    sleep                       1 sec
    wait until page contains         You don't have any ASNs here

TC555 - Check filters on ASN page
    Go To                         ${SERVER}/advanced-shipping-notices
    Check Filter in Client - Order          Draft
    Sleep                        1 sec
    show shipping in table 2 arg        	${asn_id}	            Draft
    Click x in filter               Draft
    Go To                         ${SERVER}/advanced-shipping-notices

    Check Filter in Client        	Pending Arrival
    Sleep                        1 sec
    show shipping in table 2 arg        FASN		      Pending Arrival
    Click x in filter             Pending Arrival

##
TC554 - Check sorting on ASN page
    Go To                         ${SERVER}/advanced-shipping-notices
    Sorting in Client             	Status
    wait until page contains element         xpath=//tbody/tr[1][contains(.,"Draft")]
    wait until page contains element         xpath=//tbody/tr[2][contains(.,"Pending Arrival")]

TC506 - Delete ASN (Cancel)
   Go To                         ${SERVER}/advanced-shipping-notices
   Cancel before deleting ASN       ${asn_id}

TC507 - Delete ASN (Confirm)
   Delete ASN                   ${asn_id}
   wait until page contains    ASN was deleted successfully
   Success delete              ${asn_id}



TC560 - Check search on Shipping Option page
    Go To                         ${SERVER}/shipping-options
    wait until page contains      Shipping Options List
    Search in Client              ${edit_ship}
    Sleep                        1 sec
    show shipping in table 2 arg      ${edit_ship}				WMP YAMATO

    Search in Client            Express
    sleep                       1 sec
    show shipping in table 2 arg     Express         FedEx IE

TC561 - Check search on Shipping Option page (invalid)
    Search in Client             test
    sleep                       1 sec
    wait until page contains         You don't have any Shipping Options here

TC559 - Check filters on Shipping Option page
    Go To                         ${SERVER}/shipping-options
    Check Filter in Client - Order          FedEx IE
    Sleep                        1 sec
    show shipping in table        	Express	        FedEx IE	          US
    Click x in filter               FedEx IE
    Go To                         ${SERVER}/shipping-options

    Check Filter in Client        		WMP YAMATO
    Sleep                        1 sec
    show shipping in table 2 arg        ${edit_ship}			     	WMP YAMATO
    Click x in filter             	WMP YAMATO

##
TC558 - Check sorting on Shipping Option page
    Go To                         ${SERVER}/shipping-options
    Sorting in Client             	Name
    wait until page contains element         xpath=//tbody/tr[1][contains(.,"Express")]
    wait until page contains element         xpath=//tbody/tr[2][contains(.,"Fast")]
    wait until page contains element         xpath=//tbody/tr[3][contains(.,"Free")]
    wait until page contains element         xpath=//tbody/tr[4][contains(.,"${edit_ship}")]

    Go To                         ${SERVER}/shipping-options
    Sorting in Client             		Courier
    wait until page contains element         xpath=//tbody/tr[1][contains(.,"FedEx IE")]
    wait until page contains element         xpath=//tbody/tr[2][contains(.,"FedEx IE")]
    wait until page contains element         xpath=//tbody/tr[3][contains(.,"DPEX")]
    wait until page contains element         xpath=//tbody/tr[4][contains(.,"WMP YAMATO")]


TC549 - Check sorting on group items page
    Go To                         ${SERVER}/inventory/group-items
    wait until page contains      Group Items List
    Search in Client             ${id_group_variable}
    Sleep                        1 sec
    show shipping in table 2 arg      ${id_group_variable}	    test


TC1114 - Check Developers page
    Go To                         ${SERVER}
    wait settings and click         Developers
    wait until page contains         Floship API
    check links on developer's page   Authentication
    check links on developer's page   Orders
    check links on developer's page   Products
    check links on developer's page   ASNs
    check links on developer's page   Shipping Options
    check links on developer's page   Couriers
    wait until page contains element         xpath=//a[contains(.,"Get Access")]
    wait until page does not contain element         xpath=//a[contains(.,"Try It Out")]

TC1115 - "Get access" button
    [Tags]                            Token
    Go To                              ${SERVER}/developers
    wait element and click             xpath=//a[contains(.,"Get Access")]
    wait until page contains           Your Access Tokens
    click button                       Close
    wait until page contains           Credentials
    wait until page contains           Production Token
    ${url}=                            get text                         xpath=//div[@class="block-inner"]//code[1][contains(.,"http")]
    log to console                     ${url}
    ${token}=                          get text                      xpath=//div[@class="block-inner"]//code[2]
    log to console                     ${token}
    set suite variable                 ${url_}     ${url}
    set suite variable                 ${token_}    ${token}

TC1116 - Authentication section
    check links on developer       Authentication
    wait until page contains       API Documentation
    wait until page contains       Authentication
    wait until page contains       Credentials
    wait until page contains       ${token_}
    wait until page contains       ${url_}

TC1117 - Orders section
    wait element and click         xpath=//div[@class="filters-list padding-15"]//a[contains(.,"Orders")]
    wait until page contains       Order
    wait until page does not contain element         xpath=//a[contains(.,"Try It Out")]

TC1118 - Products section
    wait element and click         xpath=//div[@class="filters-list padding-15"]//a[contains(.,"Products")]
    wait until page contains       Products
    wait until page does not contain element         xpath=//a[contains(.,"Try It Out")]

TC1119 - ASNs section
    wait element and click         xpath=//div[@class="filters-list padding-15"]//a[contains(.,"ASNs")]
    wait until page contains       ASN (Advance Shipping Notice)
    wait until page does not contain element         xpath=//a[contains(.,"Try It Out")]

TC1120 - Shipping Options section
    wait element and click         xpath=//div[@class="filters-list padding-15"]//a[contains(.,"Shipping Option")]
    wait until page contains       Shipping Option
    wait until page does not contain element         xpath=//a[contains(.,"Try It Out")]

TC1121 - Couriers section
    wait element and click         xpath=//div[@class="filters-list padding-15"]//a[contains(.,"Couriers")]
    wait until page contains       Couriers
    wait until page does not contain element         xpath=//a[contains(.,"Try It Out")]
    Go To                                               ${SERVER}
    Logout Client


Approve ASN in Admin to check client's mail
    Go To                            ${ADMIN}asns/asn/
    Login                            ${login_admin}          ${pass_admin}
    Check Item in Search                        ${fasn_for_approve}
    Check ASN Approve                ${fasn_for_approve}    In Review Asn
    wait until page contains         ${fasn_for_approve} successfully set to In Review

    Go To                            ${ADMIN}asns/asn/
    Check Item in Search             ${fasn_for_approve}
    Check ASN Approve                ${fasn_for_approve}  Approve Asn
    wait until page contains         ${fasn_for_approve} successfully set to Approve
#    Go To                            ${ADMIN}
#    Logout Client

ASN was approved (check mail)
    [Tags]                        Approved
    Open Mailbox                        host=${MAIL_HOST}       user=${MAIL_USER}          password=${MAIL_PASSWORD}
    ${LATEST}=	             Wait for Mail	        	    recipient=${REG_EMAIL}	       timeout=30
    ${HTML}=	      get email body	${LATEST}
    should contain        "${HTML}"      ${fasn_for_approve}: Approved
    should contain        "${HTML}"      Your ASN has been Approved
    should contain        "${HTML}"      Dear ${get_company}
    Delete Email                         ${LATEST}
    close mailbox

