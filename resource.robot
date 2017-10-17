*** Settings ***
Documentation                   Resource file
Library                         Collections
Library                         DateTime
Library                         String
Resource                        locators.robot
Library                         Selenium2Library     timeout=40     run_on_failure=On Fail
Library                         ImapLibrary
Library                         XvfbRobot
#Library                         AllureReportLibrary        Allure

Library                         plugins.py
#Library                         remote_inspect.py

*** Keywords ***

On Fail
    [Documentation]                      On Fail
    Set Screenshot Directory             ${OUTPUTDIR}/Errors/
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Set Screenshot Directory             ${OUTPUTDIR}/Screenshots/

Setup Tests
    Start Virtual Display               ${WIDTH}    ${HEIGHT}
    Open Browser                         ${SERVER}         ${BROWSER}
    set window size                      ${WIDTH}    ${HEIGHT}
    Register Keyword To Run On Failure   On Fail
    Set Screenshot Directory             ${OUTPUTDIR}/Screenshots/

Open Browser with Dev Tools                       [Arguments]         ${dev}
    ${dev}=                               dev tools
    log to console                        ${dev}
    [return]                              ${dev}
    ${options}=                           Evaluate            sys.modules['selenium.webdriver'].ChromeOptions()   sys
    Create WebDriver                      Chrome              chrome_options=${options}
    Go To                                 ${dev}

Login           [Arguments]              ${email}                  ${pass}
   Wait Until Page Contains Element       xpath=//h3[contains(.,"Login")]
   Input Text                          ${login_email}               ${email}
   Input Text                          ${login_pass}                ${pass}
   Click Element                       ${Signup}

Reset Password                          [Arguments]       ${new_p}             ${pass1}               ${pass2}          ${complete}
   wait until page contains            ${new_p}
   Input Text                          xpath=//input[@id='id_new_password1']               ${pass1}
   Input Text                          xpath=//input[@id='id_new_password2']               ${pass2}
   click button                      Change my password
   wait until page contains         ${complete}

Invalid Email - Reset Password                   [Arguments]          ${email}          ${error}
    input text                       name=email             ${email}
    click button                     Reset my password
    wait until page contains element     xpath=//li[contains(.,"${error}")]

Logout                  [Arguments]               ${text}
    mouse over                          xpath=//li[@class="user-tools-welcome-msg"]
    wait until element is visible       xpath=//li[@class="user-tools-link" and contains(.,"Log out")]
    click element                       xpath=//li[@class="user-tools-link" and contains(.,"Log out")]
    Wait Until Page Contains            ${text}

Mouse over and Click    [Arguments]           ${link}            ${group}
    wait until element is visible       xpath=//*[@class="left-menu-link ng-binding" and contains(.,"${link}")]
    mouse over                          xpath=//*[@class="left-menu-link ng-binding" and contains(.,"${link}")]
    wait element and click              xpath=//a[@href="${group}"]


Wait settings and Click            [Arguments]           ${link}
    Wait Element And Click                  xpath=//i[@class="icon icmn-cog ng-scope"]
    wait until element is visible           xpath=//div[@class="dropdown-menu dropdown-menu-right"]
    click element                         xpath=//a[@class="dropdown-item" and contains(.,"${link}")]


Create a new user                     [Arguments]               ${reg email}           ${name}
    Wait Until Page Contains            Send welcome email
    Input text                          name=email                   ${reg email}
    Input text                          name=first_name             ${name}
    Input text                          name=last_name              Last


Payment                    [Arguments]                ${price}
    input text             name=prepayment             ${price}
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Click Element                       xpath=//input[@class="submit-row"]



wait error this is required          [Arguments]      ${page}      ${field_error}               ${error}
    wait until page contains element   xpath=//*[@ng-model="$ctrl.${page}.${field_error}"]/..//li[contains(.,"${error}")]

wait error this is required (Admin)   [Arguments]      ${page}      ${error}
     wait until page contains element   xpath=//label[contains(.,"${page}")]/../..//li[contains(.,"${error}")]

wait error for Dimensions            [Arguments]         ${f_error}             ${main_error}
    wait until page contains element   xpath=//*[@ng-model="$ctrl.product.inventory_items.base_item.gross_${f_error}"]/..//li[contains(.,"${main_error}")]


#wait error in woocomerce               [Arguments]          ${error}                     ${name}
#    wait until page contains element   xpath=//li[@ng-repeat='error in $ctrl.errors.${error}' and contains(.,"${name}")]

Registration Invalid Data           [Arguments]              ${data}          ${text}
    input text                       xpath=//input[@ng-model='$ctrl.registration.${data}']            ${text}

Registration Long Data           [Arguments]              ${data}
    input text                       xpath=//input[@ng-model='$ctrl.registration.${data}']       ${long_symbols}
    #execute javascript               $(function () {$('[ng-model="$ctrl.registration.${data}"]').val("${long_symbols}");});

Select Country                      [Arguments]         ${country}
    click element                        xpath=//input[@type="search"]
    wait until element is visible       xpath=//div[@class="option ui-select-choices-row-inner" and contains(.,"${country}")]
    click element                       xpath=//div[@class="option ui-select-choices-row-inner" and contains(.,"${country}")]

Select Post                [Arguments]         ${post}
    click element                   xpath=//input[@type="search"]
    input text                      xpath=//input[@type="search"]            WMP YAM
    sleep                           2 sec
    wait element and click       xpath=//div[@ng-show='$select.open']//div[@class='ng-binding ng-scope']

Select Post Order               [Arguments]         ${post}
    click element                   xpath=//input[@type="search"][@aria-label="Choose a Courier Service"]
    input text                      //input[@type="search"][@aria-label="Choose a Courier Service"]            ${post}
    sleep                           1 sec
    wait element and click       xpath=//div[@ng-show='$select.open']//div[@class='ng-binding ng-scope']

Select Client Order              [Arguments]         ${client}
    click element                   xpath=//input[@type="search"][@placeholder="Select or search a client in the list..."]
    input text                      //input[@type="search"][@placeholder="Select or search a client in the list..."]            ${client}
    sleep                           1 sec
    wait element and click       xpath=//div[@ng-show='$select.open']//div[@class='ng-binding ng-scope']


Check Validation Form                  [Arguments]               ${page}
    wait until page contains        ${page}
    Save
    Capture Page Screenshot             ${TEST NAME}-{index}.png

Check Invalid Data Product
    wait until element is visible      ${customs_value_field}
    input text                         ${customs_value_field}              test
    input text                         ${width_field}                      test
    input text                        ${height_field}                      test
    input text                        ${length_field}                      test
    input text                        ${weight_field}                      test
    click button                     Save


Check Validation Form Group                  [Arguments]               ${page}
    wait until page contains        ${page}
    wait until page contains        Save
    click button                    Save
    Sleep                           1 sec



Full Valid Data                        [Arguments]     ${comp name}        ${email}
    reload page
    wait until element is visible      xpath=//input[@ng-model='$ctrl.registration.name']
    Registration Invalid Data           name                        ${comp name}
    Registration Invalid Data           client_address.email           ${comp email}
    Registration Invalid Data           client_contact.first_name      ${first name}
    Registration Invalid Data           client_contact.last_name       ${last name}
    Registration Invalid Data           client_contact.email           ${email}
    Registration Invalid Data           client_contact.phone           ${phone}
    Registration Invalid Data           client_address.address_1       ${address_1}
    Registration Invalid Data           client_address.city            ${city}
    Registration Invalid Data           client_address.state           ${state}
    Select Country                      United States of
    click button                        Register



Full Valid Data with Long Symbols
    wait until element is visible       xpath=//input[@ng-model='$ctrl.registration.name']
    Registration Long Data           name
    Registration Long Data           client_address.email
    Registration Long Data           client_contact.first_name
    Registration Long Data           client_contact.last_name
    Registration Long Data           client_contact.email
    Registration Long Data           client_contact.phone
    Registration Long Data           client_address.address_1
    Registration Long Data           client_address.city
    Registration Long Data           client_address.state
    Registration Long Data           client_address.phone
    Registration Long Data           client_address.fax
    click button                        Register



Wait Element And Click                [Arguments]                  ${locator}
    Sleep                           1 sec
    wait until page contains element          ${locator}
    click element                             ${locator}

Invalid Card Number                   [Arguments]              ${card valid}            ${exp date valid}   ${cvv valid}
    wait until page contains         Card Number
    click button                     Continue
    reload page
    Capture Page Screenshot             ${TEST NAME}-{index}.png

Create Card Number                     [Arguments]         ${card num}        ${exp date}       ${cvv}
    wait until page contains         Card Number
    input text                       name=cardNumber                ${card num}
    input text                       xpath=//input[@ng-model="$ctrl.creditCard.expirationDate"]                 ${exp date}
    input text                       xpath=//input[@ng-model="$ctrl.creditCard.cvv"]                            ${cvv}


Check Payment Request                  [Arguments]       ${payment}       ${price}
   wait until page contains element    xpath=//*[@class="ng-binding" and contains(.,"${payment}") and contains(.,"${price}")]
   wait until page contains element    xpath=//button[@disabled="disabled"]
   wait element and click              xpath=//input[@type="checkbox"]
   wait until page does not contain element    xpath=//button[@disabled="disabled"]
   Capture Page Screenshot             ${TEST NAME}-{index}.png
   click button                        Submit Payment




Select default 3pl                        [Arguments]          ${default}     ${show}
    wait until element is visible        xpath=//label[@for="${default}"]
    click element                        ${3pl}
    wait until element is visible        xpath=//ul[@id='select2-id_default_3pl-results']/li
    #wait until page contains element     xpath=//span[@class='select2-selection__rendered' and contains(@title,"${show}")]
    wait until element is visible        xpath=//input[@class="select2-search__field"]
    input text                           xpath=//input[@class="select2-search__field"]                    Geodis
    wait element and click               xpath=//li[@class="select2-results__option" and contains(.,"Geodis")]


Select default 3pl Admin                        [Arguments]          ${default}     ${show}
    wait until element is visible        xpath=//label[@for="${default}"]
    click element                        ${3pl}
    wait until element is visible        xpath=//span[@class="select2-search select2-search--dropdown"]/input
    input text                           xpath=//span[@class="select2-search select2-search--dropdown"]/input                    ${show}
    wait element and click               css=span > span:first-child > ul > li:nth-of-type(2)


select all from list client pls          [Arguments]           ${pls}
    wait element and click               xpath=//li/a[@class="changeform-tabs-item-link" and contains(.,"${pls}")]
    wait until page contains             Add another Client
    click element                        xpath=//div[@id='three_pls-group']//div[@class='add-row']/a
    wait until page contains element     xpath=//a[@class="inline-navigation-item selected" and contains(.,"${pls}")]
    click element                        xpath=//div[@class='form-row field-three_pl']//span[@role='combobox']
    wait until element is visible        xpath=//input[@class="select2-search__field"]
    input text                           xpath=//input[@class="select2-search__field"]                 Geodis
    wait element and click               xpath=//li[@class="select2-results__option" and contains(.,"Geodis")]

Search New Company In Admin Panel        [Arguments]                  ${clients}              ${company}           ${braintree}        ${refer}
    mouse over and click                 Customer                   /admin-backend/floship/client/
    wait until element is visible        name=q
    input text                           name=q                   ${company}
    click element                        xpath=//input[@value="Search"]
    Wait Element And Click               xpath=//tr[@class="row1"]//a[contains(.,"${company}")]
    wait until element is visible        xpath=//a[contains(.,"Aftership integration")]
    Select default 3pl                   id_default_3pl         Geodis
    Payment Method                       ${braintree}
    select all from list client pls      Client three pl
    input text                           css=#id_three_pls-0-reference_prefix              ${refer}
    click element                        xpath=//input[@name='_save']

Payment Method                     [Arguments]      ${braintree}
    wait element and click         id=select2-id_payment_method-container
    wait until element is visible        xpath=//input[@class="select2-search__field"]
    input text                           xpath=//input[@class="select2-search__field"]             ${braintree}
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    wait element and click               css=span > span:first-child > ul > li

Include Payment              [Arguments]        ${client}
    wait until element is visible        name=q
    input text                           name=q                   ${client}
    click element                        xpath=//input[@value="Search"]


Get Rand Company
    ${faker_kit}=                        Generate Random String     7              [NUMBERS]
    ${kit_num}                           Catenate	            SEPARATOR=1         ${comp name}          ${faker_kit}
    [return]                             ${kit_num}

Get Email
    ${faker_name}=                       Generate Random String     8    [LOWER]
    ${user}=                             Fetch From Left            ${MAIL_USER}        @
    ${host}=                             Fetch From Right           ${MAIL_USER}        @
    ${fake_mail}=                        Catenate	SEPARATOR=@    ${faker_name}    ${host}
    ${email}=                            Catenate	SEPARATOR=+    ${user}          ${fake_mail}
    [return]                             ${email}

Get Email Client                      [Arguments]          ${email}
    ${faker_name}=                       Generate Random String     8    [LOWER]
    ${user}=                             Fetch From Left            ${email}        @
    ${host}=                             Fetch From Right           ${email}         @
    ${fake_mail}=                        Catenate	SEPARATOR=@    ${faker_name}    ${host}
    ${email}=                            Catenate	SEPARATOR=+    ${user}          ${fake_mail}
    [return]                             ${email}


Add New Product                          [Arguments]          ${add}
    Wait Element And Click               xpath=//div[@class="modal-footer"]//a[contains(.,"${add}")]


Invalid Data
    Check Invalid Data Product

Valid Data              [Arguments]      ${sku_}     ${desc_}   ${cust_descr}     ${code}
    wait until element is visible      ${sku_field}
    input text                         ${sku_field}             ${sku_}
    input text                         ${description_field}      ${desc_}
    input text                         ${cust_description_field}  ${cust_descr}
    input text                         ${harmonized_code_field}    ${code}
    select from list                   ${packaging_combobox}              Ship ready
    input text                         ${customs_value_field}              99.99
    input text                         ${width_field}                      5
    input text                        ${height_field}                     1
    input text                        ${length_field}                     10
    input text                        ${weight_field}                     0.1
    Capture Page Screenshot             ${TEST NAME}-{index}.png

Long Symbols
    wait until element is visible      ${sku_field}
    input text                         ${sku_field}                  ${long_symbols}
    input text                         ${description_field}          ${long_symbols_61}
    input text                         ${cust_description_field}     ${long_symbols}
    input text                         ${harmonized_code_field}      ${long_symbols}
    input text                         ${product_upc}                ${long_symbols}



Edit Product                      [Arguments]       ${sku}      ${desc}
    Sleep                          3 sec
    wait element and click         xpath=//a[contains(.,"Edit")]
    wait until page contains         Edit Product ${sku}
    wait until element is visible   ${description_field}
    Sleep                            2 sec
    input text                         ${description_field}      ${desc}
    Save
    wait until page contains        Product ${sku}



Inner Carton
   input text                        ${inner_unit_qty}     1
   input text                        ${inner_width}         111
   input text                        ${inner_height}        222
   input text                        ${inner_length}        333
   input text                        ${inner_weight}          7

Master Carton
   input text                        ${master_unit_qty}     2
   input text                        ${master_width}        112
   input text                        ${master_height}       223
   input text                        ${master_length}       334
   input text                        ${master_weight}         8


Save
    wait element and click            xpath=//button[contains(.,"Save")]

Header Title                            [Arguments]           ${title}
    wait until page contains element       xpath=//span[@ng-if="!$ctrl.product.id" and contains(.,"${title}")]

Header title block                              [Arguments]               ${title}
   wait until page contains element         xpath=//h5[@class="modal-title" and contains(.,"${title}")]


click Add new               [Arguments]              ${add}
    wait element and click               xpath=//div[@class="modal-footer"]/a[contains(.,"${add}")]


Add New ASN                  [Arguments]                  ${add}
    Wait Element And Click               xpath=//div[@class="modal-footer"]//a[contains(.,"${add}")]

Empty Fields ANS             [Arguments]         ${error}               ${count}
    wait until page contains element      css=button.btn.btn-primary
    Check Validation Form            New ASN       ${error}               ${count}
    wait until element is visible        xpath=//li[@ng-bind="error" and contains(.,"Date has wrong format. Use one of these formats instead: YYYY[-MM[-DD]].")]
    wait until element is visible        xpath=//p[@class="dropify-error ng-binding ng-scope" and contains(.,"This field is required")]
    Capture Page Screenshot             ${TEST NAME}-{index}.png

Add Address in Form
   wait element and click               xpath=//i[@class="icmn-bookmark"]/../../a[contains(.,"Address Book")]
   wait element and click               xpath=//a[contains(.,"Select")]
   wait until page does not contain element    xpath=//a[contains(.,"Select")]

Valid Data ASN Address                          [Arguments]         ${first name}      ${post_code}            ${item}       ${id_ship}
    #calendar
    wait until page contains             New ASN
    Wait Element And Click               ${calendar_button}
    wait element and click               ${today_button}
    #click element                       ${upload_file}
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Sleep                               2 sec
    choose file                         xpath=//input[@type="file"]        ${CURDIR}/test_file.pdf
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    wait until page contains             File uploaded successfully
    input text                           ${contact_name_field}               ${first name}
    Add Address in Form
    input text                         ${postal_code_field}               ${post_code}
    input text                         ${items_field}                         ${item}
    wait element and click             ${items_list}
    wait until page contains element         xpath=//table[@class="table nowrap"]//td[contains(.,"${item}")]
    click button                       Save
    wait until page contains element       xpath=//table//td//a[contains(.,"${id_ship}")]
    Capture Page Screenshot             ${TEST NAME}-{index}.png


Valid Data ASN                          [Arguments]                           ${item}       ${id_ship}
    #calendar
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
    Select Country                     United States of
    input text                         ${items_field}                         ${item}
    wait element and click             ${items_list}
    wait until page contains element         xpath=//table[@class="table nowrap"]//td[contains(.,"${item}")]
    click button                       Save
    wait until page contains element       xpath=//table//td//a[contains(.,"${id_ship}")]
    Capture Page Screenshot             ${TEST NAME}-{index}.png


Long Symbols in Data ASN
    wait until element is visible         ${referense_asn}
    input text                           ${referense_asn}                    ${long_symbols}
    input text                           ${tracking_asn}                     ${long_symbols}
    input text                           ${contact_name_field}               ${long_symbols}
    input text                           ${full_name_field}                  ${long_symbols}
    input text                          ${address_1_field}                   ${long_symbols}
    input text                         ${city_field}                         ${long_symbols}
    input text                         ${postal_code_field}                  ${long_symbols}






Edit ASN                      [Arguments]        ${fsn}   ${first name}   ${state}    ${sku}       ${id_ship}
  wait element and click        xpath=//a[contains(.,"${fsn}")]
  wait element and click        xpath=//a[contains(.,"Edit")]
  wait until page contains      Edit ASN ${fsn}
  Wait Element And Click               ${calendar_button}
    wait element and click               ${today_button}
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    input text                         ${contact_name_field}               ${first name}
    input text                         ${state_field}                       ${state}
#    input text                         ${items_field}                         ${sku}
#    wait element and click             ${items_list}
#    wait until page contains element         xpath=//table[@class="table nowrap"]//td[contains(.,"${sku}")]
    click button                       Save
    wait until page contains element       xpath=//table//td//a[contains(.,"${id_ship}")]
    Capture Page Screenshot             ${TEST NAME}-{index}.png

Cancel before approving ASN                     [Arguments]        ${fsn}
  wait element and click        xpath=//tr[@class="ng-scope"][contains(.,"${fsn}")]//a
  wait until page contains      ASN ${fsn}
  Confirm ASN                   Cancel

Cancel before deleting ASN                     [Arguments]      ${del_asn}
  wait element and click        xpath=//a[contains(.,"${del_asn}")]
  wait until page contains      ASN ${del_asn}
  Confirm ASN                   Cancel


Approve ASN                     [Arguments]             ${fsn}
  Confirm ASN                   OK

Success Approved             [Arguments]                    ${fsn}           ${status}
  Sleep                         2 sec
  #wait until page contains        ASN was approved successfully
  wait until page contains element     xpath=//tr[@class="ng-scope"][contains(.,"${fsn}") and contains(.,"${status}")]

Delete ASN                  [Arguments]         ${del_asn}
  Confirm Delete                   OK

Success delete              [Arguments]       ${del_asn}
  wait until page does not contain element       xpath=//a[contains(.,"${del_asn}")]

Wait table                               [Arguments]             ${name}
   wait until page contains element       xpath=//table//td//a[contains(.,"${name}")]


show order is created           [Arguments]      ${id_order}         ${courier}      ${status}       ${stock}
   wait until page contains element          xpath=//*[@class="table table-hover nowrap" and contains(.,"${id_order}") and contains(.,"${courier}") and contains(.,"${status}") and contains(.,"${stock}")]

wait company                             [Arguments]           ${company}
   wait until page contains element           xpath=//table//td[contains(.,"${company}")]

Get Id ASN
    wait until element is visible             xpath=(//table//td//a[contains(.,"FASN")])[1]
    ${id}=                              Get Element Attribute           xpath=(//table//td//a[contains(.,"FASN")])[1]@text
    [return]                             ${id}


Get FASN in Admin     [Arguments]                  ${refer}
    wait until element is visible            xpath=//tr[@class="row1"][contains(.,"${refer}")]//td[contains(.,"FASN")]
    ${id}=                                get text      xpath=//tr[@class="row1"][contains(.,"${refer}")]//td[@class="field-floship_asn_number"]
    [return]                              ${id}

Get Id Order
    ${id}=                              Get Element Attribute           xpath=(//table//td//a[contains(.,"FS")])[1]@text
    [return]                             ${id}


Get Smt           [Arguments]
   ${get_fs}=                    get element attribute             xpath=//tr[@class="row1"]//a[contains(.,"FS")]@text
   log to console                 ${get_fs}
   [return]                             ${get_fs}

Get Id Adjustment      [Arguments]             ${status}
    ${id}                              get element attribute            xpath=//tr[@class="row1" and contains(.,"${status}")]//a@text
    [return]                           ${id}

Header link                             [Arguments]             ${link}
    wait element and click              xpath=//div[@class="left-menu-inner scroll-pane"]//a[contains(.,"${link}")]

Empty Fields Shipping               [Arguments]             ${add}
    wait element and click          xpath=//*[@class="btn btn-primary" and contains(.,"${add}")]
    Check Validation Form           New Shipping Option


Valid Data Shipping                 [Arguments]                ${Some}               ${post}
    wait until element is visible   ${som_name_field}
    input text                      ${som_name_field}                           ${Some}
    Select Post                     WMP YAMATO
    click element                   xpath=//a[@ng-click='$ctrl.selectAllCountries()']
    Sleep                           1 sec
    click button                    Save
    wait until page contains element      xpath=//table[@class="table table-hover nowrap"]/tbody//a[contains(.,"${Some}")]/../..//td[contains(.,"${post}")]
    Capture Page Screenshot             ${TEST NAME}-{index}.png

Edit Shipping Options                  [Arguments]       ${id_ship}
    wait element and click             xpath=//a[contains(.,"${id_ship}")]
    wait until page contains           Edit Shipping Option
    wait until element is visible   ${som_name_field}
    input text                      ${som_name_field}                           ${id_ship}
    Save
    wait until page contains element     xpath=//a[contains(.,"${id_ship}")]

Empty Fields Group Items                   [Arguments]               ${add}
    Mouse over and Click              Inventory            /inventory/group-items
    wait until page contains          Group Items List
    click element                     xpath=//div[@class="dropdown pull-right" and contains(.,"${add}")]
    Check Validation Form Group        New Group Item




Valid Data Group Items                      [Arguments]      ${cil}          ${desc_cil}                ${XM}     ${table_xm}
    wait until element is visible     ${sku_field_group}
    input text                        ${sku_field_group}                  ${cil}
    input text                        ${description_field_group}          ${desc_cil}
    input text                        ${items_field_gr}                  ${XM}
    wait element and click            xpath=//div[contains(@class,"angucomplete-row")]
    wait until page contains element         xpath=//table[@class="table table-hover nowrap"]//td[contains(.,"${table_xm}")]
    click button                      Save
    Wait table                        ${cil}
    Capture Page Screenshot             ${TEST NAME}-{index}.png


Edit Group Items                 [Arguments]             ${SKU}      ${desc_edit}     ${sku_prod}      ${table_xm}
    wait element and click            xpath=//a[contains(.,"${SKU}")]
    wait element and click             xpath=//a[contains(.,"Edit")]
    wait until page contains          Edit Group Item ${SKU}
#    wait element and click        xpath=//*[@class="btn btn-danger"]
#    wait until page does not contain element      xpath=//*[@class="btn btn-danger"]
    input text                        ${description_field_group}           ${desc_edit}
    input text                        ${items_field_gr}                  ${sku_prod}
    wait element and click            xpath=//div[contains(@class,"angucomplete-row")]
    wait until page contains element         xpath=//table[@class="table table-hover nowrap"]//td[contains(.,"${table_xm}")]
    click button                      Save
    Wait table                        ${SKU}


Empty Fields Order                [Arguments]                   ${add}
    Mouse over and Click              Orders          /orders
    wait until page contains        All Orders
    wait element and click          xpath=//*[@class="btn btn-primary" and contains(.,"${add}")]
    Check Validation Form            New Order

Invalid Data Order
    wait until element is visible    ${phone_field_order}
    input text                       ${phone_field_order}                      test
    input text                       ${value_order}                            test
    click button                     Save


Valid Data Order                  [Arguments]      ${id_order}  ${courier}    ${Xm}    ${table_xm}       ${status}
    ${id}=                          Get Rand ID          ${order_id}
    wait until element is visible     ${full_name_field_order}
    wait until page contains element      ${full_name_field_order}
    input text                       ${full_name_field_order}                  ${first name}${last name}
    input text                       ${address_1_field_order}                  ${address_1}
    input text                       ${city_field_order}                        ${city}
    input text                       ${state_field_order}                       ${state}
    input text                       ${postal_code_field_order}                ${post_code}
    Select Country                   ${country}
    input text                       ${phone_field_order}                      ${phone}
    input text                       ${order_id_field}                         ${id_order}
    Select Post Order                ${courier}
    input text                         ${items_field_order}                         ${Xm}
    wait element and click             xpath=//div[@class="angucomplete-title ng-binding ng-scope" and contains(.,"${Xm}") and contains(.,"${status}")]
    wait until page contains element         xpath=//td[contains(.,"${table_xm}")]
    click button                      Save


Valid Data Order via Address                  [Arguments]    ${phone}       ${id_order}     ${Xm}    ${table_xm}       ${status}       ${id_floship}
    wait until page contains element      ${full_name_field_order}
    Add Address in Form
    input text                       ${phone_field_order}                      ${phone}
    input text                       ${order_id_field}                         ${id_order}
    Select Post Order                WMP YAMATO
    input text                         ${items_field_order}                         ${Xm}
    wait element and click             xpath=//div[@class="angucomplete-title ng-binding ng-scope" and contains(.,"${Xm}") and contains(.,"${status}")]
    wait until page contains element         xpath=//td[contains(.,"${table_xm}")]
    click button                      Save

Long Symbols for Order
    wait until element is visible     ${full_name_field_order}
    input text                       ${order_company}                          ${long_symbols}
    #input text                       ${full_name_field_order}                  ${long_symbols}
    #input text                       ${address_1_field_order}                  ${long_symbols}
    input text                       ${city_field_order}                       ${long_symbols}
    input text                       ${postal_code_field_order}                ${long_symbols}
    input text                       ${phone_field_order}                      ${long_symbols_60}
    input text                       ${order_id_field}                         ${long_symbols}


Edit Order                      [Arguments]     ${id_order}     ${Xm}         ${status}      ${table_xm}
    wait element and click            xpath=//a[contains(.,"${id_order}")]
    wait until page contains element        xpath=//a[contains(@ng-if,"$ctrl.order.is_order_editable")]
    wait until page contains element        xpath=//button[contains(@ng-repeat,"action in actions")]
    wait element and click             xpath=//a[contains(.,"Edit")]
    wait until page contains          Edit Order
    wait until page contains element      ${full_name_field_order}
    input text                       ${full_name_field_order}                  ${first name}${last name}
    input text                       ${address_1_field_order}                  ${address_1}
#    input text                         ${items_field_order}                         ${Xm}
#    wait element and click             xpath=//div[@class="angucomplete-title ng-binding ng-scope" and contains(.,"${Xm}") and contains(.,"${status}")]
#    wait until page contains element         xpath=//td[contains(.,"${table_xm}")]

Show processing by tracking number        [Arguments]                ${ship}             ${in_tran}           ${deliv}
   wait until page contains element          //ul[@role="tablist" and contains(.,"${ship}") and contains(.,"${in_tran}") and contains(.,"${deliv}")]



Edit Order Admin                      [Arguments]     ${id_order}         ${status}
    wait element and click            xpath=//a[contains(.,"${id_order}")]
    wait element and click             xpath=//a[contains(.,"Edit")]
    wait until page contains          Edit Order
    wait until page contains element      ${full_name_field_order}
    input text                       ${full_name_field_order}                  ${first name}${last name}
    input text                       ${address_1_field_order}                  ${address_1}
    click element                      xpath=//label[contains(.," Save to address book")]/input
    #wait element and click             css=span.remove
    input text                        xpath=(//input[@type="search"][@aria-label="Choose an exception"])[1]                ${status}
    sleep                           1 sec
    wait element and click       xpath=//div[@ng-show='$select.open']//div[@class='ng-binding ng-scope']

Show data in order            [Arguments]     ${field}              ${text}
    wait until page contains element            xpath=//tbody/tr[contains(.,"${field}") and contains(.,"${text}")]

show status order    [Arguments]     ${text}            ${status}
   wait until page contains element            xpath=//div[@class="panel-body" and contains(.,"${text}") and contains(.,"${status}")]


check fields in order (item)           [Arguments]     ${data}
   wait until page contains element            xpath=//div[@class="panel"]//th[contains(.,"${data}")]

check item(SKU) after edit               [Arguments]        ${colon}          ${data}
   wait until page contains element        xpath=//div[@class="panel-body panel-table" and contains(.,"${colon}") and contains(.,"${data}")]

Summary block (Order)               [Arguments]          ${text}       ${price}
  wait until page contains element      xpath=//*[@class="table table-attributes"]//tr[contains(.,"${text}") and contains(.,"${price}")]

check labels order                  [Arguments]        ${label}
   wait until page contains element            xpath=//label[contains(.,"${label}")]

check labels order (Admin)         [Arguments]        ${label}
   wait until page contains element            xpath=//td[contains(.,"${label}")]

Check Package Item (Order)            [Arguments]           ${colon}              ${data}
  wait until page contains element            xpath=//div[@class="panel-body" and contains(.,"${colon}") and contains(.,"${data}")]

Empty Fields Address Book                [Arguments]        ${add}
    Wait settings and Click        Address Book
    wait until page contains        Address Book
    wait element and click          xpath=//*[@class="btn btn-primary" and contains(.,"${add}")]
    Check Validation Form            New Address

invalid email in address            [Arguments]        ${field}         ${error}
    input text                    xpath=//input[@ng-model="$ctrl.address.email"]              ${field}
    click button                  Save
    wait error this is required   address         email                       ${error}

Valid Data Address Book
    wait until element is visible       ${company_field_address}
    input text                          ${company_field_address}              ${mycompany}
    input text                          ${full_name_field_address}            ${first_name} ${last_name}
    input text                          ${address_1_field_address}            ${address_1}
    input text                          ${city_field_address}                 ${city}
    input text                          ${state_field_address}                ${state}
    input text                          ${postal_code_field_address}          ${post code}
    Select Country                      ${country}
    click button                        Save
    wait company                           ${mycompany}


Long Symbols Address
    wait until element is visible       ${company_field_address}
#    execute javascript                  $(function () {$('[ng-model="$ctrl.address.company"]').val("${long_symbols}");});
#    execute javascript                  $(function () {$('[ng-model="$ctrl.address.addressee"]').val("${long_symbols}");});
#    execute javascript                  $(function () {$('[ng-model="$ctrl.address.address_1"]').val("${long_symbols}");});
#    execute javascript                  $(function () {$('[ng-model="$ctrl.address.address_2"]').val("${long_symbols}");});
#    execute javascript                  $(function () {$('[ng-model="$ctrl.address.city"]').val("${long_symbols}");});
#    execute javascript                  $(function () {$('[ng-model="$ctrl.address.postal_code"]').val("${long_symbols}");});
#    execute javascript                  $(function () {$('[ng-model="$ctrl.address.phone"]').val("${long_symbols}");});
#    execute javascript                  $(function () {$('[ng-model="$ctrl.address.phone"]').val("${long_symbols}");});
    input text                          ${company_field_address}              ${long_symbols}
    input text                          ${full_name_field_address}            ${long_symbols}
    input text                          ${address_1_field_address}            ${long_symbols}
    input text                          ${city_field_address}                 ${long_symbols}
    input text                          ${state_field_address}                ${long_symbols}
    input text                          ${postal_code_field_address}          ${long_symbols}
    input text                          ${state_field_address}                ${long_symbols}
    input text                          ${postal_code_field_address}          ${long_symbols}
    input text                          ${phone_address}                      ${long_symbols}


Edit Address                      [Arguments]     ${name}
    wait element and click            xpath=//a[contains(.,"${name}")]
    wait until page contains          Edit Address
    input text                          ${company_field_address}              ${mycompany}
    click button                        Save
    wait company                           ${mycompany}



Links Integration                  [Arguments]           ${link}             ${new}
    wait element and click         xpath=//div[@class="dropdown margin-inline" and contains(.,"Add Integration")]
    wait element and click        xpath=//ul[@class="dropdown-menu"]/a[contains(.,"${link}")]
    wait until page contains      ${new}

Validation Links               [Arguments]     ${button}
    Sleep                         1 sec
    click button                  ${button}
    #wait until page contains           This field is required
    Capture Page Screenshot             ${TEST NAME}-{index}.png



Check Links Orders
    Mouse over and Click               Orders      /orders
    wait until page contains           Order List
    Mouse over and Click               Orders      /orders?status=incomplete
    wait until page contains           Order List
    Mouse over and Click               Orders      /orders?status=pending_approval
    wait until page contains           Order List
    Mouse over and Click               Orders      /orders?status=pending_fulfillment
    wait until page contains           Order List
    Mouse over and Click               Orders      /orders?status=fulfilled
    wait until page contains           Order List
    Mouse over and Click               Orders      /orders?status=canceled
    wait until page contains           Order List
#    Mouse over and Click               Orders      /orders?status=closed
#    wait until page contains           Order List

Check Links Inventory
    Mouse over and Click               Inventory      /inventory/products
    wait until page contains           Product List
    Mouse over and Click               Inventory       /inventory/group-items
    wait until page contains           Group Items List

Check Links Billing
   Wait settings and Click        Billing
   wait until page contains       Settings
   wait until page contains       Billing Details
   click element                  xpath=//div[@class="messaging-list-item" and contains(.,"Preference")]
   wait until page contains       Preferences

Logout Client
   Wait settings and Click        Logout
   Sleep                          1 sec

########## Integrations


Check Links in Shopify
   Links Integration              Shopify            New Shopify Integration
   Validation Links               Continue
   wait error this is required    shopify    shop_domain        This field is required
   #click element                   css=button.close > span

Check Enter data Integration      [Arguments]         ${text}
   input text                   xpath=//input[@ng-model="$ctrl.shopify.shop_domain"]     ${text}
   click button                 Continue



Check Links in Magento
   Links Integration              Magento            Magento Integration
   Validation Links               Save
   wait error this is required     magento          shop_url      This field may not be blank.
   wait error this is required    magento        api_user         This field is required
   wait error this is required    magento        api_key          This field is required

Check Enter data Integration Magento     [Arguments]             ${text}     ${text2}      ${text3}
   input text                   xpath=//input[@ng-model="$ctrl.magento.shop_url"]     ${text}
   input text                   xpath=//input[@ng-model="$ctrl.magento.api_user"]        ${text2}
   input text                   xpath=//input[@ng-model="$ctrl.magento.api_key"]         ${text3}
   click button                 Save

Check Links in Magento 2
   Links Integration              Magento 2            Magento 2 Integration
   Validation Links               Save
   wait error this is required    magento2        base_url                     This field is required
   wait error this is required    magento2        api_user                     This field is required
   wait error this is required    magento2        api_password                 This field is required

Check Enter data Integration Magento 2    [Arguments]             ${text}          ${text2}         ${text3}
   input text                   xpath=//input[@ng-model="$ctrl.magento2.base_url"]        ${text}
   input text                   xpath=//input[@ng-model="$ctrl.magento2.api_user"]        ${text2}
   input text                   xpath=//input[@ng-model="$ctrl.magento2.api_password"]    ${text3}
   click button                 Save


Check Links in Woocommerce
   Links Integration              WooCommerce            Woocommerce Integration
   Validation Links               Save
   wait error this is required    woocommerce          shop_url                        This field is required
   wait error this is required    woocommerce          consumer_key                    This field is required
   wait error this is required    woocommerce          consumer_secret                 This field is required

Check Enter data Woocommerce    [Arguments]             ${text}          ${text2}         ${text3}
   input text                   xpath=//input[@ng-model="$ctrl.woocommerce.shop_url"]     ${text}
   input text                   xpath=//input[@ng-model="$ctrl.woocommerce.consumer_key"]     ${text2}
   input text                   xpath=//input[@ng-model="$ctrl.woocommerce.consumer_secret"]     ${text3}
   click button                 Save


Check Links in Aftership
   Links Integration              Aftership            Aftership Integration
   Validation Links               Save
   wait error this is required   aftership       api_key                 This field is required

Check Links in Amason
   Links Integration              Amazon             Amazon Integration
   Validation Links               Save
   wait error this is required    amazon          shop_name                        This field is required
   wait error this is required    amazon          seller_id                    This field is required
   wait error this is required    amazon          mws_auth_token                 This field is required

Check Links in Shipstation
   Links Integration              ShipStation             ShipStation Integration
   Validation Links               Save
   wait error this is required    shipstation          shop_name                        This field is required
   wait error this is required    shipstation          api_key                   This field is required
   wait error this is required    shipstation          api_secret                 This field is required


Check Enter data Shipstation
















Password do not match      [Arguments]              ${old_pass}           ${pass1}
    input text                     name=old_password             ${old_pass}
    input text                     name=new_password1            ${pass1}
    input text                     name=new_password2            12345
    click button                   Change my password
    wait until page contains element  xpath=//div[@class="form-control-error" and contains(.,"The two password fields didn't match.")]
    Capture Page Screenshot             ${TEST NAME}-{index}.png

Old password incorectly      [Arguments]      ${pass1}              ${pass2}
    Wait settings and Click        Change Password
    wait until page contains       Password change
    click button                   Change my password
    input text                     name=old_password             12345
    input text                     name=new_password1            ${pass1}
    input text                     name=new_password2            ${pass2}
    click button                   Change my password
    wait until page contains element  xpath=//div[@class="form-control-error" and contains(.,"Your old password was entered incorrectly. Please enter it again.")]
    Capture Page Screenshot             ${TEST NAME}-{index}.png

Change Password                    [Arguments]      ${old_pass}    ${pass1}   ${pass2}

     input text                     name=old_password             ${old_pass}
     input text                     name=new_password1            ${pass1}
     input text                     name=new_password2            ${pass2}
     click button                   Change my password
     wait until page contains       Dashboard

Get Mail link Temp                            [Arguments]            ${res}
    ${url_right}=                        Fetch From Right     ${res}["mail_text_only"]    /password/reset
    ${url_left}=                         Fetch From Left      ${url_right}           \\n
    ${url}=                              Fetch From Left      ${url_left}            <br>
    ${link}=                             Catenate             SEPARATOR=             ${SERVER}/password/reset           ${url}
    [return]                             ${link}

Get Mail link Gmail                           [Arguments]            ${res}
    ${url_right}=                        Fetch From Right     "${res}"                          /password/reset/
    ${url_left}=                         Fetch From Left      ${url_right}           \r\n
    ${link}=                             Catenate             SEPARATOR=             ${SERVER}/password/reset/           ${url_left}
    [return]                             ${link}

Check Mail                               [Arguments]          ${email}               ${message_id}
    ${result}=                           get mailbox          ${email}               ${message_id}
    Should Not Contain                   ${result}            'error'
    [return]                             ${result}

Check Mail Post Shift                               [Arguments]          ${key}               ${subject}
    ${id}=                               Get Mail Id          ${key}               ${subject}https://github.com/jcreigno/nodejs-mail-notifier
    log to console                       ${id}
    Should Not Be Equal                  ${id}                error
    ${message}=                          Get Message          ${key}               ${id}
    log to console                       ${id}
    [return]                             ${message}


#Check Mail Subj                          [Arguments]            ${email}         ${subject}
#    ${Last_mail}=                        Wait For Email          recipient=${email}      subject=${subject}     timeout=60
#    ${parts}=                            Walk Multipart Email    ${Last_mail}
#    :FOR    ${i}    IN RANGE    ${parts}
#    \    Walk Multipart Email    ${Last_mail}
#    \    ${content-type} =    Get Multipart Content Type
#    \    Continue For Loop If    '${content-type}' != 'text/plain'
#    \    ${payload} =    Get Multipart Payload    decode=True
#    Delete Email                         ${Last_mail}
#    [return]                             ${payload}


Check All Mail                           [Arguments]          ${email}
    ${result}=                           get mailbox          ${email}
    [return]                             ${result}


Click Orders                [Arguments]                   ${add}
    Mouse over and Click              Orders          All Orders
    wait until page contains        All Orders
    wait element and click          xpath=//*[@class="btn btn-primary" and contains(.,"${add}")]

Get Rand ID        [Arguments]          ${id}
    ${faker_kit}=                        Generate Random String     6              [NUMBERS]
    ${kit_num}                           Catenate	            SEPARATOR=1         ${id}          ${faker_kit}
    [return]                             ${kit_num}

Get Rand FS        [Arguments]          ${id}
    ${faker_kit}=                        Generate Random String     6              [NUMBERS]
    ${kit_num}                           Catenate	            SEPARATOR=0         ${id}          ${faker_kit}
    [return]                             ${kit_num}



Get Rand Shipping Name
    ${faker_kit}=                        Generate Random String     6              [NUMBERS]
    ${kit_num}                           Catenate	            SEPARATOR=1         ${shipping_name}          ${faker_kit}
    [return]                             ${kit_num}

Get Rand Sku
    ${faker_kit}=                        Generate Random String     4              [NUMBERS]
    ${kit_num}                           Catenate	            SEPARATOR=1         ${sku name}          ${faker_kit}
    [return]                             ${kit_num}

Get Rand Desc
    ${faker_kit}=                        Generate Random String     4              [NUMBERS]
    ${kit_num}                           Catenate	            SEPARATOR=1         ${desc name}          ${faker_kit}
    [return]                             ${kit_num}

Search Data                            [Arguments]            ${name}
    sleep                                   2 sec
    input text                              id=_value               ${name}
    wait element and click                  xpath=//div[@class="angucomplete-group ng-scope" and contains(.,"${name}")]

Search in Client                  [Arguments]           ${id}
   wait until page contains element                xpath=//div[@class="search-block"]//input
   input text                                      xpath=//div[@class="search-block"]//input       ${id}
   click element                                   xpath=//div[@class="search-block"]//button


Search Not Found         [Arguments]               ${name}
    sleep                                   2 sec
    input text                              id=_value               ${name}

Check Data                     [Arguments]           ${name}           ${equal}
    wait until page contains element          xpath=//tbody//td[contains(.,"${name}")]/..//td[contains(.,"${equal}")]


Check Order Data             [Arguments]        ${type}          ${name}
   wait until page contains element          xpath=//div[@class="panel-body panel-table"]//tr[contains(.,"${type}") and contains(.,"${name}")]

Check Data Tracking             [Arguments]         ${trac}           ${numb}
   wait until page contains element       xpath=//div[@class="panel-body" and contains(.,"${trac}") and contains(.,"${numb}")]


Check Data Stock              [Arguments]          ${name}
    wait until page contains element                xpath=//div[@class="col-md-12"]//tbody[contains(.,"${name}")]
    wait element and click                                   css=button.close > span

# Admin

Header link Admin               [Arguments]     ${link}           ${header}
   wait element and click                  xpath=//a[@class="changeform-tabs-item-link" and contains(.,"${link}")]
   wait until page contains               ${header}


Select User                    [Arguments]         ${id}       ${user}
    wait element and click                  xpath=//span[@id="${id}"]
   wait until element is visible        xpath=//input[@class="select2-search__field"]
   input text                           xpath=//input[@class="select2-search__field"]           ${user}
    wait element and click                  xpath=//li[@class="select2-results__option select2-results__option--highlighted" and contains(.,"${user}")]

Select Three pl                     [Arguments]             ${pl}
    wait element and click          ${three_pl}
    wait until element is visible           xpath=//input[@class="select2-search__field"]
    input text                              xpath=//input[@class="select2-search__field"]          ${pl}
    wait element and click                  css=span > span:nth-of-type(2) > ul > li:nth-of-type(2)

Select ASN            [Arguments]       ${geodis}
    wait element and click                  xpath=//span[@aria-labelledby='select2-id_three_pl-container']
    wait until element is visible           xpath=//input[@class="select2-search__field"]
    input text                              xpath=//input[@class="select2-search__field"]          ${geodis}
    wait element and click                  css=span > span:nth-of-type(2) > ul > li:nth-of-type(2)

Select Client         [Arguments]              ${num}           ${user}
   wait element and click                  xpath=(//span[@class="select2-selection select2-selection--single"])[${num}]
   wait until element is visible           xpath=//input[@class="select2-search__field"]
   input text                              xpath=//input[@class="select2-search__field"]                    ${user}
   wait element and click                  xpath=//li[@class="select2-results__option select2-results__option--highlighted" and contains(.,"${user}")]

Select Client Crowd          [Arguments]         ${client}
   wait element and click                  xpath=//span[@aria-labelledby="select2-id_ordercsvupload_set-0-client-container"]
   wait until element is visible           xpath=//input[@class="select2-search__field"]
   input text                              xpath=//input[@class="select2-search__field"]                    ${client}
   wait element and click                  xpath=//li[@class="select2-results__option select2-results__option--highlighted" and contains(.,"${client}")]

Select Courie         [Arguments]          ${cour}
   wait element and click                  xpath=//div[@class="form-row field-ship_via"]//span[@role="combobox"]
   wait until element is visible           xpath=//input[@class="select2-search__field"]
   input text                              xpath=//input[@class="select2-search__field"]                 ${cour}
   wait element and click                  xpath=//li[@class="select2-results__option select2-results__option--highlighted" and contains(.,"${cour}")]

Select Client Country        [Arguments]         ${id_country}        ${country}
    wait element and click                 xpath=//span[@id="${id_country}"]
    wait until element is visible          xpath=//input[@class="select2-search__field"]
    input text                             xpath=//input[@class="select2-search__field"]                ${country}
    wait element and click                 xpath=//li[@class="select2-results__option select2-results__option--highlighted" and contains(.,"${country}")]

Input data in field  [Arguments]            ${id}              ${data}
    wait until element is visible         xpath=//input[@id="${id}"]
    input text                            xpath=//input[@id="${id}"]                ${data}

Create Sales Order   [Arguments]         ${phone}         ${id_order}   ${client}      ${Xm}    ${table_xm}       ${status}
    wait until page contains element      ${full_name_field_order}
    input text                       ${full_name_field_order}                  ${first name}${last name}
    input text                       ${address_1_field_order}                  ${address_1}
    input text                       ${city_field_order}                        ${city}
    input text                       ${state_field_order}                       ${state}
    input text                       ${postal_code_field_order}                ${post_code}
    Select Country                   ${country}
    input text                       ${phone_field_order}                      ${phone}
    input text                       ${order_id_field}                         ${id_order}
    Select Post Order                WMP YAMATO
    Select Client Order                ${client}
    input text                         ${items_field_order}                         ${Xm}
    wait element and click             xpath=//div[@class="angucomplete-title ng-binding ng-scope" and contains(.,"${Xm}") and contains(.,"${status}")]
    wait until page contains element         xpath=//td[contains(.,"${table_xm}")]
    click button                      Save


Show in Table        [Arguments]           ${fsn}  ${cpo}   ${track}        ${cour}
    wait until page contains element          xpath=//tr[contains(@class,"row")][contains(.,"${fsn}") and contains(.,"${cpo}") and contains(.,"${track}") and contains(.,"${cour}")]

Show Product           [Arguments]              ${sku}         ${desc}
    wait until page contains element          xpath=//tr[@class="row1"][contains(.,"${sku}") and contains(.,"${desc}")]

Sales Order Cost in Table        [Arguments]           ${fsn}  ${cpo}   ${track}        ${cour}    ${cost}              ${margin}
    wait until page contains element          xpath=//tr[contains(@class,"row")][contains(.,"${fsn}") and contains(.,"${cpo}") and contains(.,"${track}") and contains(.,"${cour}") and contains(.,"${cost}") and contains(.,"${margin}")]

Vendor bill item in Table        [Arguments]           ${fsn}  ${cpo}   ${track}        ${cour}    ${cost}              ${margin}      ${labor_cost}         ${ship_cost}
    wait until page contains element          xpath=//tr[contains(@class,"row")][contains(.,"${fsn}") and contains(.,"${cpo}") and contains(.,"${track}") and contains(.,"${cour}") and contains(.,"${cost}") and contains(.,"${margin}") and contains(.,"${labor_cost}") and contains(.,"${ship_cost}")]


Show ASN             [Arguments]           ${refer}
    wait until page contains element           xpath=//tr[@class="row1"][contains(.,"${refer}")]//td[contains(.,"FASN")]



# Admin->Product

Select Fields (Add another)               [Arguments]       ${aria}   ${item}
   wait element and click                  xpath=//span[@aria-labelledby="${aria}"]
   wait until element is visible           xpath=//input[@class="select2-search__field"]
   input text                              xpath=//input[@class="select2-search__field"]         ${item}
   wait element and click                  xpath=//li[contains(@class,"select2-results__option") and contains(.,"${item}")]


Check Add Somethings (Admin)      [Arguments]          ${text}
   wait element and click             xpath=//a[contains(.,"${text}")]
   wait until page contains            ${text}
   wait element and click             name=_save

Click on Item in Table       [Arguments]               ${item}
   wait element and click            xpath=//tr[@class="row1"][contains(.,"${item}")]//a


# General
Create Product Admin            [Arguments]          ${user}         ${id_sku}       ${desc}
    Select Client                  1    ${user}
    input data in field               id_sku                ${id_sku}
    input data in field               id_description        ${desc}
    #Select Client Country          select2-id_country_of_manufacture-container            United States of America
    input data in field            id_customs_value_0                    10
    input data in field            id_customs_description                test_desc

# Inventory Items
Add SKU and Item for Product (Admin)       [Arguments]                   ${item}        ${sku_admin}
     header link admin             Inventory items               Add another Inventory item
     click element                 xpath=//div[@class="add-row" and contains(.,"Add another Inventory item")]
     wait until page contains       Inventory item
     Select Fields (Add another)    select2-id_inventory_items-0-client-container     ${item}
     input text                     css=#id_inventory_items-0-sku              ${sku_admin}
     Select Fields (Add another)    select2-id_inventory_items-0-three_pl-container            Geodis
     input text                     css=#id_inventory_items-0-gross_weight                     11
     input text                     css=#id_inventory_items-0-gross_length                     22
     input text                     css=#id_inventory_items-0-gross_width                     33
     input text                     css=#id_inventory_items-0-gross_height                     5
     input text                     css=#id_inventory_items-0-customs_value_0                 100
     click element                  name=_save

#Edit Product Admin
Edit Product Admin             [Arguments]       ${sku}     ${user}         ${id_sku}       ${desc}
    Click on Item in Table        ${sku}
    wait until page contains      Change product
    Create Product Admin          ${user}         ${id_sku}       ${desc}
    wait element and click        name=_save

Sorting            [Arguments]           ${item}
   wait element and click            xpath=//table[@id="result_list"]//a[contains(.,"${item}")]
   wait until page contains element      xpath=//tr[@class="row1"]
   wait element and click            xpath=//table[@id="result_list"]//a[contains(@title,"Remove from sorting")]

Sorting for FAD            [Arguments]           ${item}           ${first}        ${last}
   wait element and click            xpath=//table[@id="result_list"]//a[contains(.,"${item}")]
   wait until page contains element      xpath=//tr[@class="row1"]//a[contains(.,"${first}")]
   wait element and click            xpath=//table[@id="result_list"]//a[contains(@title,"Remove from sorting")]
   wait until page contains element      xpath=//tr[@class="row1"]//a[contains(.,"${last}")]

Sorting for FASN            [Arguments]           ${item}           ${first}        ${last}
   wait element and click            xpath=//*[@class="table table-hover"]//a[contains(.,"${item}")]
   wait until page contains element      xpath=//tr[@class="row1"]//td[contains(.,"${first}")]
   wait element and click            xpath=//table[@id="result_list"]//a[contains(@title,"Remove from sorting")]
   wait until page contains element      xpath=//tr[@class="row1"]//td[contains(.,"${last}")]



Product Quality            [Arguments]          ${prod}        ${name}          ${value}
   wait until page contains element       xpath=//div[@class="form-row field-product_quantity" and contains(.,"${prod}")]//input[@name="${name}" and contains(@value,"${value}")]



##############################################################
Upload Item File              [Arguments]       ${client}   ${bulk}    ${file}
      Select Fields           Client              ${client}      ${client}
      choose file             xpath=//input[@type="file"]        ${CURDIR}/bulk/${bulk}/${file}

Create ASN Admin            [Arguments]          ${user}     ${reference}      ${tracking}
    Header link Admin              General                   Floship ASN number
    Select Client                    1      ${user}
    Select ASN                      Geodis
    input data in field            id_client_reference_number                ${reference}
    Data Today                     1
    input data in field               id_contact_name                Mr.Contact
    input data in field            id_tracking_number                    ${tracking}
    input data in field            id_packaging_list                www.www.www
    click element                  name=_save

Add SKU in ASN in Admin             [Arguments]            ${client}
    Header link Admin              ASN items                   Add another ASN item
    wait until page contains       ASN item
    click element                 xpath=//div[@class="add-row" and contains(.,"Add another ASN item")]
    Select Fields                  Inventory item            ${client}                 ${client}
    input text                     css=#id_asn_lines-0-quantity               123

Check ASN Approve              [Arguments]       ${fasn}     ${generate}
    wait element and click        xpath=//*[@class="field-date_formated"]/a
    wait until page contains      Change ASN
    wait element and click            xpath=//input[contains(@value,"${generate}")]



Check does not exist SKU        [Arguments]         ${item}
    wait element and click        xpath=//*[@class="field-date_formated"]/a
    wait until page contains      Change ASN
    Header link Admin              ASN items                   Add another ASN item
    wait until page contains       ASN item
    wait element and click                  xpath=//label[contains(.,"${item}")]/..//span
    wait until element is visible           xpath=//input[@class="select2-search__field"]
    input text                              xpath=//input[@class="select2-search__field"]          No
    wait element and click                  xpath=(//*[@class="select2-results__options"]/li)[1]
    click element                 name=_save

checkbox                 [Arguments]                  ${check}
   wait element and click               xpath=//div[@class="checkbox-row"]//label[contains(.,"${check}")]
   Sleep                                1 sec


Invalid User Name                [Arguments]           ${user}          ${err_name}        ${err_pass}
    wait element and click            xpath=//a[contains(.,"Add user")]
    wait until page contains          Add user
    input data in field              id_username                   ${user}
    click element                    name=_save
    wait until page contains       ${err_name}
    xpath should match x times         //ul[@class="errorlist"]/li[contains(.,"${err_pass}")]            2


Create User            [Arguments]             ${user}          ${pass}          ${pass2}
    input data in field           id_username                   ${user}
    input data in field           id_password1                  ${pass}
    input data in field           id_password2                  ${pass2}
    click element                 name=_save

Settings User           [Arguments]     ${name}     ${lname}         ${email}
    wait until page contains            Change user
    header link admin                  Personal info              First name
    input data in field                id_first_name              ${name}
    input data in field                id_last_name               ${lname}
    input data in field                id_email                   ${email}


Select Group              [Arguments]          ${group}
    wait element and click                  xpath=//label[@for="id_groups"]/..//ul
    wait until element is visible           xpath=//span/input[@class="select2-search__field"]
    input text                              xpath=//span/input[@class="select2-search__field"]          ${group}
    wait element and click                  xpath=//li[contains(@class,"select2-results__option") and contains(.,"${group}")]

Select role (super user)
    header link admin                  Permissions              Staff status
    checkbox                           Staff status
    checkbox                           Superuser status
    click element                 name=_save

Select role (staff user)
    header link admin                  Permissions              Staff status
    checkbox                           Staff status
    Select Group                 Operations
    click element                 name=_save

Select role (3pl user)
    header link admin                  Permissions              Staff status
    checkbox                           Staff status
    Select Group                 Warehouse FLS
    click element                 name=_save


Scroll Page To Location          [Arguments]       ${x}      ${y}
    execute javascript           window.ScrollTo(${x}),${y})


Create Client                [Arguments]                ${client_name}           ${find_user}               ${email_client}       ${rand_refer}
    wait element and click          xpath=//a[contains(.,"Add client")]
    wait until page contains        Add client
    input data in field             id_name                    ${client_name}
    #Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Select default 3pl Admin        id_default_3pl         Geodis
    wait element and click          xpath=//label[@for="id_has_agreed_to_tos"]
    Select User                     select2-id_current_onboarding_step-container             Finished
    #Execute JavaScript    window.scrollTo(0, document.body.scrollTop)
    header link admin               Client contacts            Add another Client contact
    click element                  xpath=//div[@class="add-row" and contains(.,"Add another Client contact")]
    wait until page contains       Client contact
    input data in field            id_clientcontact_set-0-first_name              Test1
    input data in field            id_clientcontact_set-0-last_name               Test2
    Select User                    select2-id_clientcontact_set-0-user-container             ${find_user}
    input data in field            id_clientcontact_set-0-email                   ${email_client}
    header link admin              Client three pls             Add another Client three pl
    click element                  xpath=//div[@class="add-row" and contains(.,"Add another Client three pl")]
    input data in field            id_three_pls-0-reference_prefix                   ${rand_refer}
    Select Three pl                Geodis
    click element                 name=_save


#Create Three pl                  [Arguments]                 ${find_user}
#    wait element and click          xpath=//a[contains(.,"Add 3PL")]
#    wait until page contains        Add 3PL
#    input data in field             id_name                 TestPl
#    header link admin               3PL Contacts           Add another 3PL Contact
#    click element                 xpath=//div[@class="add-row" and contains(.,"Add another 3PL Contact")]
#    input data in field            id_threeplcontact_set-0-first_name                  Test3PLName
#    input data in field           id_threeplcontact_set-0-last_name                    Test3PLastName
#    Select User                   select2-id_threeplcontact_set-0-user-container             ${find_user}
#    input data in field           id_threeplcontact_set-0-email                        test@email.com
#    click element                 name=_save

Change Three pl                    [Arguments]                  ${geodis}            ${find_user}
     wait element and click          xpath=//tr[@class="row1"]//a[contains(.,"${geodis}")]
     wait until page contains        Change 3PL
     header link admin               3PL Contacts           Add another 3PL Contact
     #click element                 xpath=//div[@class="add-row" and contains(.,"Add another 3PL Contact")]
     Select User                     select2-id_threeplcontact_set-0-user-container             ${find_user}
     #wait element and click          xpath=//label[@for="id_threeplcontact_set-0-DELETE"]

Delete               [Arguments]             ${text}
    wait element and click             css=label > span > span:first-child > span > span:first-child
    Sleep                              1 sec
    input text                         xpath=//span[@class="select2-search select2-search--dropdown"]/input              ${text}
    wait element and click             xpath=//li[@class="select2-results__option select2-results__option--highlighted"]
    click button                       Go
    wait element and click             xpath=//*[@value="Yes, I'm sure"]
    wait until page contains           Successfully


Actions Order              [Arguments]             ${text}
    wait element and click             css=label > span > span:first-child > span > span:first-child
    Sleep                              1 sec
    input text                         xpath=//span[@class="select2-search select2-search--dropdown"]/input              ${text}
    wait element and click             xpath=//li[@class="select2-results__option select2-results__option--highlighted"]
    click button                       Go


#### BULK UPLOAD

Bulk Upload          [Arguments]            ${form}   ${data}  ${file}
    wait until page contains               ${form}
    choose file                            xpath=//input[@type="file"]        ${CURDIR}/bulk/${data}/${file}

Bulk Upload ASN          [Arguments]         ${form}       ${data}        ${file}
    wait until page contains              ${form}
    choose file                           xpath=(//input[@type="file"])[2]    ${CURDIR}/bulk/${data}/${file}

shows title in bulk          [Arguments]      ${type}             ${data}
   wait until page contains element         xpath=//div[@class="panel-group" and contains(.,"${type}") and contains(.,"${data}")]


show buttons in bulk form       [Arguments]          ${valid}       ${invalid}       ${all}
    wait until page contains element           xpath=//div[@class="btn-group" and contains(.,"${valid}") and contains(.,"${invalid}") and contains(.,"${all}")]              50

Confirm Cancel Order             [Arguments]      ${text}
    wait until page contains                 ${text}
    click button                             OK


Confirm
    click button                               Save
    wait until page contains                   Are you sure you want to approve this bulk upload? This action is not reversible.
    click button                               OK

Confirm Approve
    wait until page contains                   Are you sure you want to perform "Approve"? This action is not reversible
    click button                               OK

Confirm ASN                           [Arguments]             ${button}
    wait element and click        xpath=//a[contains(.,"Approve ASN")]
    wait until page contains                   Are you sure you want to approve this ASN? This action is not reversible
    click button                               ${button}

Confirm Delete               [Arguments]           ${button}
    wait element and click        xpath=//a[contains(.,"Delete ASN")]
    wait until page contains                   Are you sure you want to delete this ASN? This action is not reversible
    click button                               ${button}

show in table bulk upload            [Arguments]                ${prod}                ${num}
    wait until page contains element             xpath=//tr[contains(@class,"ng-scope") and contains(.,"${prod}")]
    wait element and click                    xpath=//tr[@class="ng-scope"]//a[contains(.,"${num}")]

show asn in table            [Arguments]                  ${fasn}
   wait until page contains element              xpath=(//table//td//a[contains(.,"${fasn}")])[1]
   wait element and click                        xpath=(//table//td//a[contains(.,"${fasn}")])[1]

show shipping in table         [Arguments]               ${name}             ${courier}         ${country}
  wait until page contains element               xpath=//table//tr[contains(.,"${name}") and contains(.,"${courier}") and contains(.,"${country}")]

click bulk            [Arguments]                         ${name}
  wait element and click                      xpath=//table//tr//a[contains(.,"${name}")]

check bulk shipping option            [Arguments]               ${courier}          ${data}
  wait until page contains element            xpath=//div[contains(@class,"form-group row") and contains(.,"${courier}") and contains(.,"${data}")]

check new bulk upload                  [Arguments]     ${base}         ${qty}          ${prod}   ${ship}     ${width}   ${height}    ${lenght}    ${weight}
    wait until page contains element          xpath=//div[@class="row" and contains(.,"${base}") and contains(.,"${qty}") and contains(.,"${prod}") and contains(.,"${ship}") and contains(.,"${width}") and contains(.,"${height}") and contains(.,"${lenght}") and contains(.,"${weight}")]


check new bulk upload order                [Arguments]                               ${sku}                  ${type}         ${unit}       ${desc}         ${qty}
   wait until page contains element          xpath=//tr[@class="ng-scope" and contains(.,"${sku}") and contains(.,"${type}") and contains(.,"${unit}") and contains(.,"${desc}") and contains(.,"${qty}")]

check new bulk upload asn                  [Arguments]           ${sku}                  ${type}         ${unit}       ${desc}         ${qty}
    wait until page contains element        xpath=//tbody/tr[contains(.,"${sku}") and contains(.,"${type}") and contains(.,"${unit}") and contains(.,"${desc}") and contains(.,"${qty}")]

check data which are not correct     [Arguments]                ${field}            ${data}
    check data                     ${field}                    ${data}

check data for order     [Arguments]              ${field}          ${data}
    wait until page contains element            xpath=//table[@class="table table-hover" and contains(.,"${field}") and contains(.,"${data}")]

####

Search and Click Item       [Arguments]             ${item}
   Check Item in Search                    ${item}
   wait until page contains element       xpath=//tr[@class="row1"]//a[contains(.,"${item}")]

Edit Client       [Arguments]              ${client}    ${default}       ${geodis}        ${reference}
   click element                         xpath=//tr[@class="row1"]//a[contains(.,"${client}")]
   Select default 3pl Admin        id_default_3pl         Geodis
   Select User                     select2-id_current_onboarding_step-container             Onboarding Finished
   header link admin              Client three pls             Add another Client three pl
   input data in field            id_three_pls-0-reference_prefix                  ${reference}
   Select Three pl                ${geodis}
   click element                 name=_save

show order          [Arguments]                   ${prod}          ${num}           ${status}     ${exeption}
    wait until page contains element             xpath=//tr[contains(@class,"ng-scope") and contains(.,"${prod}") and contains(.,"${num}") and contains(.,"${status}") and contains(.,"${exeption}")]



Inventory Item        [Arguments]             ${item}     ${status}
    wait element and click          xpath=//span[@class="select2-selection select2-selection--single"]
    wait until element is visible           xpath=//input[@class="select2-search__field"]
    input text                              xpath=//input[@class="select2-search__field"]          ${item}
    wait element and click                  xpath=//li[contains(@class,"select2-results__option") and contains(.,"${status}")]


Add Stock Adjustment           [Arguments]               ${item}      ${status}
   click element                xpath=//a[contains(.,"Add stock adjustment")]
   wait until page contains     Add stock adjustment
   header link admin            Stock adjustment lines           Add another Stock adjustment line
   click element                xpath=//div[@class="add-row" and contains(.,"Add another Stock adjustment line")]
   wait until page contains     Stock adjustment line
   Inventory Item               ${item}        ${status}
   input text                   id=id_lines-0-quantity              10
   click element                name=_save

Approve stock adjustment      [Arguments]            ${status}
  click element                xpath=//tr[@class="row1" and contains(.,"${status}")]//a
  wait until page contains    Change stock adjustment
  wait element and click      xpath=//*[@value="Approve Stock Adjustment"]



check stock adjustment                 [Arguments]           ${fad}           ${status}
    wait until page contains element           xpath=//tr[@class="row1" and contains(.,"${fad}") and contains(.,"${status}")]


Does not find Out of Stock    [Arguments]      ${fsn}   ${status}
  wait until page does not contain element        xpath=//tr[contains(@class,"ng-scope") and contains(.,"${fsn}") and contains(.,"${status}")]


Find Product Stock              [Arguments]       ${sku}          ${status}
   wait until page contains element       xpath=//tr[contains(@class,"ng-scope") and contains(.,"${sku}")]//span[contains(.,"${status}")]

Find Order Change Status        [Arguments]          ${fsn}            ${status}
   wait until page contains element       xpath=//tr[contains(@class,"ng-scope") and contains(.,"${fsn}") and contains(.,"${status}")]

Approve Order                     [Arguments]      ${fsn}          ${approve}
   wait element and click       xpath=//tr[contains(@class,"ng-scope")]//a[contains(.,"${fsn}")]
   wait until page contains    Order ${fsn} Details
   wait element and click      xpath=//button[contains(.,"${approve}")]

Check Item in Search                         [Arguments]         ${order}
   wait until element is visible          name=q
   input text                             name=q                ${order}
   wait element and click                          xpath=//*[@class="search-block-submit"]

Check Filter                    [Arguments]      ${num}     ${client}
   Select Client                  ${num}    ${client}



Check Data Order                    [Arguments]         ${fs}      ${id}          ${status}           ${courier}
    wait until page contains element           xpath=//tr[@class="row1" and contains(.,"${fs}") and contains(.,"${id}") and contains(.,"${status}") and contains(.,"${courier}")]


Check Data Row                 [Arguments]         ${fs}      ${id}          ${status}           ${courier}
    wait until page contains element           xpath=//table[@id="result_list" and contains(.,"${fs}") and contains(.,"${id}") and contains(.,"${status}") and contains(.,"${courier}")]


Check does not Data fulfilled                [Arguments]            ${fs}      ${id}          ${status}              ${courier}
    wait until page does not contain element           xpath=//tr[@class="row1" and contains(.,"${fs}") and contains(.,"${id}") and contains(.,"${status}") and contains(.,"${courier}")]

product does not find in table                [Arguments]            ${fs}      ${id}          ${status}
    wait until page does not contain element           xpath=//tr[@class="row1" and contains(.,"${fs}") and contains(.,"${id}") and contains(.,"${status}")]

Open Check Order                [Arguments]                ${fs}
    wait element and click                    xpath=//tr[contains(@class,"row")]//a[contains(.,"${fs}")]

Change Order
    header link admin                         Sales order lines               Add another Sales order line
    #wait element and click                    name=_fsmtransition-status-regenerate


Check General                 [Arguments]    ${status}            ${name}
   wait until page contains element          xpath=//div[@class="form-row field-display_status field-display_state" and contains(.,"${status}") and contains(.,"${name}")]

Check Package                  [Arguments]     ${package}     ${item}
   wait until page contains element          xpath=//div[@class="form-row field-packaging_item" and contains(.,"${package}") and contains(.,"${item}")]

Check Package Tracking           [Arguments]      ${trac}          ${num}
  wait until page contains element           xpath=//div[@class="form-row field-tracking_number" and contains(.,"${trac}")]//input[@value="${num}"]

Check Package Upload              [Arguments]      ${class}   ${shipp}       ${path}
  wait until page contains element            xpath=//div[@class="form-row field-${class}" and contains(.,"${shipp}")]//a[contains(@href,"${path}")]


Check Data fulfilled                [Arguments]            ${fs}      ${id}          ${status}              ${courier}
    wait until page contains element          xpath=//tr[@class="row1" and contains(.,"${fs}") and contains(.,"${id}") and contains(.,"${status}") and contains(.,"${courier}")]

Check Mark          [Arguments]              ${text}
    wait element and click             css=label > span > span:first-child > span > span:first-child
    Sleep                              1 sec
    input text                         xpath=//span[@class="select2-search select2-search--dropdown"]/input              ${text}
    wait element and click             xpath=//li[@class="select2-results__option select2-results__option--highlighted"]
    click button                       Go

Mark                          [Arguments]         ${text_}
    wait element and click               xpath=//tr[@class="row1"]//label
    wait until page contains             1 of 1 selected
    Check Mark                           ${text_}

Change Fulfilled Order      [Arguments]       ${class}     ${type}          ${text}
    wait until page contains element         xpath=//div[@class="form-row field-${class}" and contains(.,"${type}") and contains(.,"${text}")]


Add cost to Sales Order - Carton        [Arguments]         ${pick}         ${cost}
   Header link Admin       Sales order costs               Add another Sales order cost
   clear element text      css=#id_cost-0-pick_pack_cost
   input text             css=#id_cost-0-pick_pack_cost                   ${pick}
   input text             css=#id_cost-0-actual_cost                       ${cost}

Check pick and cost         [Arguments]          ${pick}        ${value}          ${cost}       ${value_cost}
   wait until page contains        Change sales order
   header link admin                Sales order costs               Add another Sales order cost
   wait until page contains element     xpath=//div[@class="form-row field-pick_pack_cost" and contains(.,"${pick}")]//input[contains(@value,"${value}")]
   wait until page contains element     xpath=//div[@class="form-row field-actual_cost" and contains(.,"${cost}")]//input[contains(@value,"${value_cost}")]


Delete user             [Arguments]             ${text}
    wait element and click               xpath=//tr[@class="row1"]//label
    wait until page contains             1 of 100 selected
    Delete                               ${text}


Actions Sales Order                   [Arguments]     ${act}       ${text}
    wait element and click               xpath=//tr[@class="row1"]//label
    wait until page contains             1 sales order
    Actions Order                        ${act}
    wait until page contains             ${text}





Delete user Contact         [Arguments]         ${text}
    wait element and click               xpath=//tr[@class="row1"]//label
    wait until page contains             1 of 100 selected
    wait element and click             css=label > span > span:first-child > span > span:first-child
    Sleep                              1 sec
    input text                         xpath=//span[@class="select2-search select2-search--dropdown"]/input              ${text}
    wait element and click             xpath=//li[@class="select2-results__option select2-results__option--highlighted"]
    click button                       Go


Delete Something              [Arguments]            ${text}
   wait element and click               xpath=(//tr[contains(@class,"row")]//a[contains(.,"XM01")]/../..//td)[1]
   wait until page contains             1 of 100 selected
   Delete                               Delete selected ${text}


Sales Order Uploads           [Arguments]     ${file}
  wait until page contains                Select warehouse sales order upload to change
  wait element and click                  xpath=//a[contains(.,"Add warehouse sales order upload")]
  wait until page contains                Add warehouse sales order upload
  choose file                             xpath=//input[@type="file"]                 ${CURDIR}/${file}
  wait until element is visible           xpath=//a[contains(.,"Remove")]
  ${file_name}=                           get element attribute                   xpath=//a[@class="file-link"]@text
  log to console                         ${file_name}
  click element                          name=_save
  wait until page contains               The warehouse sales order upload



Update Sales Order Uploads           [Arguments]       ${status}    ${msg}
  ${upload}=                         get element attribute                      xpath=//tr[@class="row1"]//a@text
  log to console                      ${upload}
  wait element and click             xpath=//tr[@class="row1"]//a[contains(.,"${upload}")]
  wait element and click             name=_fsmtransition-status-update
  wait until page contains           The warehouse sales order upload "${upload}" was changed successfully
  wait until page contains element   xpath=//tr[@class="row1" and contains(.,"${upload}")]
  Sleep                              3 sec
  wait element and click             xpath=//tr[@class="row1"]//a[contains(.,"${upload}")]
  wait until page contains            ${msg}


Check colums Sales order cost uploads            [Arguments]        ${title}     ${created}   ${invoice}    ${carrier}    ${courier}   ${amount}   ${entered}     ${upload}       ${status}
  wait until page contains          Select sales order cost upload to change
  wait until page contains element     xpath=(//thead[contains(.,"${title}") and contains(.,"${created}") and contains(.,"${invoice}") and contains(.,"${carrier}") and contains(.,"${courier}") and contains(.,"${amount}") and contains(.,"${entered}") and contains(.,"${upload}") and contains(.,"${status}")])[1]


Check the fields in sales order cost upload         [Arguments]      ${invo_date}      ${carrier}    ${courier}   ${amount}   ${entered}    ${errors}  ${upload}   ${status}
  wait element and click                  xpath=//a[contains(.,"Add sales order cost upload")]
  wait until page contains                Add sales order cost upload
  wait until page contains element        xpath=//*[@id="salesordercostupload_form" and contains(.,"${invo_date}") and contains(.,"${carrier}") and contains(.,"${courier}") and contains(.,"${amount}") and contains(.,"${entered}") and contains(.,"${errors}") and contains(.,"${upload}") and contains(.,"${status}")]

Add sales order cost uploads                   [Arguments]    ${carreir}         ${courier}     ${courier}
  wait until element is visible      id=id_carrier_invoice_number
  input text                         id=id_carrier_invoice_number                                ${carreir}
  Inventory Item                   ${courier}          ${courier}


Upload File For Sales Order Cost              [Arguments]      ${file}
  choose file                    xpath=//input[@type="file"]        ${CURDIR}/cost_sales_order/${file}

Check Amount Cost Order       [Arguments]    ${fo}      ${cost}    ${amount_cost}    ${weight}    ${amount}
   wait element and click          xpath=//tr[@class="row1"]//a[contains(.,"${fo}")]
   wait until page contains
   header link admin                Sales order costs               Add another Sales order cost
   wait until page contains element     xpath=//div[@class="form-row field-actual_cost" and contains(.,"${cost}")]//input[contains(@value,"${amount_cost}")]
   wait until page contains element     xpath=//div[@class="form-row field-actual_weight" and contains(.,"${weight}")]//input[contains(@value,"${amount}")]
   clear element text                xpath=//div[@class="form-row field-actual_weight" and contains(.,"${weight}")]//input[contains(@value,"${amount}")]
   clear element text                xpath=//div[@class="form-row field-actual_cost" and contains(.,"${cost}")]//input[contains(@value,"${amount_cost}")]





###Add report

Add report                           [Arguments]           ${add}       ${text}
  wait element and click             xpath=//a[contains(.,"${add}")]
  wait until page contains           ${text}


Invalid report           [Arguments]          ${class}        ${error}
  wait until page contains element      xpath=//div[@class="form-row errors ${class}" and contains(.,"${error}")]

Report                       [Arguments]       ${text}       ${item}                ${status}
  wait element and click                  xpath=//label[contains(.,"${text}")]/..//span
  wait until element is visible           xpath=//input[@class="select2-search__field"]
  input text                              xpath=//input[@class="select2-search__field"]          ${item}
  wait element and click                  xpath=//li[contains(@class,"select2-results__option") and contains(.,"${status}")]


Select Fields            [Arguments]        ${text}           ${item}        ${status}
  Report                        ${text}      ${item}        ${status}

Check Status Report       [Arguments]         ${temp}    ${courier}           ${status}       ${report}
  wait until page contains element       xpath=//tr[@class="row1" and contains(.,"${temp}") and contains(.,"${courier}") and contains(.,"${status}")]//a[contains(.,"${report}")]

Check Status Report without Courier      [Arguments]         ${client}           ${status}               ${report}
  wait until page contains element       xpath=//tr[@class="row1" and contains(.,"${client}") and contains(.,"${status}")]//a[contains(.,"${report}")]


Generate report         [Arguments]       ${report}       ${text}        ${generate}
  wait element and click            xpath=//a[contains(.,"${report}")]
  wait until page contains          ${text}
  wait element and click            xpath=//input[contains(@value,"${generate}")]

Data Today                          [Arguments]             ${today}
  wait element and click            xpath=(//a[@class="vDateField-link"])[${today}]
  wait element and click            xpath=//button[contains(.,"Today")]


Time Now                        [Arguments]     ${time}
  wait element and click            xpath=(//a[@class="vTimeField-link"])[${time}]
  wait element and click            xpath=//button[contains(.,"Now")]


Add Invoice            [Arguments]
  wait until page contains             Add sales invoice
  Select Fields                        Client        ${client}            ${client}

Check Invoice           [Arguments]           ${client}         ${invoice}         ${status}
  wait element and click            xpath=//a[contains(.,"Sales invoice")]
  ${invoice}=                     get element attribute               xpath=//tr[@class="row1"]//a@text
  log to console                    ${invoice}
  wait until page contains element       xpath=//tr[@class="row1" and contains(.,"${client}")]//a[contains(.,"${invoice}")]/../../td/img[@alt="${status}"]


### Items Upload (Missing Data)

Check Item CSV Upload            [Arguments]         ${file}   ${client}      ${message}
    Go To                             ${ADMIN}items/itemcsvupload/
    #Login                         staff+ejlpcndt@floship.com                  12345678
    wait until page contains           Select item csv upload to change
    Add report                     Add item csv upload           Add item csv upload
    Upload Item File              	${client}   product      ${file}
    sleep                          3 sec
    #wait element and click         name=_save
    wait until page contains element    name=_save
    click button                    name=_save
    wait until page contains        The item csv upload
    ${item_csv}=                   get element attribute                   xpath=//tr[@class="row1"]//a@text
    log to console                 ${item_csv}
    Open Check Order               ${item_csv}
    set suite variable             ${save_item_csv}        ${item_csv}
    wait element and click         xpath=//input[contains(@value,"Validate Item Csv Upload")]
    wait until page contains       The item csv upload "${save_item_csv}" was changed successfully
    Sleep                          3 sec
    Open Check Order               ${save_item_csv}
    wait until page contains       ${message}


Check ASN CSV Upload            [Arguments]         ${file}   ${client}      ${message}
    Go To                                 ${ADMIN}asns/asnitemsupload/
    wait until page contains           Select asn items upload to change
    Add report                     Add asn items upload            Add asn items upload
    Upload Item File              	${client}    asn      ${file}
    sleep                          3 sec
    #wait element and click         name=_save
    wait until page contains element    name=_save
    click button                    name=_save
    wait until page contains       The asn items upload
    ${item_csv}=                   get element attribute                   xpath=//tr[@class="row1"]//a@text
    log to console                 ${item_csv}
    Open Check Order               ${item_csv}
    set suite variable             ${save_item_csv}        ${item_csv}
    wait element and click         xpath=//input[contains(@value,"Validate Asn Items Upload")]
    wait until page contains       The asn items upload "${save_item_csv}" was changed successfully
    Sleep                          3 sec
    Open Check Order               ${save_item_csv}
    wait until page contains       ${message}


Check Order CSV Upload            [Arguments]         ${file}   ${client}      ${message}
    Go To                         ${ADMIN}orders/ordercsvupload/
    wait until page contains           Select order csv upload to change
    Add report                     Add order csv upload            Add order csv upload
    Upload Item File              	${client}    order      ${file}
    sleep                          2 sec
    #wait element and click         name=_save
    wait until page contains element    name=_save
    click button                    name=_save
    wait until page contains       The order csv upload
    ${item_csv}=                   get element attribute                   xpath=//tr[@class="row1"]//a@text
    log to console                 ${item_csv}
    Open Check Order               ${item_csv}
    set suite variable             ${save_item_csv}        ${item_csv}
    wait element and click         xpath=//input[contains(@value,"Validate Order Csv Upload")]
    wait until page contains       The order csv upload "${save_item_csv}" was changed successfully.
    Sleep                          3 sec
    Open Check Order               ${save_item_csv}
    wait until page contains       ${message}


Check SO CSV Upload            [Arguments]        ${file}   ${client}      ${message}
    Go To                                 ${ADMIN}preferences/clientshippingoptionupload/
    wait until page contains           Select client shipping option upload to change
    Add report                     Add client shipping option upload            Add client shipping option upload
    Upload Item File              	${client}    shipping      ${file}
    sleep                          3 sec
    #wait element and click         name=_save
    wait until page contains element    name=_save
    click button                    name=_save
    wait until page contains       The client shipping option upload
    ${item_csv}=                   get element attribute                   xpath=//tr[@class="row1"]//a@text
    log to console                 ${item_csv}
    Open Check Order               ${item_csv}
    set suite variable             ${save_item_csv}        ${item_csv}
    wait element and click         xpath=//input[contains(@value,"Validate Client Shipping Option Upload")]
    wait until page contains       The client shipping option upload "${save_item_csv}" was changed successfully.
    Sleep                          3 sec
    Open Check Order               ${save_item_csv}
    wait until page contains       ${message}



#### SO

Select Fields Country SO             [Arguments]        ${country}
  wait element and click                  css=span > ul
  wait until element is visible           xpath=//input[@class="select2-search__field"]
  input text                              xpath=//input[@class="select2-search__field"]                ${country}
  wait element and click                  xpath=//li[contains(@class,"select2-results__option") and contains(.,"${country}")]


Select Fields (Client, Courier) SO              [Arguments]      ${aria}     ${client}
  wait element and click                  xpath=//span[@aria-labelledby="${aria}"]
  wait until element is visible           xpath=(//input[@class="select2-search__field"])[2]
  input text                              xpath=(//input[@class="select2-search__field"])[2]                 ${client}
  wait element and click                  xpath=//li[contains(@class,"select2-results__option") and contains(.,"${client}")]



### Accounting b2c

click exist b2c                  [Arguments]          ${cost}           ${add_cost}
   wait element and click          xpath=//tr[@class="row1"]//td[@class="field-cost" and contains(.,"${cost}")]/..//td[@class="field-additional_cost" and contains(.,"${add_cost}")]/..//a