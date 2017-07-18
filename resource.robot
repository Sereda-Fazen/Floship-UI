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

*** Variables ***

## Url's
#${SERVER}                       https://demo:hicnewdemo@test.hiconversion.ru
##${SERVER}                       https://hiconversion.ru
#${URL_START}                    ${SERVER}/ru
#${URL_ACTIVATE}                 ${SERVER}/activate/
#${URL_EDIT_ACCOUNT}             ${SERVER}/app/account/edit/
#${URL_PROJECTS}                 ${SERVER}/app/projects/
#${URL_PROJECT}                  ${SERVER}/app/project/
#${URL_CAMPAGIN}                 ${SERVER}/app/campaign/
#${URL_AD}                       ${SERVER}/app/ad/
#${URL_PAYMENT}                  ${SERVER}/app/account/payment/
#${URL_SIGNOUT}                  ${SERVER}/signout
#${URL_ADMIN_SIGNOUT}            ${SERVER}/django/logout/
#${ADMIN_USER_URL}               ${SERVER}/django
#${ADMIN_PAYMENTS_URL}           ${SERVER}/django/account/paymenthistory/
#
## Browser window size
#${WIDTH}                        1920
#${HEIGHT}                       1080
#
#
## Test user credentials
#${First Name}                   TestUser
#${Password}                     12345678
#${Zip}                          94105
#${Phone}                        1234567890
#
## Admin credentials
#${Admin_login}                  kavichki3+auto@yandex.ru
#${Admin_password}               tn#6n8(d2y#0
#
##Locators
#${Signup}                       xpath=//a[contains(@class, 'btn-green infinite') and text()='Зарегистрироваться']
#${Signup-submit}                xpath=//span[text()='Начать работу']/button
#${Signup-modal}                 xpath=//h3[text()='Регистрация']
#
#${Login}                        xpath=//a[text()='Войти']
#${Login-modal}                  xpath=//h3[text()='Вход в систему']
#${Login-submit}                 xpath=//span[text()='Войти']/button
#${Login-password}               xpath=//a[text()='Забыли пароль?']
#
#${Password-modal}               xpath=//h3[text()='Восстановление пароля']
#${Password-submit}              xpath=//span[text()='Отправить']/button
#
#${Account_Edit-submit}          xpath=//button[contains(text(),'Сохранить')]
#${Account_Edit-submit-dis}      xpath=//button[contains(text(),'Сохранить') and @disabled='disabled']
#
#${Add_project}                  xpath=//span[contains(text(),'Создать проект')]
#
#${Cr_Project-title}             xpath=//input[@placeholder='Магазин четвёрочка']
#${Cr_Project-submit}            xpath=//span[text()='Создать проект']/button[@type='submit']
#
#${Payment_sum}                  xpath=//input[@ng-model="add_payment.sum"]
#${Payment_submit}               xpath=//span[text()='Перейти к оплате']/button
#
#${Balance-sum}                  xpath=//label[contains(.,'Сумма:')]/following-sibling::input
#${Balance-submit}               xpath=//span[text()='Сохранить']/button
#
#${Balance-dropdown}             xpath=//div[contains(@class, 'header-balance-info')]/i[contains(@class, 'fa fa-caret-down')]
#
#${Ajax-loader}                  xpath=//div[contains(@ng-if,'loading') or contains(@ng-show,'loading') and not(contains(@class,'ng-hide'))]/div[@class='content-overlay']
#${Loading}                      xpath=//span[text()='Идет загрузка']
#
#${Campagins-New}                xpath=//span[contains(.,'Новая кампания') and @class='button button-green']/button
#${Campagins-Manual_add}         xpath=//div[@class='select-options ng-scope select-options__root' and contains(@style,'display: block')]//li[contains(text(),'Создать вручную')]
#${Campagins-age_clear}          xpath=//tr[@class='b-age-range__togglers']/td[contains(., 'Очистить все')]
#${Campagins-submit}             xpath=//span[text()='Создать кампанию']/button
#${targeing-submit}              xpath=//span[text()='Создать']/button
#${Campagins-save}               xpath=//div[contains(@class, 'advert-preview-block stick')]//span[text()='Сохранить']/button
#
#${Ad-Create}                    xpath=//span[@class='button button-green btn-big' and text()='Создать']
#${Ad-Save}                      xpath=//span[@class='button button-green btn-big' and text()='Сохранить']
#
#
##Alex---------------------------------
#
#${loading_ajax}                      xpath=//div[@class="popup-ajax-loader"]
##create target
#
#${all_project}                   xpath=//i[@class="fa fa-home"]
#${click_project}                xpath=//td[@class="b-table__td text-crop"]//a[contains(@title,"Тecтовая кампания 1")]
#${targets}                       xpath=//ul[@class="service-buts ng-scope"]//b[contains(text(),"Цели")]
#${create_new_target}            xpath=//div[@class="actions wrapper ng-scope"]/span[contains(text(),"Добавить новую цель")]
#${name_target}                  xpath=//*[@class="field-TD"]/input
#${save_target}                  xpath=//*[@class="floatR"]/span[contains(text(),"Сохранить")]
#${n_target}                     Test
#${account_hi}                   Account
#
#${all_campaign}                 xpath=//div[@class="tabs ng-scope"]/a[contains(.,"Все кампании")]
#${check_target}                 xpath=//span[@class="select-data"][contains(text(),"Цель")]
#${target_name}                  css=ul > li:nth-of-type(2) > input.form-checkbox
#${see_target_campaign}          xpath=(//*[@rel="secondary_goal_title"][contains(@title,"Test")])[1]
#${see_target_token}             xpath=(//*[@rel="secondary_goal_title"][contains(@title,"Account")])[1]
#${token_show}                   xpath=//div[@class="col-md-9 top-left"]//span[contains(text(),"Test")]
#${target_token}                 xpath=//div[@class="select-options ng-scope select-options__root"]//ul/li[2]
#
## create audit
#
#${audit}                        xpath=//ul[@class="service-buts ng-scope"]//b[contains(text(),"Аудитории")]
#${plus_audit}                   xpath=//*[@class="h-link" and contains(text(),"MyTarget")]//span
#${new_campaign}                 xpath=//span[@class="button button-green" and contains(.,"Новая кампания")]
#${create_manual}                xpath=//div[@class="select-options ng-scope select-options__root"]//li[contains(.,"Создать через ")]
#${create_manual_vk}             xpath=//div[@class="select-options ng-scope select-options__root"]//li[contains(.,"Создать вручную")]
#
#${create_title}                 xpath=//span[@class="button button-green" and contains(.,"Создать объявление")]
#${delete_audit}                 xpath=//i[@class="font-icon fa fa-trash-o i-green"]
#${test_project}                 Тестовый
#${input_project}                xpath=//input[@class="suggester-ts__input"]
#${click_project_1}              xpath=(//div[@class="b-table __projects ng-scope baron"]//a)[1]
#
#${cloud}                        xpath=//*[@class="act-ico act-custom glyphicons cloud-download"]


*** Keywords ***

Setup Tests
    #Start Virtual Display               ${WIDTH}    ${HEIGHT}
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

Create a new user                     [Arguments]               ${reg email}           ${name}
    Wait Until Page Contains            Send welcome email
    Input text                          name=email                   ${reg email}
    Input text                          name=first_name             ${name}
    Click Element                       xpath=//input[@class="submit-row"]

Registration Empty Fields              [Arguments]             ${times}
    wait until page contains           This field is required.
    Xpath Should Match X Times          //li[@ng-bind="error"]             ${times}

Registration Invalid Data           [Arguments]              ${data}          ${text}
    input text                       xpath=//input[@ng-model='$ctrl.registration.${data}']            ${text}


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
    Select Country                      United State
    click button                        Register

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
    wait until page contains             New Product
    click button                         Save
    Sleep                                1 sec
    Xpath Should Match X Times           //li[@ng-bind="error" and contains(.,"This field is required")]          9
    Capture Page Screenshot             ${TEST NAME}-{index}.png
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
    wait until page contains             New ASN
    click button                         Save
    Sleep                                1 sec
    Xpath Should Match X Times           //li[@ng-bind="error" and contains(.,"This field is required")]          6
    wait until element is visible        xpath=//li[@ng-bind="error" and contains(.,"Date has wrong format. Use one of these formats instead: YYYY[-MM[-DD]].")]
    wait until element is visible        xpath=//p[@class="dropify-error ng-binding ng-scope" and contains(.,"This field is required")]
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    #calendar
    Wait Element And Click               ${calendar_button}
    wait element and click               ${today_button}
    click element                       ${upload_file}
    ${test}=                            uploaded_file                    ${OUTPUTDIR}/test_file.pdf
    wait until page contains             File uploaded sucessfully
    input text                           ${contact_name_field}               ${first name}
    input text                           ${full_name_field}                  ${last name}
    input text                          ${address_1_field}                  ${address_1}
    input text                         ${city_field}                       ${city}
    input text                         ${postal_code_field}               ${post_code}
    input text                         ${state_field}                       ${state}
    Select Country                      United State
    input text                         ${items_field}                         ${item}
    wait element and click             ${items_list}
    wait until page contains element         xpath=//table[@class="table nowrap"]//td[contains(.,"${item}")]
    click button                       Save
    wait until page contains element       xpath=//table//td//a[contains(.,"${id_ship}")]
    Capture Page Screenshot             ${TEST NAME}-{index}.png

Wait table                               [Arguments]             ${name}
   wait until page contains element       xpath=//table//td//a[contains(.,"${name}")]


Get Id
    ${id}=                              Get Element Attribute           xpath=//table//td//a[contains(.,"FASN")]@text
    [return]                             ${id}

Header link                             [Arguments]             ${link}
    wait element and click              xpath=//div[@class="left-menu-inner scroll-pane"]//a[contains(.,"${link}")]

Add Shipping Options               [Arguments]             ${add}                 ${Some}             ${post}
    wait element and click          xpath=//*[@class="btn btn-primary" and contains(.,"${add}")]
    wait until page contains        New Shipping Option
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
    wait until page contains       New Group Item
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
    wait until page contains        New Order
    click button                    Save
    # Validation
    Sleep                                1 sec
    Xpath Should Match X Times           //li[@ng-bind="error" and contains(.,"This field is required")]          8
    Capture Page Screenshot             ${TEST NAME}-{index}.png
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






Wait No Overlay
    Wait Until Page Does Not Contain Element        ${Ajax-loader}       60
    #Wait For Xpath                        //div[contains(@ng-if,'loading') or contains(@ng-show,'loading')]/div[@class='content-overlay']       ${2}       ${30}

Open Phantom                              [Arguments]         ${url}
    ${service args}=                      create list         --ssl-protocol=any
    Create Webdriver                      PhantomJS           service_args=${service args}
    Set Window Size                       ${WIDTH}            ${HEIGHT}
    Go To                                 ${url}

Open Chrome                               [Arguments]         ${url}
    ${service args}=                      create list         --verbose --log-path=chromedriver.log
    Create Webdriver                      Chrome              service_args=${service args}
    Set Window Size                       ${WIDTH}            ${HEIGHT}
    Go To                                 ${url}

Open Russian Chrome                       [Arguments]         ${url}
    ${options}=                           Evaluate            sys.modules['selenium.webdriver'].ChromeOptions()   sys
    Call Method                           ${options}          add_argument      --lang\=ru-RU
    Create WebDriver                      Chrome              chrome_options=${options}
    Go To                                 ${url}



On Fail
    [Documentation]                      On Fail
    Set Screenshot Directory             ${OUTPUTDIR}/Errors/
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Set Screenshot Directory             ${OUTPUTDIR}/Screenshots/
    Close All Browsers

Click With Scroll                        [Arguments]                     ${element}
    Scroll To                            ${element}
    Click Element                        ${element}

Scroll To                                [Arguments]                     ${element}
    ${y}=                                Get Vertical Position           ${element}
    Execute JavaScript                   window.scroll(0,${y});

Check Block Invisible                    [Arguments]                     ${block}
    Page Should Contain Element          xpath=//div[@id='${block}' and @style='display: none;']

Check Block Visible                      [Arguments]                     ${block}
    Page Should Contain Element          xpath=//div[@id='${block}' and not(@style='display: none;')]

Get Mail link                            [Arguments]            ${res}
    ${url_right}=                        Fetch From Right     ${res}["mail_text_only"]    /password/reset
    ${url_left}=                         Fetch From Left      ${url_right}           \\n
    ${url}=                              Fetch From Left      ${url_left}            <br>
    ${link}=                             Catenate             SEPARATOR=             https://floship-staging.herokuapp.com/password/reset           ${url}
    [return]                             ${link}

Get Password                             [Arguments]          ${res}
    ${right}=                            Fetch From Right     ${res}["mail_text_only"]    You're receiving this email because you requested a password reset for your user account at floship-staging.herokuapp.com: \
    ${left}=                             Fetch From Left      ${right}               \\n
    ${password}=                         Fetch From Left      ${left}            <br>
    [return]                             ${password}

Get Project Number                       [Arguments]          ${name}
    Go To                                ${URL_PROJECTS}
    Wait Until Element Is Visible        xpath=//a[text()='${name}']
    ${num_temp}                          Get Element Attribute                       xpath=//a[text()='${name}']@href
    ${right}=                            Fetch From Right     ${num_temp}            /app/project/
    ${number}=                           Fetch From Left      ${right}               /campaigns/
    [return]                             ${number}



Check Mail                               [Arguments]          ${email}               ${message_id}
    ${result}=                           get mailbox          ${email}               ${message_id}
    Should Not Contain                   ${result}            'error'
    [return]                             ${result}


Check All Mail                           [Arguments]          ${email}
    ${result}=                           get mailbox          ${email}
    [return]                             ${result}

Get Bill Number
    Select Window                       new
    Wait Until Page Contains            Счет на оплату
    ${windows}=                         Get Window Titles
    ${bill_right}=                      Fetch From Right          ${windows}[1]         №ХК
    ${bill}=                            Fetch From Left           ${bill_right}         '

    Close Window
    Select Window                       main
    [return]                            ${bill}

Next Year
    ${date}=                             Get Current Date
    ${date_plus}=                        Add Time To Date     ${date}                365 days
    ${datetime}=                         Convert Date         ${date_plus}           result_format=%y
    [return]                             ${datetime}

Today
    ${date_now}=                         Get Current Date
    ${datetime}=                         Convert Date         ${date_now}}           result_format=%Y-%m-%d
    [return]                             ${datetime}


Admin Login
    Go To                                ${ADMIN_USER_URL}
    Wait Until Page Contains             Django Suit
    Input Text                           name=username             ${Admin_login}
    Input Text                           name=password             ${Admin_password}
    Click Element                        xpath=//input[@type="submit"]
    Wait Until Page Contains             Welcome

Approve payment                          [Arguments]                ${bill}
    Go To                                ${ADMIN_PAYMENTS_URL}
    Wait Until Page Contains             Payment historys
    Click Element                        xpath=//input[@value='${bill}']
    Select From List By Value            name=action                make_payment_approved
    Click Element                        xpath=//button[@type='submit']
    Wait Until Page Contains Element     xpath=//input[@value='${bill}']/../following-sibling::td[text()='Approved']

Add Balance                              [Arguments]                ${project_number}        ${type}          ${amount}
    Click Element                        xpath=//span[@dropdown-edit-field-id='dropdown-${type}-balance-project-${project_number}']
    Wait Until Page Contains             Изменение баланса для myTarget
    Wait Until Element Is Visible        xpath=//div[@id='dropdown-${type}-balance-project-${project_number}']//label[contains(.,'Сумма:')]/following-sibling::input
    Click Element                        xpath=//div[@id='dropdown-${type}-balance-project-${project_number}']//label[contains(.,'Сумма:')]/following-sibling::input
    Press key                            xpath=//div[@id='dropdown-${type}-balance-project-${project_number}']//label[contains(.,'Сумма:')]/following-sibling::input      ${amount}
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    #Click Element At Coordinates         xpath=//div[@id='dropdown-${type}-balance-project-${project_number}']//label[contains(.,'Сумма:')]         5           45
    Execute JavaScript	                  $("#dropdown-${type}-balance-project-${project_number} button[type='submit']").click()
    #Wait Until Element Is Visible        xpath=//div[@id='dropdown-${type}-balance-project-${project_number}']//button[@type='submit']
    #Click Element                        xpath=//div[@id='dropdown-${type}-balance-project-${project_number}']//button[@type='submit']
    Wait No Overlay
    Page Should Not Contain Element      xpath=//div[contains(@class,'noty_type_error')]

Start Project                            [Arguments]          ${name}
    Wait Until Element Is Visible        xpath=//div[@class='b-table __projects ng-scope']//a[text()='${name}']/following-sibling::*//span[text()='Остановлен']
    Click Element                        xpath=//div[@class='b-table __projects ng-scope']//a[text()='${name}']/following-sibling::*//span[text()='Остановлен']
    Wait Until Element Is Visible        xpath=//div[@class='select-options select-status dropdown-menu']//span[text()='Запустить']
    Click Element                        xpath=//div[@class='select-options select-status dropdown-menu']//span[text()='Запустить']
    Wait No Overlay
    Page Should Not Contain Element      xpath=//div[contains(@class,'noty_type_error')]
    Wait Until Element Is Visible        xpath=//div[@class='b-table __projects ng-scope']//a[text()='${name}']/following-sibling::*//span[contains(text(),'Запу')]

Stop Project                            [Arguments]          ${name}
    Wait Until Element Is Visible        xpath=//div[@class='b-table __projects ng-scope']//a[text()='${name}']/following-sibling::*//span[contains(text(),'Запу')]
    Click Element                        xpath=//div[@class='b-table __projects ng-scope']//a[text()='${name}']/following-sibling::*//span[contains(text(),'Запу')]
    Wait Until Element Is Visible        xpath=//div[@class='select-options select-status dropdown-menu']//span[text()='Остановить']
    Click Element                        xpath=//div[@class='select-options select-status dropdown-menu']//span[text()='Остановить']
    Wait No Overlay
    Page Should Not Contain Element      xpath=//div[contains(@class,'noty_type_error')]
    Wait Until Element Is Visible        xpath=//div[@class='b-table __projects ng-scope']//a[text()='${name}']/following-sibling::*//span[contains(text(),'Остан')]

Set Target Age                           [Arguments]          ${age}
    Wait Until Element Is Visible        ${Campagins-age_clear}
    Click Element                        ${Campagins-age_clear}
    Click Element                        xpath=//td[contains(.,'${age}') and @class='col-title ng-binding']
    Wait Until Element Is Visible        xpath=//td[@id='colindex_${age}' and @class='col col-selectable scale-100']

Click target checkbox                           [Arguments]          ${label}
    Wait Until Element Is Visible        xpath=//label[contains(@class, 'checkbox')]/span[text()='${label}']
    Click Element                        xpath=//label[contains(@class, 'checkbox')]/span[text()='${label}']
    Wait Until Element Is Visible        xpath=//span[contains(@class, 'targ-label') and contains(.,'${label}')]

Select dropdown                          [Arguments]          ${label}      ${value}
    Wait Until Element Is Visible        xpath=//p[contains(.,'${label}')]/following-sibling::*//div[@class='select-data dropdown-toggle']
    Click Element                        xpath=//p[contains(.,'${label}')]/following-sibling::*//div[@class='select-data dropdown-toggle']
    Wait Until Element Is Visible        xpath=//li/span[contains(., '${value}')]
    Click Element                        xpath=//li/span[contains(., '${value}')]
    Wait Until Element Is Not Visible    xpath=//li/span[contains(., '${value}')]
    Sleep                                1

Select multi dropdown                    [Arguments]          ${label}      ${value}
    Wait Until Element Is Visible        xpath=//p[contains(.,'${label}')]/following-sibling::*//div[@class='select-data dropdown-toggle']
    Click Element                        xpath=//p[contains(.,'${label}')]/following-sibling::*//div[@class='select-data dropdown-toggle']
    Wait Until Element Is Visible        xpath=//li/div/span[contains(., '${value}')]
    Click Element                        xpath=//li/div/span[contains(., '${value}')]
    Wait Until Element Is Not Visible    xpath=//li/div/span[contains(., '${value}')]
    Sleep                                1

Get Campagin Cell                        [Arguments]          ${title}      ${cell}
    Wait Until Element Is Visible        xpath=//div[@class='b-table __campaigns ng-scope']//table//tr[position()=count(//div[@class='b-table __campaigns ng-scope']//td[contains(.,'${title}')]/parent::*/preceding-sibling::*)+1]/td[@title='${cell}']
    Mouse Over                           xpath=//div[@class='b-table __campaigns ng-scope']//table//tr[position()=count(//div[@class='b-table __campaigns ng-scope']//td[contains(.,'${title}')]/parent::*/preceding-sibling::*)+1]/td[@title='${cell}']
    ${text}=                             Get Text                             xpath=//div[@class='b-table __campaigns ng-scope']//table//tr[position()=count(//div[@class='b-table __campaigns ng-scope']//td[contains(.,'${title}')]/parent::*/preceding-sibling::*)+1]/td[@title='${cell}']
    [return]                             ${text}

Get Campagin Number                      [Arguments]          ${project_number}     ${name}
    Go To                                ${URL_PROJECT}${project_number}/campaigns/
    Wait Until Page Contains             Все кампании
    Wait No Overlay
    Wait Until Page Does Not Contain     Идет загрузка
    Sleep                                2
    Wait Until Element Is Visible        xpath=//div[@class='b-table __campaigns ng-scope']//a[@title='${name}']
    ${num_temp}                          Get Element Attribute                       xpath=//div[@class='b-table __campaigns ng-scope']//a[@title='${name}']@href
    ${right}=                            Fetch From Right     ${num_temp}            /app/campaign/
    ${number}=                           Fetch From Left      ${right}               /ads/
    [return]                             ${number}

Start Campagin                            [Arguments]          ${name}
    Wait Until Element Is Visible        xpath=//div[@class='b-table __campaigns ng-scope']//a[@title='${name}']/following-sibling::*//div[contains(text(),'Новая')]
    Click Element                        xpath=//div[@class='b-table __campaigns ng-scope']//a[@title='${name}']/following-sibling::*//div[contains(text(),'Новая')]
    Wait Until Element Is Visible        xpath=//div[@class='select-options select-status' and @style="display: block;"]//span[contains(text(),'Запустить')]
    Click Element                        xpath=//div[@class='select-options select-status' and @style="display: block;"]//span[contains(text(),'Запустить')]
    Wait No Overlay
    Page Should Not Contain Element      xpath=//div[contains(@class,'noty_type_error')]
    Wait Until Page Does Not Contain     Идет загрузка
    Wait Until Element Is Visible        xpath=//div[@class='b-table __campaigns ng-scope']//a[@title='${name}']/following-sibling::*//div[contains(text(),'Запу')]

Stop Campagin                            [Arguments]          ${name}
    Wait Until Element Is Visible        xpath=//div[@class='b-table __campaigns ng-scope']//a[@title='${name}']/following-sibling::*//div[contains(text(),'Запу')]
    Click Element                        xpath=//div[@class='b-table __campaigns ng-scope']//a[@title='${name}']/following-sibling::*//div[contains(text(),'Запу')]
    Wait Until Element Is Visible        xpath=//div[@class='select-options select-status' and @style="display: block;"]//span[contains(text(),'Остановить')]
    Click Element                        xpath=//div[@class='select-options select-status' and @style="display: block;"]//span[contains(text(),'Остановить')]
    Wait No Overlay
    Page Should Not Contain Element      xpath=//div[contains(@class,'noty_type_error')]
    Wait Until Page Does Not Contain     Идет загрузка
    Wait Until Element Is Visible        xpath=//div[@class='b-table __campaigns ng-scope']//a[@title='${name}']/following-sibling::*//div[contains(text(),'Остан')]

Get Ad Number                            [Arguments]          ${campagin_number}     ${name}
    Go To                                ${URL_CAMPAGIN}${campagin_number}/ads/
    Wait Until Page Contains             Все объявления
    Wait No Overlay
    Wait Until Page Does Not Contain     Идет загрузка
    Wait Until Element Is Visible        xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='${name}']/../preceding-sibling::a[@class='fa fa-cog']
    ${num_temp}                          Get Element Attribute                       xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='${name}']/../preceding-sibling::a[@class='fa fa-cog']@href
    ${number}=                           Fetch From Right     ${num_temp}            /app/ad/
    [return]                             ${number}

Start Ad                                 [Arguments]          ${name}
    Wait Until Element Is Visible        xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='${name}']/../following-sibling::*/div[contains(text(),'Новое')]
    Click Element                        xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='${name}']/../following-sibling::*/div[contains(text(),'Новое')]
    Wait Until Element Is Visible        xpath=//div[@class='select-options select-status' and @style="display: block;"]//span[contains(text(),'Запустить')]
    Click Element                        xpath=//div[@class='select-options select-status' and @style="display: block;"]//span[contains(text(),'Запустить')]
    Wait No Overlay
    Wait Until Page Does Not Contain     Идет загрузка
    Wait Until Element Is Visible        xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='${name}']/../following-sibling::*/div[contains(text(),'Запу')]

Stop Ad                                  [Arguments]          ${name}
    Wait Until Element Is Visible        xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='${name}']/../following-sibling::*/div[contains(text(),'Запу')]
    Click Element                        xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='${name}']/../following-sibling::*/div[contains(text(),'Запу')]
    Wait Until Element Is Visible        xpath=//div[@class='select-options select-status' and @style="display: block;"]//span[contains(text(),'Остановить')]
    Click Element                        xpath=//div[@class='select-options select-status' and @style="display: block;"]//span[contains(text(),'Остановить')]
    Wait No Overlay
    Wait Until Page Does Not Contain     Идет загрузка
    Wait Until Element Is Visible        xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='${name}']/../following-sibling::*/div[contains(text(),'Новое')]

Delete Ad                                [Arguments]          ${name}
    Wait Until Element Is Visible        xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='${name}']/../following-sibling::*/div
    Click Element                        xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='${name}']/../following-sibling::*/div
    Wait Until Element Is Visible        xpath=//div[@class='select-options select-status' and @style="display: block;"]//span[contains(text(),'Архивировать')]
    Click Element                        xpath=//div[@class='select-options select-status' and @style="display: block;"]//span[contains(text(),'Архивировать')]
    ${message}=	                         Confirm Action
    Should Contain                       ${message}         Объявления нельзя будет восстановить. Удалять?
    Wait No Overlay
    Page Should Not Contain Element      xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='${name}']/../following-sibling::*/div[contains(text(),'Новое')]
    Page Should Not Contain Element      xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='${name}']/../following-sibling::*/div[contains(text(),'Запу')]

Delete Campagin                            [Arguments]          ${name}
    Wait Until Element Is Visible        xpath=//div[@class='b-table __campaigns ng-scope']//a[@title='${name}']/following-sibling::*//div
    Click Element                        xpath=//div[@class='b-table __campaigns ng-scope']//a[@title='${name}']/following-sibling::*//div
    Wait Until Element Is Visible        xpath=//div[@class='select-options select-status' and @style="display: none;"]//span[contains(text(),'Архивировать')]
    Click Element                        xpath=//div[@class='select-options select-status' and @style="display: none;"]//span[contains(text(),'Архивировать')]
    ${message}=	                         Confirm Action
    Should Contain                       ${message}         Кампании нельзя будет восстановить. Удалять?
    Wait No Overlay
    Wait Until Page Does Not Contain     Идет загрузка
    Page Should Not Contain Element      xpath=//div[@class='b-table __campaigns ng-scope']//a[@title='${name}']/following-sibling::*//div[contains(text(),'Новая')]
    Page Should Not Contain Element      xpath=//div[@class='b-table __campaigns ng-scope']//a[@title='${name}']/following-sibling::*//div[contains(text(),'Запу')]

Set Campagin Rate                        [Arguments]          ${title}      ${rate}
    Wait Until Element Is Visible        xpath=//div[@class='b-table __campaigns ng-scope']//table//tr[position()=count(//div[@class='b-table __campaigns ng-scope']//td[contains(.,'${title}')]/parent::*/preceding-sibling::*)+1]/td[@title='Cтавка']//div[contains(@class,'dropdown-toggle')]
    Click Element                        xpath=//div[@class='b-table __campaigns ng-scope']//table//tr[position()=count(//div[@class='b-table __campaigns ng-scope']//td[contains(.,'${title}')]/parent::*/preceding-sibling::*)+1]/td[@title='Cтавка']//div[contains(@class,'dropdown-toggle')]
    Wait Until Page Contains             Ставка кампании
    Wait Until Element Is Visible        xpath=//div[contains(@class,'dropdown-shadow') and not(contains(@style,'display: none;'))]//span[text()='Ставка кампании']/following-sibling::input
    Clear Element Text	                 xpath=//div[contains(@class,'dropdown-shadow') and not(contains(@style,'display: none;'))]//span[text()='Ставка кампании']/following-sibling::input
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Press key                            xpath=//div[contains(@class,'dropdown-shadow') and not(contains(@style,'display: none;'))]//span[text()='Ставка кампании']/following-sibling::input      ${rate}
    Wait Until Element Is Not Visible    xpath=//div[@ng-hide='hasPriceTactics(campaign)']//div[@class='ajax-loader']
    #Click Element                        xpath=//div[contains(@class,'dropdown-shadow') and not(contains(@style,'display: none;'))]//button[@type='submit']
    Execute JavaScript	                 $("[ng-submit='saveKey(campaign, 'price', $event); $root.closeDropdowns()'] [type='submit']:visible").click();
    Wait No Overlay
    Page Should Not Contain Element      xpath=//div[contains(@class,'noty_type_error')]
    Capture Page Screenshot              ${TEST NAME}-{index}.png

Set Campagin Limit                       [Arguments]          ${title}      ${limit}
    Wait Until Element Is Visible        xpath=//div[@class='b-table __campaigns ng-scope']//table//tr[position()=count(//div[@class='b-table __campaigns ng-scope']//td[contains(.,'${title}')]/parent::*/preceding-sibling::*)+1]/td[@title='Общий лимит']//div[contains(@class,'dropdown-toggle')]
    Click Element                        xpath=//div[@class='b-table __campaigns ng-scope']//table//tr[position()=count(//div[@class='b-table __campaigns ng-scope']//td[contains(.,'${title}')]/parent::*/preceding-sibling::*)+1]/td[@title='Общий лимит']//div[contains(@class,'dropdown-toggle')]
    Wait Until Element Is Visible        xpath=//div[contains(@class,'dropdown-shadow') and not(contains(@style,'display: none;'))]//span[text()='Лимит']/following-sibling::input
    Sleep                                2 s
    Clear Element Text	                 xpath=//div[contains(@class,'dropdown-shadow') and not(contains(@style,'display: none;'))]//span[text()='Лимит']/following-sibling::input
    Press key                            xpath=//div[contains(@class,'dropdown-shadow') and not(contains(@style,'display: none;'))]//span[text()='Лимит']/following-sibling::input     ${limit}
    Sleep                                2 s
    Execute JavaScript	                 $("[ng-submit='saveKey(campaign, 'limit_total', $event); $root.closeDropdowns()'] [type='submit']:visible").click();
    Wait No Overlay
    Page Should Not Contain Element      xpath=//div[contains(@class,'noty_type_error')]
    Capture Page Screenshot              ${TEST NAME}-{index}.png

Set Campagin Daily Limit                 [Arguments]          ${title}      ${limit}
    Wait Until Element Is Visible        xpath=//div[@class='b-table __campaigns ng-scope baron']//table//tr[position()=count(//div[@class='b-table __campaigns ng-scope']//td[contains(.,'${title}')]/parent::*/preceding-sibling::*)+1]/td[@ng-if='views.campaigns.limit_day']//div[contains(@class,'dropdown-toggle')]
    Click Element                        xpath=//div[@class='b-table __campaigns ng-scope baron']//table//tr[position()=count(//div[@class='b-table __campaigns ng-scope']//td[contains(.,'${title}')]/parent::*/preceding-sibling::*)+1]/td[@ng-if='views.campaigns.limit_day']//div[contains(@class,'dropdown-toggle')]
    Wait Until Element Is Visible        xpath=//div[contains(@class,'dropdown-shadow') and not(contains(@style,'display: none;'))]//span[text()='Лимит']/following-sibling::input
    Sleep                                2 s
    Clear Element Text	                 xpath=//div[contains(@class,'dropdown-shadow') and not(contains(@style,'display: none;'))]//span[text()='Лимит']/following-sibling::input
    Press key                            xpath=//div[contains(@class,'dropdown-shadow') and not(contains(@style,'display: none;'))]//span[text()='Лимит']/following-sibling::input     ${limit}
    Sleep                                2 s
    Execute JavaScript	                 $("[ng-submit='saveKey(campaign, 'limit_day', $event); $root.closeDropdowns()'] [type='submit']:visible").click();
    Wait No Overlay
    Page Should Not Contain Element      xpath=//div[contains(@class,'noty_type_error')]
    Capture Page Screenshot              ${TEST NAME}-{index}.png

Select Campagin                          [Arguments]          ${title}
    Wait Until Element Is Visible        xpath=//div[@class='b-table __campaigns ng-scope']//a[@title='${title}']/../../preceding-sibling::td/label
    Click Element                        xpath=//div[@class='b-table __campaigns ng-scope']//a[@title='${title}']/../../preceding-sibling::td/label
    Wait Until Element Is Visible        xpath=//div[@class='b-table __campaigns ng-scope']//a[@title='${title}']/../../preceding-sibling::td/label[@class='checkbox checked']

Edit Multiple Rates Limits               [Arguments]          ${action}     ${field}       ${amount}
    Wait Until Element Is Visible        css=[uib-tooltip='Массовое редактирование лимитов и ставок']
    Click Element                        css=[uib-tooltip='Массовое редактирование лимитов и ставок']
    Wait Until Page Contains             Массовое редактирование лимитов и ставок
    Wait Until Element Is Visible        xpath=//span[text()='поле']/preceding-sibling::div
    Click Element                        xpath=//span[text()='поле']/preceding-sibling::div
    Wait Until Element Is Visible        xpath=//span[@class='ng-binding' and text()='${action}']
    Click Element                        xpath=//span[@class='ng-binding' and text()='${action}']
    Wait Until Element Is Visible        xpath=//span[text()='поле']/following-sibling::div
    Click Element                        xpath=//span[text()='поле']/following-sibling::div
    Wait Until Element Is Visible        xpath=//span[@class='ng-binding' and text()='${field}']
    Click Element                        xpath=//span[@class='ng-binding' and text()='${field}']
    Wait Until Element Is Visible        css=[ng-model='mass_limits.value']
    Clear Element Text                   css=[ng-model='mass_limits.value']
    Press key                            css=[ng-model='mass_limits.value']       ${amount}
    Execute JavaScript	                 $("[ng-submit='applyValue()'] [type='submit']").click()
    Wait No Overlay
    Page Should Not Contain Element      xpath=//div[contains(@class,'noty_type_error')]
    Capture Page Screenshot              ${TEST NAME}-{index}.png

Select Ad Dropdown                       [Arguments]          ${label}      ${option}
    Wait Until Element Is Visible        xpath=//div[contains(@class,'ng-scope') and not(contains(@class,'ng-hide'))]/div[@class='field-TH']/span[text()='${label}:']/../following-sibling::div[@class='field-TD']/div[@class='select-emul ng-scope']/span
    Click Element                        xpath=//div[contains(@class,'ng-scope') and not(contains(@class,'ng-hide'))]/div[@class='field-TH']/span[text()='${label}:']/../following-sibling::div[@class='field-TD']/div[@class='select-emul ng-scope']/span
    Wait Until Element Is Visible        xpath=//div[@class='select-options' and @style='display: block;']//span[text()='${option}']
    Click Element                        xpath=//div[@class='select-options' and @style='display: block;']//span[text()='${option}']
    Wait No Overlay

Select Ad Theme                          [Arguments]          ${label}      ${theme}
    Wait Until Element Is Visible        xpath=//p[contains(.,'${label}')]/following-sibling::*//span[@ng-show='getSelectedCategory().main_id']/..
    Click Element                        xpath=//p[contains(.,'${label}')]/following-sibling::*//span[@ng-show='getSelectedCategory().main_id']/..
    Wait Until Element Is Visible        xpath=//div[@class='select-options dropdown-menu' and contains(@style,'display: block')]//li/span[contains(text(),'${theme}')]
    Click Element                        xpath=//div[@class='select-options dropdown-menu' and contains(@style,'display: block')]//li/span[contains(text(),'${theme}')]
    Wait Until Element Is Visible        xpath=//span[@ng-show='getSelectedCategory().main_id' and contains(text(),'${theme}')]

Select Ad                                [Arguments]          ${title}
    Wait Until Element Is Visible        xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='${title}']/../../../preceding-sibling::td/label
    Click Element                        xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='${title}']/../../../preceding-sibling::td/label
    Sleep                                1
    Checkbox Should Be Selected          xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='${title}']/../../../preceding-sibling::td/label[@class='checkbox']/input

Get Ad Cell                              [Arguments]          ${title}      ${cell}
    Wait Until Element Is Visible        xpath=//div[@class='b-table __ads ng-scope']//table//tr[position()=count(//div[@class='b-table __ads ng-scope']//td[contains(.,'${title}')]/parent::*/preceding-sibling::*)+1]/td[@title='${cell}']
    Mouse Over                           xpath=//div[@class='b-table __ads ng-scope']//table//tr[position()=count(//div[@class='b-table __ads ng-scope']//td[contains(.,'${title}')]/parent::*/preceding-sibling::*)+1]/td[@title='${cell}']
    ${text}=                             Get Text                             xpath=//div[@class='b-table __ads ng-scope']//table//tr[position()=count(//div[@class='b-table __ads ng-scope']//td[contains(.,'${title}')]/parent::*/preceding-sibling::*)+1]/td[@title='${cell}']
    [return]                             ${text}

#Alex---------------------------

Click Radio Button                      [Arguments]                     ${social_net}
    Click Element                       xpath=//*[@class="elements-group"]//span[contains(text(),"${social_net}")]

Target is created                       [Arguments]                     ${target}
    Wait Until Element Is Visible       xpath=//div[@class="item ng-scope"]/div//span[contains(text(),"${target}")]

Create Token Hi                         [Arguments]                     ${token}
    Wait Until Element Is Visible       xpath=(//span[@class="select-data ng-binding"][contains(text(),"${token}")])[3]
    Click Element                       xpath=(//span[@class="select-data ng-binding"][contains(text(),"${token}")])[3]
    Click Element                       xpath=(//span[@class="pseudo-link"][contains(text(),"Добавить токен")])[3]
    Input Text                          xpath=//input[@ng-model="hs_add_data.title"]                Test
    Click Element                       xpath=(//span[@class="button button-green"]/button)[1]
    Wait Until Element Is Visible       xpath=//span[@class="select-data ng-binding"][contains(text(),"Test")]


Adding Audit                            [Arguments]                     ${audit}

    Wait No Overlay
    Input Text                          css=#input-aud-title                            TestAudit
    Click Element                       xpath=//*[@class="select-data"]/span[contains(text(),"Выберите типы источников данных")]
    Wait Until Element Is Visible       xpath=//*[@class="select-options"]//li/span[contains(.,"Группы в «Одноклассниках»")]
    Click Element                       xpath=//*[@class="select-options"]//li/span[contains(.,"Группы в «Одноклассниках»")]
    Click Element                       xpath=//*[@class="btn btn-info btn-sm" and contains(.,"Отобразить")]
    Wait Until Element Is Visible       xpath=(//div[@class="col-md-12 audience-item"]//span[contains(text(),"Группа")])[1]
    Input Text                          xpath=(//*[@placeholder="Название группы"])[1]                     Котя
    Wait Until Element Is Visible       xpath=(//*[@class="select-options visible force-visible"]//ul/li//span[contains(text(),"Котята")])[1]
    Click Element                       xpath=(//*[@class="select-options visible force-visible"]//ul/li//span[contains(text(),"Котята")])[1]
    Wait Until Element Is Visible       xpath=//div[@class="audience-sources"]//div[@class="row"]//label[contains(text(),"Группы")]/../../div[2]//button
    Click Element                       xpath=//div[@class="audience-sources"]//div[@class="row"]//label[contains(text(),"Группы")]/../../div[2]//button
    Wait Until Element Is Visible      xpath=//label[@class="checkbox checked"]//span[contains(@title,"Котята")]

    Click Element                      xpath=(//div[@class="col-md-12 audience-item"]//span[contains(text(),"Группа")])[1]
    Wait Until Element Is Visible      xpath=//div[@class="select-options"]//span[contains(text(),"Тематика")]
    Click Element                      xpath=//div[@class="select-options"]//span[contains(text(),"Тематика")]
    Wait Until Element Is Visible      xpath=//span[@class="ng-binding" and contains(.,"Музыка")]
    Click Element                      xpath=//span[@class="ng-binding" and contains(.,"Музыка")]
    Wait Until Element Is Visible      xpath=//span[@class="ng-binding" and contains(.,"Кино и ТВ")]
    Click Element                      xpath=//span[@class="ng-binding" and contains(.,"Кино и ТВ")]
    Click Element                      xpath=//div[@class="audience-sources"]//div[@class="row"]//label[contains(text(),"Группы")]/../../div[2]//button
    Wait Until Element Is Visible      xpath=//label[@class="checkbox checked"]//span[contains(@title,"Кино и ТВ")]
    Click Element                      xpath=//span[@class="button-2 button-blue btn-big"]
    Wait Until Element Is Visible      xpath=//div[@ng-controller="AudienceListCtrl"][contains(.,"MyTarget")]/div//span[contains(.,"${audit}")]


Select a new audit in campaign          [Arguments]                        ${audit}
    Sleep                               2 sec
    Click Element                       xpath=//input[@class="selector-input ng-pristine ng-valid ng-empty ng-touched"]
    Wait Until Element Is Visible       xpath=//li[@title="${audit}"]
    Click Element                       xpath=//li[@title="${audit}"]

Audit is created                        [Arguments]                         ${test}
    Wait Until Element Is Visible          xpath=//*[contains(text(),"Группы ремаркетинга")]/../span[contains(.,"${test}")]

Check audit in campaign                     [Arguments]             ${label}      ${not_audit}
    Wait Until Element Is Visible        xpath=//p[contains(.,'${label}')]/following-sibling::*//div[@class='select-data dropdown-toggle']
    Click Element                        xpath=//p[contains(.,'${label}')]/following-sibling::*//div[@class='select-data dropdown-toggle']
    Wait Until Element Is Visible        xpath=(//li[@class="disabled"]/span[contains(.,"${not_audit}")])[3]

Audit is not visible                          [Arguments]               ${test}
    Sleep                                       3 sec
    Wait Until Element Is Not Visible          xpath=(//tr[@class="b-table__tdtr ng-scope"])[3]//*[contains(text(),"Группы ремаркетинга")]/../span[contains(.,"${test}")]
    Page Should Not Contain Element            xpath=(//tr[@class="b-table__tdtr ng-scope"])[3]//*[contains(text(),"Группы ремаркетинга")]/../span[contains(.,"${test}")]

Auth to target sandbox
    go to                               https://mail.ru
    input text                          css=#mailbox__login                 hic.agency
    input text                          css=#mailbox__password              zzahujj
    click element                       css=#mailbox__auth__button
    wait until page contains            hic.agency@mail.ru
    go to                               https://target-sandbox.my.com
    wait until element contains         xpath=(//*[@data-loc-ru="Аудитории"])[1]

Get Random Project
    ${faker_project}=                    Generate Random String     7    [LOWER]
    ${project}=                          Catenate	SEPARATOR=     ${test_project}        ${faker_project}
    [return]                             ${project}

Add balance to project and run                  [Arguments]                 ${run}
    wait until element is visible        xpath=(//div[@class='b-table__scroller']//span[@class="edit-field-value ng-binding"])[2]
    click element                        xpath=(//div[@class='b-table__scroller']//span[@class="edit-field-value ng-binding"])[2]
    wait until page contains             Изменение баланса для myTarget
    input text                          xpath=(//div[@class="box-edit-value balance-edit-value"]//span[contains(.,"Изменение баланса для myTarget")]/../..//input)[4]               43
    wait until element is visible       xpath=//span[@class="ng-binding" and contains(.,"С доступного остатка")]
    click element                       xpath=(//div[@class="box-edit-value balance-edit-value"]//span[contains(.,"Изменение баланса для myTarget")]/../..//input/../../div[@class="buttons"]/span[contains(.,"Сохранить")])[4]
    wait until element is visible       xpath=(//td[@class="b-table__td ng-scope"]//span[@class="edit-field-value ng-binding" and contains(.,"43.00 ₽")])[2]
    click element                       xpath=(//tbody[@class="b-table__tbody"]//label[@class="checkbox"])[1]
    wait until element is visible       xpath=//div[@class="actions wrapper ng-scope"]//i[@uib-tooltip="Запустить"]
    click element                       xpath=//div[@class="actions wrapper ng-scope"]//i[@uib-tooltip="Запустить"]
    Wait Until Page Contains            Проекты успешно запущены
    wait until element is visible       xpath=(//td[@class="b-table__td text-crop"]//div[@class="control"]//span[contains(.,"${run}")])[1]

Authorisation to target sandbox         [Arguments]                     ${mail_hi}
    Go to                               https://mail.ru
    input text                          css=#mailbox__login                 hic.agency
    input text                          css=#mailbox__password              zzahujj
    click element                       css=#mailbox__auth__button
    Wait Until Page Contains            ${mail_hi}
    go to                               https://target-sandbox.my.com
    Wait Until Element Is Visible       xpath=//div[@class="welcome-block__buttons"]/div[contains(.,"начать работу")]
    Click Element                       xpath=//div[@class="welcome-block__buttons"]/div[contains(.,"начать работу")]
    sleep                               2 sec
    click element                       xpath=(//span[@data-type="mail"])[1]
    Select Window                       OAuth
    Wait Until Element Is Visible       xpath=//span[@class="accounts__item__title"]
    click element                       xpath=//span[@class="accounts__item__title"]
    #Wait Until Element Is Visible       xpath=//*[@data-node-id and contains(.,"Добавить ")]
    Sleep                               5 sec
    Select Window                       Клиенты
    Wait Until Element Is Visible       xpath=//input[@class="suggester-ts__input"]



Create audit in target sandbox          [Arguments]             ${import_audit}
    set selenium speed                  .1 sec
    wait until page contains            У вас нет активных кампаний.          60
    Wait Until Element Is Visible       xpath=(//*[@data-loc-ru="Аудитории"])[1]
    click element                       xpath=(//*[@data-loc-ru="Аудитории"])[1]
    wait until page contains            Источники данных
    click element                       xpath=//ul[@class="sources-nav"]/li/span[contains(.,"Группы (OK)")]
    wait until page contains element    xpath=//input[@placeholder="Введите название группы или тематики ..."]
    input text                          xpath=//input[@placeholder="Введите название группы или тематики ..."]             КАВКАЗ
    wait until element is visible       xpath=(//ul[@class="suggester-ts__items js-item-list "]//li/span[contains(.,"КАВКАЗ")])[1]
    click element                       xpath=(//ul[@class="suggester-ts__items js-item-list "]//li/span[contains(.,"КАВКАЗ")])[1]
    wait until page contains            Группа добавлена в список источников.
    click element                       xpath=//input[@value="Создать аудиторию..."]
    wait until element is visible       xpath=//input[@class="audience-form__audience-name-input js-audience-form-name"]
    clear element text                  xpath=//input[@class="audience-form__audience-name-input js-audience-form-name"]
    input text                          xpath=//input[@class="audience-form__audience-name-input js-audience-form-name"]       ${import_audit}
    click element                       xpath=//li[@class="source-audience"]//input/../span[contains(.,"Группа OK «КАВКАЗ»")]

    click element                       xpath=//input[@class="audience-form__create-button"]
    wait until page contains            Аудитория успешно создана
    page should contain element         xpath=//*[@data-node-id="${import_audit}"]
    page should contain element         xpath=//*[@data-node-id="ГруппаOK«КАВКАЗ»" and contains(.,"1 аудитория")]




Create Mass of RK and RO                [Arguments]                 ${mass_ad}
    Sleep                               3 sec
    wait until element is visible       ${new_campaign}
    click element                       ${new_campaign}
    wait until element is visible       ${create_manual}
    click element                       ${create_manual}
    Wait No Overlay
    wait until page contains            ${mass_ad}
    Clear Element Text                  xpath=//div[@class="main-input"]/input
    Focus                               xpath=//div[@class="main-input"]/input
    Press Key                           xpath=//div[@class="main-input"]/input        ma
    Press Key                           xpath=//div[@class="main-input"]/input        il
    Press Key                           xpath=//div[@class="main-input"]/input        .ru
    Sleep                               2 sec
    click element                       xpath=//*[@class="ng-binding" and contains(.,"Тизер 90х75 в социальных сетях и сервисах, myTarget, Внешний сайт, Клики")]
    click element                       css=a.page-button
    Wait Until Page Contains            Креативы


Creative
    wait until element is visible       xpath=//li[@class="separately"]
    click element                       xpath=//li[@class="separately"]
    wait until page contains            Метод комбинирования

    Clear Element Text                   xpath=//textarea[@name="header-0"]
    Focus                                xpath=//textarea[@name="header-0"]
    Press Key                            xpath=//textarea[@name="header-0"]         te
    Press Key                            xpath=//textarea[@name="header-0"]         st AD

    clear element text                  xpath=//textarea[@name="body-0"]
    Focus                                xpath=//textarea[@name="body-0"]
    Press Key                           xpath=//textarea[@name="body-0"]         te
    Press Key                           xpath=//textarea[@name="body-0"]         st2 AD2

    Choose File                          css=.leupload             ${CURDIR}/145-85.jpg
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Wait Until Element Is Visible        xpath=//div[@id='dropdown-edit-crop-image']//div[contains(@class, 'popup-body')]
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Click Element                        xpath=//div[@id='dropdown-edit-crop-image']//button
    Wait Until Element Is Not Visible    xpath=//div[@id='dropdown-edit-crop-image']//div[contains(@class, 'popup-body')]
    Sleep                                3 sec
    click element                       xpath=//span[@class="button button-green btn_x3 help-item"]/button
    wait until page contains            В сумме 1 креативов
    click element                       css=a.page-button















Admin Panel Django
    Go to                               https://test.hiconversion.ru/django/
    input text                          id=id_username                          kavichki1
    input text                          id=id_password                          123123
    click element                       css=.btn.btn-info
    wait until page contains            Django Suit
    click element                       xpath=(//div[@class="left-nav"]//a[@href="/django/account/accountcontract/"])[1]
    wait until element is visible       xpath=//li[@class="active"]//a[contains(.,"Payment historys")]
    click element                       xpath=//li[@class="active"]//a[contains(.,"Payment historys")]
    wait until element is visible       xpath=//tr[@class="row1"]//td/a[contains(text(),"${First Name}")]/../..//input
    click element                       xpath=//tr[@class="row1"]//td/a[contains(text(),"${First Name}")]/../..//input
    click element                       xpath=//select[@name]
    wait until element is visible       xpath=//select[@name]/option[contains(.,"Подтвердить платёж")]
    click element                       xpath=//select[@name]/option[contains(.,"Подтвердить платёж")]
    wait until element is visible       xpath=//div[@class="actions"]//button
    click button                        Go
    wait until element is visible       xpath=//tr[@class="row1"]//td[contains(.,"Approved")]/../td[contains(.,"${First Name}")]
    click element                       xpath=//span[@class="user-links"]/a[contains(.,"Выйти")]
    wait until page contains            Благодарим вас за время, проведенное на этом сайте.

Adding Balance                          [Arguments]                     ${balance}
    Click Element                       css=.header-balance-info
    wait until page contains element    xpath=//span[@class="button button-blue" and contains(.,"Пополнить")]
    click element                       xpath=//span[@class="button button-blue" and contains(.,"Пополнить")]
    wait until page contains            Пополнение счета
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    clear element text                  xpath=//*[@ng-model="add_payment.sum"]
    input text                          xpath=//*[@ng-model="add_payment.sum"]                  ${balance}
    page should contain radio button    xpath=//input[@type="radio" and @checked="checked"]                             Безналичный расчет через:
    click element                       xpath=//span[@class="button button-green btn-big" and contains(.,"Перейти к оплате")]
    Sleep                               3 sec
    Capture Page Screenshot             ${TEST NAME}-{index}.png


Check Rate First Time                       [Arguments]     ${client}

    wait until element is visible       xpath=//span[@class="ng-binding dropdown-toggle"]
    click element                       xpath=//span[@class="ng-binding dropdown-toggle"]
    wait until element is visible       xpath=//div[@id="dropdown-tarif-data"]/div[contains(.,"${client}")]/../div[contains(.,"${client}")]
    click element                       xpath=//span[@class="button button-blue" and contains(.,"Изменить тариф")]


Change Rate Error                       [Arguments]             ${e_msg}
    wait until page contains            Смена тарифа
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    wait until element is visible       xpath=//span[@class="ng-binding"][contains(.,"Со следующего периода")]
    click element                       xpath=//span[@class="ng-binding"][contains(.,"Со следующего периода")]
    click element                       xpath=//span[@class="button button-green btn-big" and contains(.,"Активировать")]
    wait until page contains element    xpath=//div[@class="noty_message"]/span[contains(.,"${e_msg}")]
    Capture Page Screenshot             ${TEST NAME}-{index}.png

Change Rate next period                 [Arguments]       ${price}              ${s_msg}
    click element                       xpath=//*[@class="radio"]//span[contains(.,"${price}")]
    wait until page contains            Ваш бюджет на рекламу ВКонтакте (₽/мес.)
    click element                       xpath=//span[@class="ng-binding"][contains(.,"Со следующего периода")]
    click element                       xpath=//span[@class="button button-green btn-big" and contains(.,"Активировать")]
    wait until page contains element    xpath=//div[@class="noty_message"]/span[contains(.,"${s_msg}")]
    Capture Page Screenshot             ${TEST NAME}-{index}.png

Change to rate success                  [Arguments]         ${s_msg}
    click element                       xpath=//span[@class="ng-binding"][contains(.,"Со следующего периода")]
    click element                       xpath=//span[@class="button button-green btn-big" and contains(.,"Активировать")]
    wait until page contains element    xpath=//div[@class="noty_message"]/span[contains(.,"${s_msg}")]
    Capture Page Screenshot             ${TEST NAME}-{index}.png


Error for chenging rate                 [Arguments]             ${e_msg}
    click element                       xpath=//span[@class="button button-green btn-big" and contains(.,"Активировать")]
    wait until page contains element    xpath=//div[@class="noty_message"]/span[contains(.,"${e_msg}")]
    reload page
    wait until element is visible       xpath=//span[@class="ng-binding dropdown-toggle"]
    click element                       xpath=//span[@class="ng-binding dropdown-toggle"]

Check rate and dicreasing balance       [Arguments]      ${agent}       ${balance}
    wait until element is visible       xpath=//div[@id="dropdown-tarif-data"]/div[contains(.,"${agent}")]/../div[contains(.,"${agent}")]
    wait until page contains element    xpath=//span[@class="ng-binding" and contains(.,"${balance}")]

Create Muss For VK

    wait until element is visible      xpath=//div[@class="field-TH" and contains(.,"Рекламная площадка")]/..//label[@class="radio"]
    click element                      xpath=//div[@class="field-TH" and contains(.,"Рекламная площадка")]/..//label[@class="radio"]
    wait until page contains           Вконтакте
    Wait Until Element Is Visible      xpath=//input[@name='title']
    Press Key                          name=title        Test Campaign for VK
    Capture Page Screenshot            ${TEST NAME}-{index}.png
    Click Element                      ${Campagins-submit}
    Wait Until Page Does Not Contain     Идет загрузка
    Go To                              ${URL_PROJECT}${project_number}/campaigns/
    Wait Until Page Contains             Все кампании


Change rates for advertisement
    wait until element is visible           xpath=(//div[@class="b-table__col"]//td[@class="b-table__td ng-scope"]//span[contains(.,"11.1")])[1]
    click element                           xpath=(//div[@class="b-table__col"]//td[@class="b-table__td ng-scope"]//span[contains(.,"11.1")])[1]
    wait until page contains                Ставка объявления
    wait until page contains                Сохранить
    clear element text                      xpath=(//div[@class="form-row"]/span[contains(.,"Ставка объявления")]/../input)[1]
    input text                              xpath=(//div[@class="form-row"]/span[contains(.,"Ставка объявления")]/../input)[1]                20
    click element                           xpath=(//div[@class="form-row"]/span[contains(.,"Ставка объявления")]/../../../div[@class="buttons"]/span[contains(.,"Сохранить")])[1]
    wait until page contains                Объявления были успешно обновлены
    wait until page contains element        xpath=(//div[@class="b-table__col"]//td[@class="b-table__td ng-scope"]//span[contains(.,"20")])[1]

Wait does not visible ajax loading
    wait until element does not contain         ${loading_ajax}       60

Change rates in settings
    wait until element is visible        name=price
    Clear Element Text                   name=price
    Press Key                            name=price        40
    Wait Until Element Is Not Visible    xpath=//span[@class='ajax-loader']
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Click Element                        ${Ad-Save}
    Wait No Overlay



Change rates in the advertisement block
    set selenium speed                      .1 sec
    wait until element is visible           xpath=(//tbody[@class="b-table__tbody"]//label[@class="checkbox"])[1]
    click element                           xpath=(//tbody[@class="b-table__tbody"]//label[@class="checkbox"])[1]
    wait until element is visible           xpath=(//div[@class="actions wrapper ng-scope"]//i[@uib-tooltip="Массовое редактирование лимитов и ставок"])[2]
    click element                           xpath=(//div[@class="actions wrapper ng-scope"]//i[@uib-tooltip="Массовое редактирование лимитов и ставок"])[2]
    wait until page contains                Массовое редактирование лимитов и ставок
    wait until element is visible           xpath=//*[@class="form-row ng-pristine ng-valid"]//span[@class="select-data ng-binding" and contains(.,"Увеличить")]
    click element                           xpath=//*[@class="form-row ng-pristine ng-valid"]//span[@class="select-data ng-binding" and contains(.,"Увеличить")]
    wait until element is visible           xpath=//*[@class="form-row ng-pristine ng-valid"]//div//span[contains(.,"Установить")]
    click element                           xpath=//*[@class="form-row ng-pristine ng-valid"]//div//span[contains(.,"Установить")]
    wait until page contains element        xpath=//*[@ng-show="mass_limits.operation == 'abs'" and contains(.,"Равным")]
    wait until element is visible           xpath=//*[@class="form-row ng-pristine ng-valid"]//input
    clear element text                      xpath=//*[@class="form-row ng-pristine ng-valid"]//input
    input text                              css=form > input.inp-text               60
    click element                           xpath=//*[@class="form-row ng-valid ng-dirty ng-valid-parse"]//span[@class="button button-green"]
    wait until page contains                Объявления были успешно обновлены
    wait until page contains element        xpath=(//div[@class="b-table__col"]//td[@class="b-table__td ng-scope"]//span[contains(.,"60")])[1]

Stopping project                            [Arguments]             ${st_project}

    Wait Until Element Is Visible        xpath=(//div[@class="td-name"]/a[contains(.,"${st_project}")]/..//span[contains(text(),'Запущен')])[1]
    Click Element                        xpath=(//div[@class="td-name"]/a[contains(.,"${st_project}")]/..//span[contains(text(),'Запущен')])[1]
    Wait Until Element Is Visible        xpath=//div[@class='select-options select-status dropdown-menu']//span[text()='Остановить']
    Click Element                        xpath=//div[@class='select-options select-status dropdown-menu']//span[text()='Остановить']
    Wait No Overlay
    Page Should Not Contain Element      xpath=//div[contains(@class,'noty_type_error')]
    Wait Until Element Is Visible        xpath=(//div[@class="td-name"]/a[contains(.,"${st_project}")]/..//span[contains(text(),'Остановлен')])[1]

Get Targeting                           [Arguments]                         ${targ}    ${type}   ${view}
    wait until element is visible       xpath=//div[@class="item ng-scope"]//h4[contains(.,"${targ}")]/../../../div//div[@ng-show="platform == 1"]/p[contains(.,"${type}")]/span[contains(.,"${view}")]

Click Project                                 [Arguments]                         ${project_muss_rk}
    wait until element is visible        xpath=//div[@class="b-table __projects ng-scope baron"]//div[@class="b-table__fixed"]//a[text()="${project_muss_rk}"]
    click element                        xpath=//div[@class="b-table __projects ng-scope baron"]//div[@class="b-table__fixed"]//a[text()="${project_muss_rk}"]