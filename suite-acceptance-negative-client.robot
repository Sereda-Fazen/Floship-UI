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
#    ${email}=                           Get Email Address
#    Set Suite Variable                  ${REG_EMAIL}                ${email}
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
    ${LATEST}=	             Wait for Mail	        	    recipient=${REG_EMAIL}	       timeout=150
    ${body}=	             get email body	       ${LATEST}
    #log to console           ${body}
    ${pass_link}=	             Get Mail link Gmail  	      ${body}    /password/reset       \r\n      ${SERVER}/password/reset
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


#Reset Password
#    [Tags]                              ResetPass
#    Go To                               ${SERVER}
#    Wait Until Page Contains Element    xpath=//h3[contains(.,"Login")]
#    click Element                       xpath=//div[@class="form-group"]//a[contains(.,"Forgot")]
#    Wait Until Page Contains            Password reset
#    Capture Page Screenshot             ${TEST NAME}-{index}.png
#    Input text                          name=email                     ${REG_EMAIL}
#    Click Button                        Reset my password
#    Wait Until Page Contains            Password reset sent
#    Capture Page Screenshot             ${TEST NAME}-{index}.png
#    ${res}=                             Wait Until Keyword Succeeds     3 min       5 sec          Check Mail   ${REG_EMAIL}    ${0}
#    ${link}=                            Get Mail link Temp           ${res}
#    log to console                      ${link}
#    Go To                               ${link}
#    Reset Password                      Enter new password      ${reset_pass}       ${reset_pass}             Password reset complete
#    set suite variable                  ${REG PASS}             ${reset_pass}
#    Click Element                       ${Log in}
#    Wait Until Page Contains Element    xpath=//h3[contains(.,"Login")]
#    Login                               ${REG_EMAIL}         qw1as2zx3po
#    wait until page contains            Login or password incorrect
#    Capture Page Screenshot             ${TEST NAME}-{index}.png
#    Login                               ${REG EMAIL}        ${REG PASS}
#    wait until page contains            Company Details
#    wait until page contains            Company Address
#    Capture Page Screenshot             ${TEST NAME}-{index}.png




TC293 - Login as a user
    [Tags]                              Register
    Go To                               ${SERVER}
    ${rand_company}=                    Get Rand Company
    log to console                      ${rand_company}
    set suite variable                  ${get_company}            ${rand_company}
    wait until page contains            Company Details
    wait until page contains            Company Address


TC294 - Register new client - Empty fields
    click button                        Register
    wait until page contains           This field is required
    wait error this is required    registration    name                           This field is required
    wait error this is required    registration    client_address.email           This field is required
    wait error this is required    registration    client_contact.first_name      This field is required
    wait error this is required    registration    client_contact.last_name       This field is required
    wait error this is required    registration    client_contact.email           This field is required
    wait error this is required    registration    client_contact.phone           This field is required
    wait error this is required    registration    client_address.address_1       This field is required
    wait error this is required    registration    client_address.country         This field is required
    Capture Page Screenshot            ${TEST NAME}-{index}.png
    Sleep                             1 sec


TC295 - Register new client - Enter symbols with limit 255,254,50
    Go To                           ${SERVER}
    Full Valid Data with Long Symbols
    wait error this is required    registration    name                                  Ensure this field has no more than 255 characters
    wait error this is required    registration    client_address.email                  Enter a valid email address
    wait error this is required    registration    client_contact.first_name             Ensure this field has no more than 255 characters
    wait error this is required    registration    client_contact.last_name              Ensure this field has no more than 255 characters
    wait error this is required    registration    client_contact.email                  Enter a valid email address
    wait error this is required    registration    client_contact.phone                  Ensure this field has no more than 255 characters
    wait error this is required    registration    client_address.state                  Ensure this field has no more than 255 characters
    wait error this is required    registration    client_address.city                   Ensure this field has no more than 255 characters
    wait error this is required    registration    client_address.phone                  Ensure this field has no more than 50 characters
    wait error this is required    registration    client_address.fax                    Ensure this field has no more than 50 characters
    #wait error this is required   registration    client_address.address_1              Ensure this field has no more than 255 characters

    ##Invalid Data Email
TC296 - Register new client - Enter invalid data (email company, website, email)
    Registration Invalid Data           client_address.email           test
    Registration Invalid Data           website                        test
    Registration Invalid Data           client_contact.email           test
    click button                        Register
    ##Validation
    wait error this is required     registration    client_address.email                  Enter a valid email address
    wait error this is required     registration     website                               Enter a valid URL
    wait error this is required     registration     client_contact.email                  Enter a valid email address


TC297 - Register new client - Enter data (valid)
    ##Normal data
    Full Valid Data                 ${get_company}        ${REG_EMAIL}
    wait until page contains         Welcome
    # Payment method
TC529 - Continue register new client (Terms of Service) - Invalid test
    wait until page contains element    xpath=//button[@disabled="disabled"]

TC530 - Continue register new client (Terms of Service) - Success
    Wait Element And Click              ${agree}
    wait until page does not contain element      xpath=//button[@disabled="disabled"]
    click button                        Continue

TC299 - Continue register (Payment Method) - Empty fields
    Invalid Card Number                 This field may not be blank           A valid integer is required           This field may not be blank

TC531 - Continue register (Payment Method) - Invalid
    Create Card Number               ${card num}       1320           99
    click button                     Continue
    wait until page contains         Your cad's expiration month is invalid


TC300 - Continue register (Payment Method) - Enter data (valid)
    reload page
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
    Save
    # required fields
TC310 - Add new product - Empty fields

    wait error this is required     product    description                      This field is required
    wait error this is required     product    customs_description              This field is required
    wait error this is required     product    sku                              This field is required
    wait error this is required     product    harmonized_code                  This field is required
    wait error this is required     product    customs_value.amount             This field is required
    wait error for Dimensions           width                              This field is required
    wait error for Dimensions           height                              This field is required
    wait error for Dimensions           length                              This field is required
    wait error for Dimensions           weight                              This field is required
    Capture Page Screenshot             ${TEST NAME}-{index}.png

TC594 - Add new product - Enter data (long string)
    Long Symbols
    Save
    wait error this is required     product    sku                             Ensure this field has no more than 255 characters
    wait error this is required     product    description                     Ensure this field has no more than 60 characters
    wait error this is required     product    customs_description             Ensure this field has no more than 255 characters
    wait error this is required     product    harmonized_code                 Ensure this field has no more than 255 characters
    wait error this is required     product    upc            Ensure this field has no more than 255 characters


TC535 - Add new product - Enter data (invalid)
    reload page
    Invalid Data
    wait error this is required     product     customs_value.amount                                   A valid number is required
    wait error for Dimensions           width                  A valid number is required
    wait error for Dimensions           height                  A valid number is required
    wait error for Dimensions           length                  A valid number is required
    wait error for Dimensions           weight                  A valid number is required
    Capture Page Screenshot             ${TEST NAME}-{index}.png


TC311 - Add new product - Enter data (valid)
    ${sku}=                      Get Rand ID             ${sku}
    ${desc}=                     Get Rand ID             ${sku_desc}
    log to console              ${sku}
    log to console              ${desc}
    reload page
    Valid Data                      ${sku}    ${desc}     test_desc       123456
#    Valid Data                 ${long_symbols_255}     ${long_symbols_60}    ${long_symbols_255}        ${long_symbols_255}
#    set suite variable         ${long_symb}                 ${long_symbols_255}
#    set suite variable         ${long_symb1}                 ${long_symbols_60}
     set suite variable         ${edit_desc}         ${desc}
     set suite variable         ${edit_sku}          ${sku}
     Save

TC536 - Edit product
    #Edit Product                       ${long_symb}          ${long_symb1}
    Edit Product                     ${edit_sku}   ${edit_desc}
    wait element and click           xpath=//button[contains(.,"Close")]
    #wait until element is not visible         xpath=//button[contains(.,"Close")]

TC544 - Add new product - Enter data (existed SKU)
    wait element and click            css=button.close > span
    wait until element is not visible         css=button.close > span
    wait element and click            xpath=//a[contains(.,"Add Product")]
    Valid Data                          ${edit_sku}         ${edit_desc}       Mobile phone         1234567
    #Valid Data                          ${long_symb}        ${long_symb1}       Mobile phone         1234567
    Save
    wait until page contains           duplicated for the current client

Check Global Search (Product)
    go to                               ${SERVER}/inventory/products
    wait element and click             css=button.close > span
    Search Data                         ${edit_sku}
    wait until page contains            Product ${edit_sku}
    Check Data                          SKU       ${edit_sku}
    Check Data                          Harmonized Code       123456
    Check Data Stock                    ${edit_sku}
    wait element and click             css=button.close > span
    Search Data                         ${edit_desc}
    wait until page contains            Product ${edit_sku}
    Check Data                          SKU       ${edit_sku}
    Check Data                          Harmonized Code       123456
    Check Data                          Description           ${edit_desc}
    Check Data Stock                    ${edit_sku}



##Address

TC335 - Go to "Address Book" page
# Add New Address
    [Tags]                            Address
    Go To                               ${SERVER}/address-book

TC336,TC337 - Click on "Add Address" button
    Empty Fields Address Book           Add Address
    wait error this is required     address     addressee                      This field is required
    wait error this is required     address     address_1                      This field is required
    wait error this is required     address     city                           This field is required
    wait error this is required     address     country                        This field is required

TC599 - Add new address - Enter data (long string)
    reload page
    Long Symbols Address
    Save
    wait error this is required         address     company                      Ensure this field has no more than 255 characters
    wait error this is required         address     phone                     Ensure this field has no more than 50 characters
    wait error this is required         address     state                      Ensure this field has no more than 255 characters
    wait error this is required         address     postal_code                      Ensure this field has no more than 255 characters


TC563 - Add new address - Enter data (invalid)
    invalid email in address            test               Enter a valid email address


TC338 - Add new address - Enter data (valid)
    reload page
    Valid Data Address Book

TC568 - Change address
   [Tags]                            Edit
   Go To                              ${SERVER}/address-book
   Edit Address                      ${first name} ${last name}

##ASN

TC313,TC314 Click "Add ASN" in the "Advanced Shipping Notice List" page
    [Tags]                              ASN
    Go To                               ${SERVER}
    Header title block                  Advanced Shipping Notice
    click Add new                       Add ASN

TC314 - Add new ASN- Empty fields
    Save
    wait until page contains element    xpath=//*[@ng-model="$ctrl.asn.eta"]/../..//li[contains(.,"Date has wrong format. Use one of these formats instead: YYYY[-MM[-DD]]")]
    wait until page contains element    xpath=//p[@class="dropify-error ng-binding ng-scope" and contains(.,"This field is required")]
    wait error this is required     asn    contact_name                              This field is required
    wait error this is required     asn    addressee                              This field is required
    wait error this is required     asn    address_1                              This field is required
    wait error this is required     asn    city                              This field is required
    wait error this is required     asn    postal_code                              This field is required
    wait error this is required     asn    country                              This field is required

    # long symbols
TC596 - Add new ASN- Enter data (long string)
    Long Symbols in Data ASN
    Save
    wait error this is required     asn    client_reference_number                              Ensure this field has no more than 255 characters
    wait error this is required     asn    tracking_number                              Ensure this field has no more than 255 characters
    wait error this is required     asn    contact_name                              Ensure this field has no more than 255 characters
    wait error this is required     asn    addressee                             Ensure this field has no more than 255 characters
    wait error this is required     asn    address_1                             Ensure this field has no more than 255 characters
    wait error this is required     asn    city                              Ensure this field has no more than 255 characters
    wait error this is required     asn    postal_code                             Ensure this field has no more than 255 characters

TC502 - Add new ASN- Enter data (invalid)
    reload page
    wait until element is visible       ${referense_asn}
    choose file                         xpath=//input[@type="file"]        ${CURDIR}/test_file.cvs
    click button                        Save
    wait until page contains            Invalid file
    wait until page contains            You are trying to upload an invalid type of file


TC553,TC315,TC317 - Add new ASN- Enter data and choose address from address book (valid)
    reload page
    #Valid Data ASN Address              ${long_symbols_255}      ${long_symbols_255}    ${long_symb}          FASN
    Valid Data ASN Address               ${first name}   ${post_code}          ${edit_sku}          FASN
    ${id_ship}=                         Get Id ASN
    log to console                      ${id_ship}
    set suite variable                  ${asn_id}               ${id_ship}


TC503 - Edit ASN
    [Tags]                              EditAsn
    Go To                               ${SERVER}/advanced-shipping-notices
    #Edit ASN                            ${asn_id}    ${long_symbols_255}     ${long_symbols_255} 	${edit_sku}         ${asn_id}
    Edit ASN                            ${asn_id}    ${first name}     ${state} 	${edit_sku}         ${asn_id}

Check Glodal Search (ASN)
   Go To                               ${SERVER}/advanced-shipping-notices
   Search Data                         ${asn_id}
   wait until page contains            ASN ${asn_id}
   Check Data                          Floship ID        ${asn_id}
   Check Data Stock                    ${edit_sku}

TC506 - Delete ASN (Cancel)
   Cancel before deleting ASN       ${asn_id}

TC507 - Delete ASN (Confirm)
   Delete ASN                   ${asn_id}
   wait until page contains    ASN was deleted successfully
   Success delete              ${asn_id}


TC320,TC321 - Click "Add Shipping Option" button
    Go To                               ${SERVER}
    Header link                         Shipping Options
    Empty Fields Shipping               Add Shipping Option
    Save

TC1146 - Add SO without Name
    wait until page does not contain element    xpath=//*[@ng-model="$ctrl.som.shipping_option"]/..//li[contains(.,"This field is required")]
    wait error this is required    som            courier_service                     This field is required
    wait error this is required    som            country                                This field is required

    # long symbols
TC597 - Add new Shipping Option - Enter data (long string)
    input text                      ${som_name_field}                           ${long_symbols}
    Save
    wait error this is required    som            shipping_option                   Ensure this field has no more than 255 characters

TC322 - Add new Shipping Option - Enter data (valid)
    ${ship_op}=                        Get Rand ID            ${shipping_name}
    log to console                     ${ship_op}
    reload page
    #Valid Data Shipping                ${long_symbols_255}           WMP YAMATO
    Valid Data Shipping                ${ship_op}     ${select_all}       WMP YAMATO
    set suite variable                 ${edit_ship}         ${ship_op}

TC831 - Edit Shipping Option
    Go To                              ${SERVER}/shipping-options
    #Edit Shipping Options             ${long_symbols_255}
    Edit Shipping Options             ${edit_ship}


# Add Group Items

TC542,TC543 - Click "Add Group Items" on the "Group Items List" page
    Go To                               ${SERVER}
    Empty Fields Group Items            Add Group Items
    wait error this is required    groupItem      sku                              This field may not be blank
    wait error this is required    groupItem      description                This field may not be blank

    # long symbols
TC595 - Add new Group Item - Enter data (long string)
    input text                        ${sku_field_group}                  ${long_symbols}
    input text                        ${description_field_group}          ${long_symbols_61}
    Save
    wait error this is required    groupItem      sku                     Ensure this field has no more than 255 characters
    wait error this is required    groupItem      description             Ensure this field has no more than 60 characters


TC546 - Add new group items - Enter data (existed SKU)
    reload page
    #Valid Data Group Items         ${long_symbols_255}      ${long_symbols_60}     ${long_symb}          ${long_symb}
    Valid Data Group Items         ${edit_sku}      test     ${edit_sku}          ${edit_sku}
    wait error this is required    groupItem      sku            Exact duplicate or similar active SKU found

TC327 - Add new Group Item - Enter data (valid)
    reload page
    ${group_id_}=                         Get Rand ID       ${group}
    set suite variable                  ${id_group_variable}        ${group_id_}
    #Valid Data Group Items         ${id_group_variable}     ${long_symbols_60}     ${long_symb}        ${long_symb}
    Valid Data Group Items         ${id_group_variable}      test     ${edit_sku}       ${edit_sku}

TC548 - Edit group items
   Go To                              ${SERVER}/inventory/group-items
   #Edit Group Items                   ${id_order_variable}       ${long_symbols_60}       ${long_symb}            ${long_symb}
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


TC332 - Add new order- Empty fields
    #Empty Fields Order                  Add Order
    Save
    wait error this is required       order     shipping_address.addressee                              This field is required
    wait error this is required       order     shipping_address.address_1                              This field is required
    wait error this is required       order     shipping_address.city                              This field is required
    wait error this is required       order     shipping_address.postal_code                              This field is required
    wait error this is required       order     shipping_address.country                              This field is required
    wait error this is required       order     shipping_address.phone                              This field is required
    wait error this is required       order     client_po                              This field is required
    wait error this is required       order     ship_via_id                              This field is required

    # long symbols
TC598 - Add new order- Enter data (long string)
    Long Symbols for Order
    Save
    wait error this is required       order     shipping_address.company                      Ensure this field has no more than 255 characters
    wait error this is required       order     shipping_address.city                       Ensure this field has no more than 255 characters
    wait error this is required       order     shipping_address.postal_code                Ensure this field has no more than 255 characters
    wait error this is required       order     shipping_address.phone                      Phone number can have up to 21 characters
    wait error this is required       order     client_po                              Ensure this field has no more than 255 characters

TC332 - Add new order (invalid data)
    reload page
    Invalid Data Order
    wait error this is required     order     shipping_address.phone             Phone number must have at least 7 characters
    wait error this is required     order     shipping_address.phone             Invalid phone number format
    wait error this is required     order     insurance_value.amount                    A valid number is required

TC562 - Add new order - Enter data and choose address from address book (valid)
    ${id_order}=                           Get Rand ID              ${order_id}
    log to console                         ${id_order}
    reload page
    #Valid Data Order via Address          ${long_symbols_21}       ${long_symbols_255}   ${long_symb}       ${long_symb}   Base Item    ${long_symbols_255}
    Valid Data Order via Address          ${phone}       ${id_order}    ${edit_sku}     ${edit_sku}   Base Item    ${id_order}
    wait until page contains             Order Saved Successfully
    Go To                                ${SERVER}/orders
    show order is created                ${id_order}          WMP YAMATO        Pending Approval          Out of stock
    ${fs}=                   Get Id Order
    log to console                       ${fs}
    set suite variable                   ${fs_order}           ${fs}
    #set suite variable                  ${edit_id_order}      ${long_symbols_255}
    set suite variable                   ${edit_order}       ${id_order}

TC832 - Edit Order
   [Tags]                              EditOrder
   Go To                               ${SERVER}/orders
   #Edit Order                           ${edit_id_order}      ${long_symb}         Base Item       ${long_symb}     ${edit_id_order}
   Edit Order                           ${edit_order}     ${edit_sku}            Base Item      ${edit_sku}
   click button                      Save
   wait until page contains             Order Saved Successfully
   Go To                                ${SERVER}/orders
   show order is created                ${edit_order}          WMP YAMATO        Pending Approval          Out of stock


TC1063 - Check all the fields on the order's page
   Go To                               ${SERVER}/orders
   wait element and click              xpath=//table//td//a[contains(.,"${edit_order}")]

   wait until page contains            Order ${fs_order} Details

    show status order               Tracking Number              N/A
    show status order               Source              Fulfillment Portal
    show status order               Courier             WMP YAMATO
    show status order               Status              Pending Approval

    Show data in order                 Company            MyCompany
    Show data in order                Full Name	         SteveVai
    Show data in order                Address	        Street 1
    Show data in order               Phone	            1234567890

    wait until page contains element           xpath=//td[contains(.,"Transaction Date")]

    Show data in order                Floship ID	        ${fs_order}
    Show data in order                Order ID          ${edit_order}
    Show data in order              Exceptions	            Out of stock

    check item(SKU) after edit            SKU       ${edit_sku}
    check item(SKU) after edit            Unit Type       	Base Item
    check item(SKU) after edit            Unit Qty      1
    check item(SKU) after edit            Description       ${edit_desc}
    check item(SKU) after edit            Customs Value       $ 99.99
    check item(SKU) after edit            QTY       1
    check item(SKU) after edit            Total Qty       1

    Summary block (Order)           Pick and Pack           $ 0.00
    Summary block (Order)           Estimated           $ 0.00
    wait until page contains element    xpath=//div[@class="panel-body"][contains(.,"Total") and contains(.,"$ 0.00")]




Check Global Search (Order)
    go to                               ${SERVER}/orders
    Search Data                         ${fs_order}
    Check Data                          ${edit_sku}               Base Item
    Check Order Data                    Floship ID           ${fs_order}
    Check Order Data                    Order ID             ${edit_order}
    go to                               ${SERVER}/orders
    Search Data                         ${edit_order}
    Check Data                          ${edit_sku}               Base Item
    Check Order Data                    Floship ID            ${fs_order}
    Check Order Data                    Order ID              ${edit_order}
    Logout Client



TC340 - Open submenu of "Orders" menu
    [Tags]                             Links
    Go To                              ${SERVER}
    Login                             ${REG EMAIL}               12345678
    wait until page contains             Dashboard

TC569,TC341-TC345 - Check "Orders" menu item
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
    Logout Client


####BULK UPLOAD



TC385 - Product bulk upload: successful upload - step 1: Check that product does not exist
    [Tags]                              BulkUpload
    Go to                               ${SERVER}/inventory/products
    Login                               ${REG EMAIL}         qwerty123!
    Search Not Found                    PROD_1
    wait until page contains            No results found

TC389 - Product bulk upload: empty file - step 1
    # Empty File
    Go To                               ${SERVER}/inventory/products
    wait element and click              xpath=//a[contains(.,"Bulk Upload")]
    Bulk Upload                         Product Bulk Upload     product     empty.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            The file is empty                     60 sec
    click button                        Remove

TC390 - Product bulk upload: missing 1 column (SKU)
    # Miss SKU
    Go To                               ${SERVER}/inventory/products/bulk
    Bulk Upload                         Product Bulk Upload   product       3_missing_1_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['SKU']
    click button                        Remove

    # Miss Desc
TC391 - Product bulk upload: missing 2 column (Description)
    Go To                               ${SERVER}/inventory/products/bulk
    Bulk Upload                         Product Bulk Upload    product      3_missing_2_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['Description']
    click button                        Remove

    # Miss Brand
TC392 - Product bulk upload: missing 3 column (Brand/Manufacturer)
    Go To                               ${SERVER}/inventory/products/bulk
    Bulk Upload                         Product Bulk Upload       product      3_missing_3_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['Brand/Manufacturer']
    click button                        Remove

    # Miss UPC
TC393 - Product bulk upload: missing 3 column (UPC/EAN/MPN)
    Go To                               ${SERVER}/inventory/products/bulk
    Bulk Upload                         Product Bulk Upload        product     3_missing_4_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['UPC/EAN/MPN']
    click button                        Remove

    # Miss Code
TC394 - Product bulk upload: missing 5 column (Harmonized Code)
    Go To                               ${SERVER}/inventory/products/bulk
    Bulk Upload                         Product Bulk Upload       product      3_missing_5_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['Harmonized Code']
    click button                        Remove

    # Miss Weight
TC395 - Product bulk upload: missing 6 column (Gross Weight (kg))
    Go To                               ${SERVER}/inventory/products/bulk
    Bulk Upload                         Product Bulk Upload      product      3_missing_6_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['Gross Weight (kg)']
    click button                        Remove

    # Miss length
TC396 - Product bulk upload: missing 7 column (Gross Length (cm))
    Go To                               ${SERVER}/inventory/products/bulk
    Bulk Upload                         Product Bulk Upload     product     3_missing_7_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['Gross Length (cm)']
    click button                        Remove

    # Miss width
TC397 - Product bulk upload: missing 8 column (Gross Width (cm))
    Go To                               ${SERVER}/inventory/products/bulk
    Bulk Upload                         Product Bulk Upload    product      3_missing_8_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['Gross Width (cm)']
    click button                        Remove

    # Miss height
TC398 - Product bulk upload: missing 9 column (Gross Height (cm))
    Go To                               ${SERVER}/inventory/products/bulk
    Bulk Upload                         Product Bulk Upload        product    3_missing_9_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['Gross Height (cm)']
    click button                        Remove

    # Miss USD
TC399 - Product bulk upload: missing 10 column (Customs Value (USD))
    Go To                               ${SERVER}/inventory/products/bulk
    Bulk Upload                         Product Bulk Upload     product       3_missing_10_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['Customs Value (USD)']
    click button                        Remove

    #miss customs desc
TC400 - Product bulk upload: missing 11 column (Customs Description)
    Go To                               ${SERVER}/inventory/products/bulk
    Bulk Upload                         Product Bulk Upload    product      3_missing_11_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['Customs Description']
    click button                        Remove

    # cat
TC401 - Product bulk upload: missing 12 column (Category (if known))
    Go To                               ${SERVER}/inventory/products/bulk
    Bulk Upload                         Product Bulk Upload    product      3_missing_12_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['Category (if known)']
    click button                        Remove


    # Miss Lithium Ion Battery
TC402 - Product bulk upload: missing 13 column (Lithium Ion Battery (Y/N))
    Go To                               ${SERVER}/inventory/products/bulk
    Bulk Upload                         Product Bulk Upload      product       3_missing_13_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['Lithium Ion Battery (Y/N)']
    click button                        Remove

    # Miss Date
TC403 - Product bulk upload: missing 14 column (Expiry Date (Y/N))
    Go To                               ${SERVER}/inventory/products/bulk
    Bulk Upload                         Product Bulk Upload     product        3_missing_14_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['Expiry Date (Y/N)']
    click button                        Remove


    # Miss Liquid
TC404 - Product bulk upload: missing 15 column (Liquid (Y/N))
    Go To                               ${SERVER}/inventory/products/bulk
    Bulk Upload                         Product Bulk Upload     product         3_missing_15_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['Liquid (Y/N)']
    click button                        Remove

    # Miss image url
TC405 - Product bulk upload: missing 16 column (Item Image URL)
    Go To                               ${SERVER}/inventory/products/bulk
    Bulk Upload                         Product Bulk Upload    product       3_missing_16_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['Item Image URL']
    click button                        Remove


    # Miss Packaging
TC406 - Product bulk upload: missing 17 column (Packaging SKU)
    Go To                               ${SERVER}/inventory/products/bulk
    Bulk Upload                         Product Bulk Upload       product            3_missing_17_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['Packaging SKU']
    click button                        Remove

    # Miss Country of Manufacture
TC407 - Product bulk upload: missing 18 column (Country of Manufacture)
    Go To                               ${SERVER}/inventory/products/bulk
    Bulk Upload                         Product Bulk Upload      product        3_missing_18_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['Country of Manufacture']
    click button                        Remove

    # Miss Unit QTY
TC408 - Product bulk upload: missing 19 column (Unit QTY)
    Go To                               ${SERVER}/inventory/products/bulk
    Bulk Upload                         Product Bulk Upload       product      3_missing_19_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['Unit QTY']
    click button                        Remove

    #  miss Unit type
TC409 - Product bulk upload: missing 20 column (Unit type)
    Go To                               ${SERVER}/inventory/products/bulk
    Bulk Upload                         Product Bulk Upload      product      3_missing_20_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['Unit type']
    click button                        Remove


    # invalid data
TC410,TC412 - Product bulk upload: file with invalid data
    Go To                               ${SERVER}/inventory/products/bulk
    Bulk Upload                         Product Bulk Upload     product     4_invalid_data.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Items Bulk Upload                       50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data which are not correct    Country of manufacture           'CNN' is not a valid value: refer to the 2-Letter Country Code List for options
    check data which are not correct    Customs Value                    Customs Value (USD) is invalid
    check data which are not correct    Gross Width                     Gross Width (cm) is invalid
    check data which are not correct    Gross Height                    Gross Height (cm) is invalid
    check data which are not correct    Gross Length                    Gross Length (cm) is invalid
    check data which are not correct    Gross Weight                    Gross Weight (kg) is invalid
    check data which are not correct    Packaging Item               An item with this packaging type must set a packaging item
    wait element and click              css=button.close > span
    wait until page contains            Remove
    click button                        Remove

TC413-TC414 - Product bulk upload: file with missed fields - step 1
    Go To                               ${SERVER}/inventory/products/bulk
    Bulk Upload                         Product Bulk Upload      product      5_missing_fields.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Items Bulk Upload                       50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 2    Invalid 1    All 3
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data which are not correct    SKU	                             Product SKU is required
    check data which are not correct    Description	                     Description is required
    check data which are not correct    Customs Value                    Customs Value is required
    check data which are not correct    Customs Description	             Customs Description is required
    check data which are not correct    Customs Value	                 Customs Value is required
    check data which are not correct    Gross Width	                     Gross Width is required
    check data which are not correct    Gross Height	                 Gross Height is required
    check data which are not correct    Gross Length	                 Gross Length is required
    check data which are not correct    Gross Weight	                 Gross Weight is required
    wait element and click              css=button.close > span
    wait until page contains            Remove
    click button                        Remove


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



TC950 - Order bulk upload: successful upload - step 1: Check that order does not exist
    [Tags]                              BulkOrder
    Go To                               ${SERVER}
    Wait Until Page Contains            Dashboard
    Search Not Found                    ORDER_1
    wait until page contains            No results found



TC420 - Order bulk upload: empty file
    # Empty File
    Go To                               ${SERVER}/orders
    wait element and click              xpath=//a[contains(.,"Bulk Upload")]
    Bulk Upload                         Order Bulk Upload       order        2_empty.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            The file is empty                     60 sec
    click button                        Remove


TC421 - Order bulk upload: missing 1 column (OrderID)
    # Miss SKU
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     3_missing_1_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missed headers                 50 sec
    wait until page contains            OrderID
    click button                        Remove

    # Miss Desc
TC422 - Order bulk upload: missing column (Insurance Value (in USD))
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload    order        3_missing_2_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missed headers                 50 sec
    wait until page contains            Insurance Value (in USD)
    click button                        Remove

    # Miss Brand
TC423 - Order bulk upload: missing column (Company)
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order      3_missing_3_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missed headers                50 sec
    wait until page contains            Company
    click button                        Remove

    # Miss UPC
TC424 - Order bulk upload: missing column (Contact Name)
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload    order       3_missing_4_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missed headers              50 sec
    wait until page contains            Contact Name
    click button                        Remove

    # Miss Code
TC425 - Order bulk upload: missing column (Address 1)
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload    order      3_missing_5_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missed headers                 50 sec
    wait until page contains            Address 1
    click button                        Remove

    # Miss Weight
TC426 - Order bulk upload: missing column (Address 2)
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload    order      3_missing_6_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missed_headers                 50 sec
    wait until page contains            Address 2
    click button                        Remove

    # Miss length
TC427 - Order bulk upload: missing column (City)
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload    order      3_missing_7_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missed headers               50 sec
    wait until page contains            City
    click button                        Remove

    # Miss width
TC428 - Order bulk upload: missing column (State)
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload    order      3_missing_8_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missed headers                50 sec
    wait until page contains            State
    click button                        Remove

TC429 - Order bulk upload: missing column (Zip Code)
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload    order      3_missing_9_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missed headers                50 sec
    wait until page contains            Zip Code
    click button                        Remove

TC430 - Order bulk upload: missing column (Country Code* (2-letter))
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload    order      3_missing_10_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missed headers                50 sec
    wait until page contains            Country Code (2-letter)
    click button                        Remove

TC431 - Order bulk upload: missing column (Phone)
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload    order      3_missing_11_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missed headers                50 sec
    wait until page contains            Phone
    click button                        Remove

TC432 - Order bulk upload: missing column (Email)
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload    order      3_missing_12_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missed headers                50 sec
    wait until page contains            Email
    click button                        Remove

TC433 - Order bulk upload: missing column (Unit Value (in USD))
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload    order      3_missing_13_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missed headers              50 sec
    wait until page contains            Unit Value (in USD)
    click button                        Remove

TC434 - Order bulk upload: missing column (Shipping Option)
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload    order      3_missing_14_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missed headers               50 sec
    wait until page contains            Shipping Option
    click button                        Remove

TC435 - Order bulk upload: missing column (Quantity)
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload    order      3_missing_15_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missed headers             50 sec
    wait until page contains            Quantity
    click button                        Remove


TC436 - Order bulk upload: missing column (Item SKU)
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload    order      3_missing_16_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missed headers            50 sec
    wait until page contains            Item SKU
    click button                        Remove

TC437 - Order bulk upload: missing column (Packaging Item)
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload    order      3_missing_17_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missed_headers             50 sec
    wait until page contains            Packaging Item
    click button                        Remove

TC438 - TC439 - Order bulk upload: file with invalid data
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload      order      4_invalid_data.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                       50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data which are not correct    Insurance Value	                 Enter a number
    check data which are not correct    Packaging SKU                    Packaging item does not exists
    check data which are not correct    Country                         'U$' is not a valid value: refer to the 2-Letter Country Code List for options
    check data which are not correct    Phone                           Phone number must have at least 7 characters
    check data for order                SKU                             No active item with given SKU
    check data for order                QTY                             Quantity is invalid
    check data for order                Value                           Enter a number
    wait element and click              css=button.close > span
    wait until page contains            Remove
    click button                        Remove


TC440 - TC441 - Order bulk upload: missed fields - step 1
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload      order       5_missing_fields.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                       50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 1    Invalid 1    All 2
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data which are not correct    Order ID	                     Order ID is required
    check data for order                SKU	                             Item SKU is required
    check data for order                QTY                              Quantity is required
    check data which are not correct    Name	                         Contact Name is required
    check data which are not correct    Address Line 1	                 Address 1 is required
    check data which are not correct    City	                         City is required
    check data which are not correct    Country	                         Country is required
    check data which are not correct    Phone	                         Phone number is required
    wait element and click              css=button.close > span
    wait until page contains            Remove
    click button                        Remove
#
#


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


TC941 - ASN uploads: successful upload - step 1: Check that ASN does not exist
    [Tags]                              BulkAsn
    Go To                               ${SERVER}
    Wait Until Page Contains            Dashboard
    Search Not Found                    ASN_1
    wait until page contains            No results found

TC447 - ASN bulk upload: empty file
    Go To                               ${SERVER}/advanced-shipping-notices
    Wait Element And Click              xpath=//a[contains(.,"Add ASN")]
    # Empty File
    wait element and click              xpath=//a[contains(.,"Bulk Upload")]
    Bulk Upload ASN                     ASN Bulk Upload     asn        2_empty.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            The file is empty                     60 sec
    click button                        Remove

#    # Miss SKU
#
TC448 - ASN bulk upload: missing 1 column (SKU)
    Go To                               ${SERVER}/advanced-shipping-notices/new/bulk
    Bulk Upload ASN                     ASN Bulk Upload     asn        3_missing_1_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['SKU']
    click button                        Remove
#
#    # Miss QTY
TC449 - ASN bulk upload: missing 2 column (Quantity)
    Bulk Upload ASN                     ASN Bulk Upload     asn        3.1_missing_2_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['Quantity']
    click button                        Remove
#
#    # Miss unit type
TC450 - ASN bulk upload: missing 3 column (Unit Type)
    Bulk Upload ASN                     ASN Bulk Upload     asn        3.2_missing_3_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['Unit Type']
    click button                        Remove

    # invalid data


TC451 - TC452 - ASN bulk upload: file with invalid data - step 1
    Go To                               ${SERVER}/advanced-shipping-notices/new/bulk
    Bulk Upload ASN                     ASN Bulk Upload     asn        4_invalid_data.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            ASN Bulk Upload                       50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    shows title in bulk                 Quantity: F      Enter a whole number
    wait element and click              css=button.close > span
    click button                        Remove

    # miss fields
TC453 - TC455 - ASN bulk upload: file with missed fields
    Go To                               ${SERVER}/advanced-shipping-notices/new/bulk
    Bulk Upload ASN                     ASN Bulk Upload     asn        5_missing_fields.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            ASN Bulk Upload                       50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 2    All 2
    shows title in bulk                 SKU             This field is required
    shows title in bulk                 Quantity:        This field is required
    wait element and click              css=button.close > span
    click button                        Remove

    # success

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




TC459 - SO bulk upload: empty file
    [Tags]                              BulkShippingOptions
    Go To                               ${SERVER}
    Wait Until Page Contains            Dashboard
    Go To                               ${SERVER}/shipping-options
    # Empty File
    wait element and click              xpath=//a[contains(.,"Bulk Upload")]
    Bulk Upload                         Shipping Options Bulk Upload     shipping        2_empty.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            The file is empty                     60 sec
    click button                        Remove

TC460 - SO bulk upload: missing 1 column (Courier Service)
    Go To                               ${SERVER}/shipping-options/bulk
    Bulk Upload                         Shipping Options Bulk Upload     shipping        3_missing_1_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['Courier Service']
    click button                        Remove
#
#    # Miss Shipping
TC461 - SO bulk upload: missing 1 column (Shipping Option)
    Bulk Upload                         Shipping Options Bulk Upload     shipping        3.1_missing_2_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['Shipping Option']
    click button                        Remove
#
#    # Miss Countries

TC462 - SO bulk upload: missing 3 column (Countries)
    Bulk Upload                         Shipping Options Bulk Upload     shipping        3.2_missing_3_column.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Missing_headers: ['Countries']
    click button                        Remove

    # invalid data


TC463 - TC464 - SO bulk upload: file with invalid data
    Go To                               ${SERVER}/shipping-options/bulk
    Bulk Upload                         Shipping Options Bulk Upload    shipping      4_invalid_data.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Shipping Options Bulk Upload                       50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data which are not correct    Courier Service Name	            No such courier service - Test courier
    check data which are not correct    Country Code                    No such country code - Test country
    wait until page contains element     xpath=//div[@class="row ng-scope" and contains(.,"Shipping Option") and contains(.,"May not be blank")]
    wait element and click              css=button.close > span
    click button                        Remove

    # miss fields

Check Bulk Upload Shipping Options (Missing Fields)
    Go To                               ${SERVER}/shipping-options/bulk
    Bulk Upload                          Shipping Options Bulk Upload     shipping        5_missing_fields.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Shipping Options Bulk Upload                       50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 2    Invalid 1    All 3
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data which are not correct    Courier Service Name	            No such courier service -
    check data which are not correct    Country Code                        No such country code -
    wait element and click              css=button.close > span
    click button                        Remove
#
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
#
#

