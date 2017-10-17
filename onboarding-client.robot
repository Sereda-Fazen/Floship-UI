*** Settings ***
Documentation                           FloShip UI testing Client part
Resource                                resource.robot
Suite Setup                             Setup Tests
Suite Teardown                          Close All Browsers


*** Test Cases ***
TC195 - Login in Admin Panel (valid)
    [Tags]                               Login
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

TC527 - Create password as a user - Success

    Input text                          name=email                    ${REG_EMAIL}
    Click Button                        Reset my password
    Wait Until Page Contains            Password reset sent
    Capture Page Screenshot             ${TEST NAME}-{index}.png

    Open Mailbox                        host=${MAIL_HOST}       user=${MAIL_USER}          password=${MAIL_PASSWORD}
    ${LATEST}=	             Wait for Mail	        	    recipient=${REG_EMAIL}	       timeout=150
    ${body}=	             get email body	       ${LATEST}
    #log to console           ${body}
    ${pass_link}=	             Get Mail link Gmail 	      ${body}
    log to console           ${pass_link}
    Delete Email                         ${LATEST}
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

##ASN

TC313,TC314 Click "Add ASN" in the "Advanced Shipping Notice List" page
    [Tags]                              ASN
    Go To                               ${SERVER}
    Header title block                  Advanced Shipping Notice
    click Add new                       Add ASN

TC553,TC315,TC317 - Add new ASN- Enter data and choose address from address book (valid)

    Valid Data ASN Address               ${first name}   ${post_code}          ${edit_sku}          FASN
    ${id_ship}=                         Get Id ASN
    log to console                      ${id_ship}
    set suite variable                  ${asn_id}               ${id_ship}

TC503 - Edit ASN
    [Tags]                              EditAsn
    Go To                               ${SERVER}/advanced-shipping-notices
    #Edit ASN                            ${asn_id}    ${long_symbols_255}     ${long_symbols_255} 	${edit_sku}         ${asn_id}
    Edit ASN                            ${asn_id}    ${first name}     ${state} 	${edit_sku}         ${asn_id}

TC506 - Delete ASN (Cancel)
   Go To                         ${SERVER}/advanced-shipping-notices
   Cancel before deleting ASN       ${asn_id}

TC507 - Delete ASN (Confirm)
   Delete ASN                   ${asn_id}
   wait until page contains    ASN was deleted successfully
   Success delete              ${asn_id}


TC320,TC321 - Click "Add Shipping Option" button
    Go To                               ${SERVER}
    Header link                         Shipping Options
    wait element and click              xpath=//a[contains(.,"Add Shipping Option")]

TC322 - Add new Shipping Option - Enter data (valid)
    ${ship_op}=                        Get Rand ID            ${shipping_name}
    log to console                     ${ship_op}
    Valid Data Shipping                ${ship_op}           WMP YAMATO
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
    wait until page contains            Bulk upload was approved successfully               50 sec

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

    # success
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
