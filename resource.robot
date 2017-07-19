*** Settings ***
Documentation                   Resource file
Library                         Collections
Library                         DateTime
Library                         String
Resource                        locators.robot
Library                         Selenium2Library     timeout=30     run_on_failure=On Fail
Library                         XvfbRobot
Library                         plugins.py
Library                         TempMail.py

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

Logout                  [Arguments]               ${text}
    mouse over                          xpath=//li[@class="user-tools-welcome-msg"]
    wait until element is visible       xpath=//li[@class="user-tools-link" and contains(.,"Log out")]
    click element                       xpath=//li[@class="user-tools-link" and contains(.,"Log out")]
    Wait Until Page Contains            ${text}

Mouse over and Click    [Arguments]           ${link}            ${group}
    wait until element is visible       xpath=//div[@class="left-menu-inner scroll-pane"]//a[contains(.,"${link}")]
    mouse over                          xpath=//div[@class="left-menu-inner scroll-pane"]//a[contains(.,"${link}")]
    wait element and click              xpath=//a[@class="left-menu-link ng-binding" and contains(.,"${group}")]


Wait settings and Click            [Arguments]           ${link}
    Wait Element And Click                  xpath=//i[@class="icon icmn-cog ng-scope"]
    wait until element is visible           xpath=//div[@class="dropdown-menu dropdown-menu-right"]
    click element                         xpath=//a[@class="dropdown-item" and contains(.,"${link}")]


Create a new user                     [Arguments]               ${reg email}           ${name}
    Wait Until Page Contains            Send welcome email
    Input text                          name=email                   ${reg email}
    Input text                          name=first_name             ${name}
    Click Element                       xpath=//input[@class="submit-row"]




Registration Empty Fields              [Arguments]             ${times}
    wait until page contains           This field is required.
    Xpath Should Match X Times          //li[@ng-bind="error"]             ${times}

Registration With Long Symbols     [Arguments]            ${error}    ${times}
    wait until page contains            Ensure this field has no more than 255 characters
    XPATH SHOULD MATCH X TIMES         //li[@ng-bind="error" and contains(.,"${error}")]             ${times}

Registration Invalid Data           [Arguments]              ${data}          ${text}
    input text                       xpath=//input[@ng-model='$ctrl.registration.${data}']            ${text}

Registration Long Data           [Arguments]              ${data}
    input text                       xpath=//input[@ng-model='$ctrl.registration.${data}']       ${long_symbols}

Check Errors                         [Arguments]           ${error}
    wait until element is visible         xpath=//li[@ng-bind="error" and contains(.,"${error}")]

Select Country                      [Arguments]         ${country}
    click element                        xpath=//input[@type="search"]
    wait until element is visible       xpath=//div[@class="option ui-select-choices-row-inner" and contains(.,"${country}")]
    click element                       xpath=//div[@class="option ui-select-choices-row-inner" and contains(.,"${country}")]

Select Post                [Arguments]         ${post}
    click element                   xpath=//input[@type="search"]
    input text                      xpath=//input[@type="search"]            HKP
    sleep                           2 sec
    wait element and click       xpath=//div[@ng-show='$select.open']//div[@class='ng-binding ng-scope']

Select Post Order               [Arguments]         ${post}
    click element                   xpath=//input[@type="search"][@aria-label="Choose a Courier Service"]
    input text                      //input[@type="search"][@aria-label="Choose a Courier Service"]            HKP
    sleep                           2 sec
    wait element and click       xpath=//div[@ng-show='$select.open']//div[@class='ng-binding ng-scope']

Check Validation Form                  [Arguments]               ${page}     ${count}
    wait until page contains        ${page}
    wait until page contains        Save
    click button                    Save
    Sleep                           1 sec
    Xpath Should Match X Times           //li[@ng-bind="error" and contains(.,"This field is required")]          ${count}
    Capture Page Screenshot             ${TEST NAME}-{index}.png

Check Validation Form Group                  [Arguments]               ${page}     ${count}
    wait until page contains        ${page}
    wait until page contains        Save
    click button                    Save
    Sleep                           1 sec
    Xpath Should Match X Times           //li[@ng-bind="error" and contains(.,"This field may not be blank.")]          ${count}
    Capture Page Screenshot             ${TEST NAME}-{index}.png



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
    Registration Long Data          name
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
    Sleep                             1 sec
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Registration With Long Symbols    Ensure this field has no more than 255 characters.                 6
    Registration With Long Symbols    Ensure this field has no more than 50 characters.                 2
    Registration With Long Symbols    Ensure this field has no more than 254 characters.                 1



Wait Element And Click                [Arguments]                  ${locator}
    wait until element is visible             ${locator}
    click element                             ${locator}

Invalid Card Number                   [Arguments]              ${card valid}            ${exp date valid}   ${cvv valid}
    wait until page contains         Card Number
    click button                     Continue
    wait until page contains         ${card valid}
    wait until page contains         ${exp date valid}
    wait until page contains         ${cvv valid}
    reload page
    Capture Page Screenshot             ${TEST NAME}-{index}.png

Create Card Number                     [Arguments]         ${card num}        ${exp date}       ${cvv}
    wait until page contains         Card Number
    input text                       name=cardNumber                ${card num}
    input text                       xpath=//input[@ng-model="$ctrl.creditCard.expirationDate"]                 ${exp date}
    input text                       xpath=//input[@ng-model="$ctrl.creditCard.cvv"]                            ${cvv}
    click button                     Continue

Select default 3pl                        [Arguments]          ${default}     ${show}
    wait until element is visible        xpath=//label[@for="${default}"]
    click element                        ${3pl}
    wait until element is visible        xpath=//ul[@id='select2-id_default_3pl-results']/li
    #wait until page contains element     xpath=//span[@class='select2-selection__rendered' and contains(@title,"${show}")]
    wait until element is visible        xpath=//input[@class="select2-search__field"]
    input text                           xpath=//input[@class="select2-search__field"]                    Geodis
    wait element and click               xpath=(//li[@class="select2-results__option"])[2]

select all from list client pls          [Arguments]           ${pls}
    wait element and click               xpath=//li/a[@class="changeform-tabs-item-link" and contains(.,"${pls}")]
    wait until page contains             Add another Client
    click element                        xpath=//div[@id='three_pls-group']//div[@class='add-row']/a
    wait until page contains element     xpath=//a[@class="inline-navigation-item selected" and contains(.,"${pls}")]
    click element                        xpath=//div[@class='form-row field-three_pl']//span[@role='combobox']
    wait until element is visible        xpath=//input[@class="select2-search__field"]
    input text                           xpath=//input[@class="select2-search__field"]                 Geodis
    wait element and click               xpath=(//li[@class="select2-results__option"])[2]

Search New Company In Admin Panel        [Arguments]                  ${clients}              ${company}
    wait element and click               xpath=//div[@class="dashboard-item-content"]//a[contains(.,"${clients}")]
    wait until element is visible        name=q
    input text                           name=q                   ${company}
    click element                        xpath=//input[@value="Search"]
    Wait Element And Click               xpath=//tr[@class="row1"]//a[contains(.,"${company}")]
    wait until element is visible        xpath=//a[contains(.,"Aftership integration")]
    Select default 3pl                   id_default_3pl         Geodis_2
    select all from list client pls      Client three pl
    click element                        xpath=//input[@name='_save']

Get Rand Company
    ${faker_kit}=                        Generate Random String     7              [NUMBERS]
    ${kit_num}                           Catenate	            SEPARATOR=1         ${comp name}          ${faker_kit}
    [return]                             ${kit_num}

Add New Product                          [Arguments]          ${add}
    set selenium speed                   0.1 sec
    Wait Element And Click               xpath=//div[@class="modal-footer"]//a[contains(.,"${add}")]
    Check Validation Form            New Product            9
    input text                         ${sku_field}             XMO1
    input text                         ${description_field}      Mobile phone
    input text                         ${cust_description_field}  Mobile phone
    input text                         ${harmonized_code_field}    1234567
    select from list                   ${packaging_combobox}              Ship ready
    input text                         ${customs_value_field}              99.99
    input text                         ${width_field}                      5
    input text                        ${height_field}                     1
    input text                        ${length_field}                     10
    input text                        ${weight_field}                     0.1
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    click button                      Save

Header Title                            [Arguments]           ${title}
    wait until page contains element       xpath=//span[@ng-if="!$ctrl.product.id" and contains(.,"${title}")]

Header title block                              [Arguments]               ${title}
   wait until page contains element         xpath=//h5[@class="modal-title" and contains(.,"${title}")]

Add New ASN                  [Arguments]                  ${add}           ${item}       ${id_ship}
    Wait Element And Click               xpath=//div[@class="modal-footer"]//a[contains(.,"${add}")]
    Check Validation Form            New ASN            6
    wait until element is visible        xpath=//li[@ng-bind="error" and contains(.,"Date has wrong format. Use one of these formats instead: YYYY[-MM[-DD]].")]
    wait until element is visible        xpath=//p[@class="dropify-error ng-binding ng-scope" and contains(.,"This field is required")]
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    #calendar
    Wait Element And Click               ${calendar_button}
    wait element and click               ${today_button}
    #click element                       ${upload_file}
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Sleep                               2 sec
    choose file                         xpath=//input[@type="file"]        ${CURDIR}/test_file.pdf
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    wait until page contains             File uploaded sucessfully
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

Wait table                               [Arguments]             ${name}
   wait until page contains element       xpath=//table//td//a[contains(.,"${name}")]

wait company                             [Arguments]           ${company}
   wait until page contains element           xpath=//table//td[contains(.,"${company}")]

Get Id
    ${id}=                              Get Element Attribute           xpath=//table//td//a[contains(.,"FASN")]@text
    [return]                             ${id}

Get Id Order
    ${id}=                              Get Element Attribute           xpath=//table//td//a[contains(.,"FS")]@text
    [return]                             ${id}

Header link                             [Arguments]             ${link}
    wait element and click              xpath=//div[@class="left-menu-inner scroll-pane"]//a[contains(.,"${link}")]

Add Shipping Options               [Arguments]             ${add}                 ${Some}             ${post}
    wait element and click          xpath=//a[@class="left-menu-link ng-binding" and contains(.,"Shipping Options")]
    wait element and click          xpath=//*[@class="btn btn-primary" and contains(.,"${add}")]
    Check Validation Form            New Shipping Option            3
    input text                      ${som_name_field}                           ${Some}
    Select Post                     HKPost
    click element                   xpath=//a[@ng-click='$ctrl.selectAllCountries()']
    Sleep                           1 sec
    click button                    Save
    wait until page contains element      xpath=//table[@class="table table-hover nowrap"]/tbody//a[contains(.,"${Some}")]/../..//td[contains(.,"${post}")]
    Capture Page Screenshot             ${TEST NAME}-{index}.png

Add Group Items List                   [Arguments]               ${add}     ${XM}     ${table_xm}
    Mouse over and Click              Inventory            Group Items
    wait until page contains        Group Items List
    click element                     xpath=//div[@class="dropdown pull-right" and contains(.,"${add}")]
    Check Validation Form Group        New Group Item           2
    input text                       ${sku_field_group}                  CIL01
    input text                        ${description_field_group}           descriptionCIL
    input text                        ${items_field_gr}                  ${XM}
    wait element and click            css=div.angucomplete-description
    wait until page contains element         xpath=//table[@class="table table-hover nowrap"]//td[contains(.,"${table_xm}")]
    click button                      Save
    Wait table                        CIL01
    Capture Page Screenshot             ${TEST NAME}-{index}.png

Add Order                  [Arguments]                   ${add}    ${Xm}    ${table_xm}            ${id_floship}
    set selenium speed             0.1 sec
    Mouse over and Click              Orders          All Orders
    wait until page contains        All Orders
    wait element and click          xpath=//*[@class="btn btn-primary" and contains(.,"${add}")]
    Check Validation Form            New Order            8
    input text                       ${full_name_field_order}                  ${first name}${last name}
    input text                       ${address_1_field_order}                  ${address_1}
    input text                       ${city_field_order}                        ${city}
    input text                       ${state_field_order}                       ${state}
    input text                       ${postal_code_field_order}                ${post_code}
    Select Country                   United State
    input text                       ${phone_field_order}                      ${phone}
    input text                       ${order_id_field}                         ID_2345678
    Select Post Order                HKPost
    input text                         ${items_field_order}                         ${Xm}
    wait element and click             ${items_list}
    wait until page contains element         xpath=//table[@class="table nowrap"]//td[contains(.,"${table_xm}")]
    click button                      Save
    Wait table                        ${id_floship}


Add Address Book                 [Arguments]        ${add}
    Wait settings and Click        Address Book
    wait until page contains        Address Book
    wait element and click          xpath=//*[@class="btn btn-primary" and contains(.,"${add}")]
    Check Validation Form            New Address            4
    input text                          ${company_field_address}              ${mycompany}
    input text                          ${full_name_field_address}            ${first_name} ${last_name}
    input text                          ${address_1_field_address}                    ${address_1}
    input text                          ${city_field_address}                 ${city}
    input text                          ${state_field_address}                ${state}
    input text                          ${postal_code_field_address}          ${post code}
    Select Country                      United States of
    click button                        Save
    wait company                           ${mycompany}

Links Integration                  [Arguments]           ${link}             ${new}
    wait element and click         xpath=//div[@class="dropdown margin-inline" and contains(.,"Add Integration")]
    wait element and click        xpath=//ul[@class="dropdown-menu"]/a[contains(.,"${link}")]
    wait until page contains      ${new}

Validation Links               [Arguments]     ${button}         ${count}
    click button                  ${button}
    wait until page contains           This field is required
    Xpath Should Match X Times           //li[@ng-bind="error" and contains(.,"This field is required")]          ${count}
    Capture Page Screenshot             ${TEST NAME}-{index}.png



Check Links Orders
    Mouse over and Click               Orders      All Orders
    wait until page contains           Order List
    Mouse over and Click               Orders      Incomplete
    wait until page contains           Order List
    Mouse over and Click               Orders      Pending Approval
    wait until page contains           Order List
    Mouse over and Click               Orders      Pending Fulfillment
    wait until page contains           Order List
    Mouse over and Click               Orders      Canceled
    wait until page contains           Order List
    Mouse over and Click               Orders      Closed
    wait until page contains           Order List

Check Links Inventory
    Mouse over and Click               Inventory      Products
    wait until page contains           Product List
    Mouse over and Click               Inventory       Group Items
    wait until page contains           Group Items List

Check Links Billing
   Wait settings and Click        Billing
   wait until page contains       Settings
   wait until page contains       Billing Details
   click element                  xpath=//div[@class="messaging-list-item" and contains(.,"Preference")]
   wait until page contains       Preferences
   click element                  xpath=//div[@class="messaging-list-item" and contains(.,"Integrations")]
   wait until page contains       Integrations

Check Links in Integrations
   Links Integration              Shopify            New Shopify Integration
   Validation Links               Continue           1
   click element                   css=button.close > span
   Sleep                           1 sec

   Links Integration              Magento            Magento Integration
   Validation Links               Save              2
   wait until page contains element       xpath=//div[@class="form-control-error ng-scope"]//li[contains(.,"This field should be in correct URL format")]
   click element                  css=button.close > span
   Sleep                          1 sec

   Links Integration              Magento 2            Magento 2 Integration
   Validation Links               Save              2
   wait until page contains element       xpath=//div[@class="form-control-error ng-scope"]//li[contains(.,"This field should be in correct URL format")]
   click element                  css=button.close > span
   Sleep                          1 sec

   Links Integration              WooCommerce            Woocommerce Integration
   Validation Links               Save              2
   wait until page contains element       xpath=//div[@class="form-control-error ng-scope"]//li[contains(.,"This field should be in correct URL format")]
   click element                  css=button.close > span
   Sleep                          1 sec

   Links Integration              Aftership            Aftership Integration
   Validation Links               Save              1
   click element                  css=button.close > span
   Sleep                          1 sec

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








Get Mail link                            [Arguments]            ${res}
    ${url_right}=                        Fetch From Right     ${res}["mail_text_only"]    /password/reset
    ${url_left}=                         Fetch From Left      ${url_right}           \\n
    ${url}=                              Fetch From Left      ${url_left}            <br>
    ${link}=                             Catenate             SEPARATOR=             https://floship-staging.herokuapp.com/password/reset           ${url}
    [return]                             ${link}


Check Mail                               [Arguments]          ${email}               ${message_id}
    ${result}=                           get mailbox          ${email}               ${message_id}
    Should Not Contain                   ${result}            'error'
    [return]                             ${result}


Check All Mail                           [Arguments]          ${email}
    ${result}=                           get mailbox          ${email}
    [return]                             ${result}
