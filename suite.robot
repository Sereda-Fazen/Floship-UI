*** Settings ***
Documentation                           FloShip UI testing
Resource                                resource.robot
Suite Setup                             Setup Tests
Test Teardown                           Delete All Cookies
Suite Teardown                          Close All Browsers

*** Test Cases ***
Login and create new user
    [Tags]                               Login
    ${email}=                           Get Email Address
    Set Suite Variable                  ${REG_EMAIL}                ${email}
    Open Browser                        ${SERVER}    browser=${BROWSER}
    Set Window Size                     ${WIDTH}    ${HEIGHT}
    Login                               cutoreno@p33.org         qw1as2zx3po
    #Wait Until Page Contains            Login Successful
    Wait Until Page Contains            Floship Administration
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Wait Until Element Is Visible       ${Add user}
    click element                       ${Add user}
    Wait Until Page Contains            Send welcome email
    Input text                          name=email                  ${REG_EMAIL}
    Input text                          name=first_name             user_12345
    Click Element                       xpath=//input[@class="submit-row"]
    Wait Until Page Contains            User ${REG_EMAIL} is created
    log to console                      ${REG_EMAIL}
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Go To                               ${ADMIN}/logout
    Wait Until Page Contains            Thanks for spending some quality time with the Web site today.
    Capture Page Screenshot             ${TEST NAME}-{index}.png


#Reset Password
#    [Tags]                              ResetPass
#    Go To                               ${SERVER}
#    Wait Until Page Contains Element    xpath=//h3[contains(.,"Login")]
#    click Element                       xpath=//div[@class="form-group"]//a[contains(.,"Forgot")]
#    Wait Until Page Contains            Password reset
#    Input text                          name=email                     ${REG_EMAIL}
#    Click Button                        Reset my password
#    Wait Until Page Contains            Password reset sent
#    Capture Page Screenshot             ${TEST NAME}-{index}.png
#    ${res}=                             Wait Until Keyword Succeeds     3 min       5 sec          Check Mail   ${REG_EMAIL}    ${0}
#    ${link}=                            Get Mail link           ${res}
#    Go To                               ${link}
#
#    Reset Password                      Enter new password      ${reset_pass}       ${reset_pass}             Password reset complete
#    set suite variable                  ${REG PASS}             ${reset_pass}
#    Click Button                        Log in
#    Wait Until Page Contains Element    xpath=//h3[contains(.,"Login")]
#    Login                               gfgxojwop@doanart.com         qw1as2zx3po
#    wait until page contains            Login or password incorrect
#    Login                               gfgxojwop@doanart.com         ${REG PASS}
#    wait until element contains         Company Details
#    wait until element contains         Company Address







































#    Press Key                           name=first_name             ${First Name}
#    Capture Page Screenshot             ${TEST NAME}-{index}.png
#    Press Key                           name=phone                  ${Phone}
#    Press Key                           name=email                  ${email}
#    Press Key                           name=password               ${Password}
#    Capture Page Screenshot             ${TEST NAME}-{index}.png
#    Click Element                       name=accept_agreement
#    Capture Page Screenshot             ${TEST NAME}-{index}.png
#    Click Element                       ${Signup-submit}
#    Wait Until Page Contains            Пожалуйста, подтвердите ваш email.
#    Capture Page Screenshot             ${TEST NAME}-{index}.png
#    ${res}=                             Wait Until Keyword Succeeds     3 min       5 sec          Check Mail   ${email}    ${0}
#    ${link}=                            Get Mail link           ${res}
#    Go To                               ${link}
#    Wait Until Page Contains            Aккаунт успешно активирован!
#    Capture Page Screenshot             ${TEST NAME}-{index}.png
#    Click Element                       xpath=//span[text()='Добавить первого клиента']
#    Wait Until Page Contains            Создать новый проект
#    Capture Page Screenshot             ${TEST NAME}-{index}.png

Authorisation
    Start Virtual Display               ${WIDTH}    ${HEIGHT}
    ${email}=                           Get Email Address
    Open Browser                        ${URL_START}   browser=${BROWSER}
    Set Window Size                     ${WIDTH}    ${HEIGHT}
    Click Element                       ${Login}
    Wait Until Element Is Visible       ${Login-modal}
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Press Key                           name=username             ${REG_EMAIL}
    Press Key                           name=password             ${Password}
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Click Element                       ${Login-submit}
    Wait Until Page Contains            Все проекты
    Capture Page Screenshot             ${TEST NAME}-{index}.png

Password Recovery
    Start Virtual Display               ${WIDTH}    ${HEIGHT}
    ${email}=                           Get Email Address
    Open Browser                        ${URL_START}   browser=${BROWSER}
    Set Window Size                     ${WIDTH}    ${HEIGHT}
    Click Element                       ${Login}
    Wait Until Element Is Visible       ${Login-modal}
    Click Element                       ${Login-password}
    Wait Until Element Is Visible       ${Password-modal}
    Press Key                           name=email             ${REG_EMAIL}
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Click Element                       ${Password-submit}
    Wait Until Page Contains            Новый пароль был отправлен Вам по электронной почте
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    ${res}=                             Wait Until Keyword Succeeds     3 min       5 sec      Get Mail By Subject   ${REG_EMAIL}    Восстановить пароль на вашу учетную запись на hiconversion.ru
    ${password}=                        Get Password                        ${res}
    Set Suite Variable                  ${REG_PASSWORD}                ${password}
    Wait Until Element Is Visible       ${Login-modal}
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Press Key                           name=username             ${REG_EMAIL}
    Press Key                           name=password             ${REG_PASSWORD}
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Click Element                       ${Login-submit}
    Wait Until Page Contains            Все проекты
    Capture Page Screenshot             ${TEST NAME}-{index}.png

Edit account data
    Start Virtual Display               ${WIDTH}    ${HEIGHT}
    ${email}=                           Get Email Address
    Open Browser                        ${URL_START}   browser=${BROWSER}
    Set Window Size                     ${WIDTH}    ${HEIGHT}
    Click Element                       ${Login}
    Wait Until Element Is Visible       ${Login-modal}
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Press Key                           name=username             ${REG_EMAIL}
    Press Key                           name=password             ${REG_PASSWORD}
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Click Element                       ${Login-submit}
    Wait Until Page Contains            Все проекты
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Go To                               ${URL_EDIT_ACCOUNT}
    Wait Until Element Is Visible       ${Account_Edit-submit-dis}
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Sleep                               1
    Clear Element Text                  name=first_name
    Press Key                           name=first_name            New_name
    Sleep                               1
    Clear Element Text                  name=last_name
    Press Key                           name=last_name             New_last_name
    Sleep                               1
    Clear Element Text                  name=phone
    Press Key                           name=phone                 +1000123123
    Sleep                               1
    Clear Element Text                  name=password
    Press Key                           name=password              ${REG_PASSWORD}
    Clear Element Text                  name=new_password
    Press Key                           name=new_password               ${Password}
    Clear Element Text                  name=new_password_confirm
    Press Key                           name=new_password_confirm       ${Password}
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Wait Until Page Does Not Contain Element                        ${Account_Edit-submit-dis}
    Click Element                       ${Account_Edit-submit}
    Wait Until Page Contains            Успешное редактирование персональных данных
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Reload Page
    Wait Until Page Contains            New_name
    Page Should Contain                 New_last_name

Create Client Project
    Start Virtual Display                ${WIDTH}    ${HEIGHT}
    ${email}=                            Get Email Address
    Open Browser                         ${URL_START}   browser=${BROWSER}
    Set Window Size                      ${WIDTH}    ${HEIGHT}
    Click Element                        ${Login}
    Wait Until Element Is Visible        ${Login-modal}
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Press Key                            name=username             ${REG_EMAIL}
    Press Key                            name=password             ${Password}
    Click Element                        ${Login-submit}
    Wait Until Page Contains             Все проекты
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Click Element                        ${Add_project}
    Wait Until Page Contains             Создание нового проекта
    Clear Element Text                   ${Cr_Project-title}
    Press Key                            ${Cr_Project-title}             Тестовый проект 1
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Click Element                        ${Cr_Project-submit}
    Wait No Overlay
    Wait Until Page Contains             Проект успешно создан
    Wait Until Page Contains             Тестовый проект 1
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Go To                                ${URL_PROJECTS}
    Wait Until Page Contains             Все проекты
    Wait Until Page Contains             Тестовый проект 1
    Capture Page Screenshot              ${TEST NAME}-{index}.png

Add payment to Client project
    Start Virtual Display               ${WIDTH}    ${HEIGHT}
    ${email}=                           Get Email Address
    Open Browser                        ${URL_START}   browser=${BROWSER}
    Set Window Size                     ${WIDTH}    ${HEIGHT}
    Click Element                       ${Login}
    Wait Until Element Is Visible       ${Login-modal}
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Press Key                           name=username             ${REG_EMAIL}
    Press Key                           name=password             ${Password}
    Click Element                       ${Login-submit}
    Wait Until Page Contains            Все проекты
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    ${project_number}=                  Get Project Number                  Тестовый проект 1
    Go To                               ${URL_PAYMENT}
    Wait Until Page Contains            Пополнение счета
    Wait No Overlay
    Click Element                       ${Payment_submit}
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    ${bill}=                            Get Bill Number
    Go To                               ${URL_SIGNOUT}
    Admin Login
    Approve payment                     ${bill}
    Go To                               ${URL_ADMIN_SIGNOUT}
    Go To                               ${URL_START}
    Click Element                       ${Login}
    Wait Until Element Is Visible       ${Login-modal}
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Press Key                           name=username             ${REG_EMAIL}
    Press Key                           name=password             ${Password}
    Click Element                       ${Login-submit}
    Wait Until Page Contains            Все проекты
    Page Should Contain                 9900 ₽
    Add Balance                         ${project_number}       tm      1000
    Click Element                       ${Balance-dropdown}
    Wait Until Element Is Visible       xpath=//label[contains(., 'Доступный остаток:')]/following-sibling::div[contains(., '8720')]
    Wait Until Element Is Visible       xpath=//label[contains(., 'На балансе проектов:')]/following-sibling::div[contains(., '1180')]

Start project
    Start Virtual Display               ${WIDTH}    ${HEIGHT}
    Open Browser                        ${URL_START}   browser=${BROWSER}
    Set Window Size                     ${WIDTH}    ${HEIGHT}
    Click Element                       ${Login}
    Wait Until Element Is Visible       ${Login-modal}
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Press Key                           name=username             ${REG_EMAIL}
    Press Key                           name=password             ${Password}
    Click Element                       ${Login-submit}
    Wait Until Page Contains            Все проекты
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Start Project                       Тестовый проект 1
    Capture Page Screenshot             ${TEST NAME}-{index}.png

Add campagins TM
    Start Virtual Display                ${WIDTH}    ${HEIGHT}
    Open Browser                         ${URL_START}   browser=${BROWSER}
    Set Window Size                      ${WIDTH}    ${HEIGHT}
    Click Element                        ${Login}
    Wait Until Element Is Visible        ${Login-modal}
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Press Key                            name=username             ${REG_EMAIL}
    Press Key                            name=password             ${Password}
    Click Element                        ${Login-submit}
    Wait Until Page Contains             Все проекты
    ${project_number}=                   Get Project Number                  Тестовый проект 1
    Go To                                ${URL_PROJECT}${project_number}/campaign/create/
    Wait Until Page Contains             Создание кампании
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Wait No Overlay
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Wait Until Element Is Visible        xpath=//input[@name='title']
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Select dropdown                      Пол                                 Мужской
    Select dropdown                      Возрастные ограничения              18+
    Set Target Age                       20
    Click target checkbox                Россия
    Click target checkbox                Авто
    Select multi dropdown                Телезрители                         Мало смотрят телевизо
    Select multi dropdown                Образование                         Есть высшее образование
    Clear Element Text                   name=title
    Focus                                name=title
    Press Key                            name=title        Т
    Press Key                            name=title        e
    Press Key                            name=title        cтовая кампания 1
    Sleep                                2
    Clear Element Text                   name=price
    Press Key                            name=price        10.1
    Wait Until Element Is Not Visible    xpath=//span[@class='ajax-loader']
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Click Element                        ${Campagins-submit}
    Wait Until Page Does Not Contain     Идет загрузка
    Go To                                ${URL_PROJECT}${project_number}/campaigns/
    Wait Until Page Contains             Все кампании
    ${text}=                             Get Campagin Cell                    Теcтовая кампания 1               Таргетинги
    Should Contain                       ${text}                              Пол: Мужской
    Should Contain                       ${text}                              Возраст: от 20 до 29
    Should Contain                       ${text}                              Возрастное ограничение: 18+
    Should Contain                       ${text}                              Россия
    Should Contain                       ${text}                              Авто
    Should Contain                       ${text}                              Мало смотрят телевизор
    Should Contain                       ${text}                              Есть высшее образование
    Should Contain                       ${text}                              время и дни показа: Все
    ${text}=                             Get Campagin Cell                    Тecтовая кампания 1               Cтавка
    Should Contain                       ${text}                              10.1
    Go To                                ${URL_PROJECT}${project_number}/campaign/create/
    Wait Until Page Contains             Создание кампании
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Wait No Overlay
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Wait Until Element Is Visible        xpath=//input[@name='title']
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Select dropdown                      Пол                                 Мужской
    Select dropdown                      Возрастные ограничения              18+
    Set Target Age                       20
    Click target checkbox                Россия
    Click target checkbox                Авто
    Select multi dropdown                Телезрители                         Мало смотрят телевизо
    Select multi dropdown                Образование                         Есть высшее образование
    Clear Element Text                   name=title
    Focus                                name=title
    Press Key                            name=title        Т
    Press Key                            name=title        e
    Press Key                            name=title        cтовая кампания 2
    Sleep                                2
    Clear Element Text                   name=price
    Press Key                            name=price        11.1
    Wait Until Element Is Not Visible    xpath=//span[@class='ajax-loader']
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Click Element                        ${Campagins-submit}
    Wait Until Page Does Not Contain     Идет загрузка
    Go To                                ${URL_PROJECT}${project_number}/campaigns/
    Wait Until Page Contains             Все кампании
    ${text}=                             Get Campagin Cell                    Теcтовая кампания 2               Таргетинги
    Should Contain                       ${text}                              Пол: Мужской
    Should Contain                       ${text}                              Возраст: от 20 до 29
    Should Contain                       ${text}                              Возрастное ограничение: 18+
    Should Contain                       ${text}                              Россия
    Should Contain                       ${text}                              Авто
    Should Contain                       ${text}                              Мало смотрят телевизор
    Should Contain                       ${text}                              Есть высшее образование
    Should Contain                       ${text}                              время и дни показа: Все
    ${text}=                             Get Campagin Cell                    Тecтовая кампания 2               Cтавка
    Should Contain                       ${text}                              11.1

Add campagin VK
    Start Virtual Display                ${WIDTH}    ${HEIGHT}
    Open Browser                         ${URL_START}   browser=${BROWSER}
    Set Window Size                      ${WIDTH}    ${HEIGHT}
    Click Element                        ${Login}
    Wait Until Element Is Visible        ${Login-modal}
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Press Key                            name=username             ${REG_EMAIL}
    Press Key                            name=password             ${Password}
    Click Element                        ${Login-submit}
    Wait Until Page Contains             Все проекты
    ${project_number}=                   Get Project Number                  Тестовый проект 1
    Go To                                ${URL_PROJECT}${project_number}/campaign/create/
    Wait Until Page Contains             Создание кампании
    Wait No Overlay
    Wait Until Element Is Visible        xpath=//input[@name='title']
    Click Element                        xpath=//button[@class='soc-btn-social soc-btn-vk']
    Wait No Overlay
    Wait Until Element Is Visible        xpath=//input[@name='title']
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Clear Element Text                   name=title
    Focus                                name=title
    Press Key                            name=title        Т
    Press Key                            name=title        e
    Press Key                            name=title        cтовая кампания 3
    Wait Until Element Is Not Visible    xpath=//span[@class='ajax-loader']
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Click Element                        ${Campagins-submit}
    Wait Until Page Does Not Contain     Идет загрузка
    Go To                                ${URL_PROJECT}${project_number}/campaigns/
    Wait Until Page Contains             Все кампании

Edit campagin
    Start Virtual Display                ${WIDTH}    ${HEIGHT}
    Open Browser                         ${URL_START}   browser=${BROWSER}
    Set Window Size                      ${WIDTH}    ${HEIGHT}
    Click Element                        ${Login}
    Wait Until Element Is Visible        ${Login-modal}
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Press Key                            name=username             ${REG_EMAIL}
    Press Key                            name=password             ${Password}
    Click Element                        ${Login-submit}
    Wait Until Page Contains             Все проекты
    ${project_number}=                   Get Project Number                  Тестовый проект 1
    ${campagin_number}=                  Get Campagin Number                 ${project_number}          Тecтовая кампания 1
    Go To                                ${URL_CAMPAGIN}${campagin_number}/settings/
    Wait Until Page Contains             Тecтовая кампания 1
    Wait No Overlay
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Wait Until Element Is Visible        xpath=//input[@name='title']
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Select dropdown                      Пол                                 Женский
    Set Target Age                       30
    Click target checkbox                Бывший СССР
    Click target checkbox                Бизнес
    Select multi dropdown                Телезрители                         Средне смотрят телевизор
    Select multi dropdown                Занятость                           Не работает
    Clear Element Text                   name=title
    Focus                                name=title
    Press Key                            name=title        Т
    Press Key                            name=title        e
    Press Key                            name=title        cтовая кумпания 1
    Sleep                                2
    Clear Element Text                   name=price
    Press Key                            name=price        12.1
    Wait Until Element Is Not Visible    xpath=//span[@class='ajax-loader']
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Click Element                        ${Campagins-save}
    Wait Until Page Does Not Contain     Идет загрузка
    Go To                                ${URL_PROJECT}${project_number}/campaigns/
    Wait Until Page Contains             Все кампании
    ${text}=                             Get Campagin Cell                    Тecтовая кумпания 1               Таргетинги
    Should Contain                       ${text}                              Пол: Женский
    Should Contain                       ${text}                              Возраст: от 30 до 39
    Should Contain                       ${text}                              Возрастное ограничение: 18+
    Should Contain                       ${text}                              Бывший СССР
    Should Contain                       ${text}                              Россия
    Should Contain                       ${text}                              Авто
    Should Contain                       ${text}                              Бизнес
    Should Contain                       ${text}                              Средне смотрят телевизор
    Should Contain                       ${text}                              Мало смотрят телевизор
    Should Contain                       ${text}                              Образование: Есть высшее образование
    Should Contain                       ${text}                              Занятость: Не работает
    Should Contain                       ${text}                              время и дни показа: Все
    ${text}=                             Get Campagin Cell                    Тecтовая кумпания 1               Cтавка
    Should Contain                       ${text}                              12.1

Start campagin TM
    Start Virtual Display                ${WIDTH}    ${HEIGHT}
    Open Browser                         ${URL_START}   browser=${BROWSER}
    Set Window Size                      ${WIDTH}    ${HEIGHT}
    Click Element                        ${Login}
    Wait Until Element Is Visible        ${Login-modal}
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Press Key                            name=username             ${REG_EMAIL}
    Press Key                            name=password             ${Password}
    Click Element                        ${Login-submit}
    Wait Until Page Contains             Все проекты
    ${project_number}=                   Get Project Number                  Тестовый проект 1
    Go To                                ${URL_PROJECT}${project_number}/campaigns/
    Wait Until Page Contains             Все кампании
    Wait Until Page Does Not Contain     Идет загрузка
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Start Campagin                       Тecтовая кумпания 1
    Capture Page Screenshot              ${TEST NAME}-{index}.png

Mass Edit Campagins Rate
    Start Virtual Display                ${WIDTH}    ${HEIGHT}
    Open Browser                         ${URL_START}   browser=${BROWSER}
    Set Window Size                      ${WIDTH}    ${HEIGHT}
    Click Element                        ${Login}
    Wait Until Element Is Visible        ${Login-modal}
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Press Key                            name=username             ${REG_EMAIL}
    Press Key                            name=password             ${Password}
    Click Element                        ${Login-submit}
    Wait Until Page Contains             Все проекты
    ${project_number}=                   Get Project Number                  Тестовый проект 1
    Go To                                ${URL_PROJECT}${project_number}/campaigns/
    Wait Until Page Contains             Все кампании
    Select Campagin                      Тecтовая кумпания 1
    Select Campagin                      Тecтовая кампания 2
    Click Element                        xpath=//i[@uib-tooltip='Редактировать кампании']
    Wait Until Page Contains             Массовое редактирование кампаний
    Wait No Overlay
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Wait Until Element Is Visible        xpath=//input[@name='title']
    Clear Element Text                   name=price
    Press Key                            name=price        19.1
    Wait Until Element Is Not Visible    xpath=//span[@class='ajax-loader']
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Click Element                        ${Campagins-save}
    Wait Until Page Does Not Contain     Идет загрузка
    Go To                                ${URL_PROJECT}${project_number}/campaigns/
    Wait Until Page Contains             Все кампании
    Wait Until Page Does Not Contain     Идет загрузка
    ${text}=                             Get Campagin Cell                    Тecтовая кумпания 1               Cтавка
    Should Contain                       ${text}                              19.1
    ${text}=                             Get Campagin Cell                    Тecтовая кампания 2               Cтавка
    Should Contain                       ${text}                              19.1

Change single campagin limit
    Start Virtual Display                ${WIDTH}    ${HEIGHT}
    Open Browser                         ${URL_START}   browser=${BROWSER}
    Set Window Size                      ${WIDTH}    ${HEIGHT}
    Click Element                        ${Login}
    Wait Until Element Is Visible        ${Login-modal}
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Press Key                            name=username             ${REG_EMAIL}
    Press Key                            name=password             ${Password}
    Click Element                        ${Login-submit}
    Wait Until Page Contains             Все проекты
    ${project_number}=                   Get Project Number                   Тестовый проект 1
    Go To                                ${URL_PROJECT}${project_number}/campaigns/
    Wait Until Page Contains             Все кампании
    Wait Until Page Does Not Contain     Идет загрузка
    Set Campagin Limit                   Тecтовая кумпания 1                  500
    ${text}=                             Get Campagin Cell                    Тecтовая кумпания 1               Общий лимит
    Should Contain                       ${text}                              500
    Capture Page Screenshot              ${TEST NAME}-{index}.png

Change single campagin daily limit
    Start Virtual Display                ${WIDTH}    ${HEIGHT}
    Open Browser                         ${URL_START}   browser=${BROWSER}
    Set Window Size                      ${WIDTH}    ${HEIGHT}
    Click Element                        ${Login}
    Wait Until Element Is Visible        ${Login-modal}
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Press Key                            name=username             ${REG_EMAIL}
    Press Key                            name=password             ${Password}
    Click Element                        ${Login-submit}
    Wait Until Page Contains             Все проекты
    ${project_number}=                   Get Project Number                   Тестовый проект 1
    Go To                                ${URL_PROJECT}${project_number}/campaigns/
    Wait Until Page Contains             Все кампании
    Set Campagin Daily Limit             Тecтовая кумпания 1                  500
    ${text}=                             Get Text                             xpath=//div[@class='b-table __campaigns ng-scope']//table//tr[position()=count(//div[@class='b-table __campaigns ng-scope']//td[contains(.,'Тecтовая кумпания 1')]/parent::*/preceding-sibling::*)+1]/td[@ng-if='views.campaigns.limit_day']
    Should Contain                       ${text}                              500
    Capture Page Screenshot              ${TEST NAME}-{index}.png

Change multi campagin limits
    Start Virtual Display                ${WIDTH}    ${HEIGHT}
    Open Browser                         ${URL_START}   browser=${BROWSER}
    Set Window Size                      ${WIDTH}    ${HEIGHT}
    Click Element                        ${Login}
    Wait Until Element Is Visible        ${Login-modal}
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Press Key                            name=username             ${REG_EMAIL}
    Press Key                            name=password             ${Password}
    Click Element                        ${Login-submit}
    Wait Until Page Contains             Все проекты
    ${project_number}=                   Get Project Number                   Тестовый проект 1
    Go To                                ${URL_PROJECT}${project_number}/campaigns/
    Wait Until Page Contains             Все кампании
    Select Campagin                      Тecтовая кумпания 1
    Select Campagin                      Тecтовая кампания 2
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Edit Multiple Rates Limits           Установить         Ставка         100
    ${text}=                             Get Campagin Cell                    Тecтовая кумпания 1               Cтавка
    Should Contain                       ${text}                              100
    ${text}=                             Get Campagin Cell                    Тecтовая кампания 2               Cтавка
    Should Contain                       ${text}                              100

Change single campagin rate
    Start Virtual Display                ${WIDTH}    ${HEIGHT}
    Open Browser                         ${URL_START}   browser=${BROWSER}
    Set Window Size                      ${WIDTH}    ${HEIGHT}
    Click Element                        ${Login}
    Wait Until Element Is Visible        ${Login-modal}
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Press Key                            name=username             ${REG_EMAIL}
    Press Key                            name=password             ${Password}
    Click Element                        ${Login-submit}
    Wait Until Page Contains             Все проекты
    ${project_number}=                   Get Project Number                   Тестовый проект 1
    Go To                                ${URL_PROJECT}${project_number}/campaigns/
    Wait Until Page Contains             Все кампании
    Wait Until Page Does Not Contain     Идет загрузка
    Set Campagin Rate                    Тecтовая кумпания 1                  50
    ${text}=                             Get Campagin Cell                    Тecтовая кумпания 1               Cтавка
    Should Contain                       ${text}                              50

Add advertisment
    Start Virtual Display                ${WIDTH}    ${HEIGHT}
    Open Browser                         ${URL_START}   browser=${BROWSER}
    Set Window Size                      ${WIDTH}    ${HEIGHT}
    Click Element                        ${Login}
    Wait Until Element Is Visible        ${Login-modal}
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Press Key                            name=username             ${REG_EMAIL}
    Press Key                            name=password             ${Password}
    Click Element                        ${Login-submit}
    Wait Until Page Contains             Все проекты
    ${project_number}=                   Get Project Number                  Тестовый проект 1
    ${campagin_number}=                  Get Campagin Number                 ${project_number}          Тecтовая кумпания 1
    Go To                                ${URL_CAMPAGIN}${campagin_number}/ad/new/
    Wait Until Page Contains             Создание объявления
    Wait No Overlay
    Wait Until Element Is Visible        name=url
    Focus                                name=url
    Press Key                            name=url                  ya.ru
    Focus                                name=header
    Press Key                            name=header               Тес
    Press Key                            name=header               товый Заголовок
    Focus                                name=body
    Press Key                            name=body                 Тестовый Текст
    Focus                                name=title
    Press Key                            name=title                Test AD
    Choose File                          css=.leupload             ${CURDIR}/90-75.jpg
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Wait Until Element Is Visible        xpath=//div[@id='dropdown-edit-crop-image']//div[contains(@class, 'popup-body')]
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Click Element                        xpath=//div[@id='dropdown-edit-crop-image']//button
    Wait Until Element Is Not Visible    xpath=//div[@id='dropdown-edit-crop-image']//div[contains(@class, 'popup-body')]
    Click Element                        ${Ad-Create}
    Wait No Overlay
    Wait Until Page Does Not Contain     Идет загрузка
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Go To                                ${URL_CAMPAGIN}${campagin_number}/ads/
    Wait Until Page Contains             Все объявления
    Wait Until Page Does Not Contain     Идет загрузка
    Wait Until Element Is Visible        xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='Test AD']/../preceding-sibling::div[@class='thumbl ng-scope']/div[@class='img-place']
    Mouse Over                           xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='Test AD']/../preceding-sibling::div[@class='thumbl ng-scope']/div[@class='img-place']
    Wait Until Page Contains             Тестовый Заголовок
    Wait Until Page Contains             Тестовый Текст
    Capture Page Screenshot              ${TEST NAME}-{index}.png

Edit advertisment
    Start Virtual Display                ${WIDTH}    ${HEIGHT}
    Open Browser                         ${URL_START}   browser=${BROWSER}
    Set Window Size                      ${WIDTH}    ${HEIGHT}
    Click Element                        ${Login}
    Wait Until Element Is Visible        ${Login-modal}
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Press Key                            name=username             ${REG_EMAIL}
    Press Key                            name=password             ${Password}
    Click Element                        ${Login-submit}
    Wait Until Page Contains             Все проекты
    ${project_number}=                   Get Project Number                  Тестовый проект 1
    ${campagin_number}=                  Get Campagin Number                 ${project_number}          Тecтовая кумпания 1
    ${ad_number}=                        Get Ad Number                       ${campagin_number}         Test AD
    Go To                                ${URL_AD}${ad_number}
    Wait Until Page Contains             Тестовый Заголовок
    Wait No Overlay
    Wait Until Element Is Visible        name=url
    Clear Element Text                   name=url
    Focus                                name=url
    Press Key                            name=url                  yandex.ru
    Clear Element Text                   name=header
    Focus                                name=header
    Press Key                            name=header               Тес
    Press Key                            name=header               товый Зыголовок
    Clear Element Text                   name=body
    Focus                                name=body
    Press Key                            name=body                 Тестовый Тыкст
    Clear Element Text                   name=title
    Focus                                name=title
    Press Key                            name=title                Test ADV
    Choose File                          css=.leupload             ${CURDIR}/90-75-2.jpg
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Wait Until Element Is Visible        xpath=//div[@id='dropdown-edit-crop-image']//div[contains(@class, 'popup-body')]
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Click Element                        xpath=//div[@id='dropdown-edit-crop-image']//button
    Wait Until Element Is Not Visible    xpath=//div[@id='dropdown-edit-crop-image']//div[contains(@class, 'popup-body')]
    Click Element                        ${Ad-Save}
    Wait No Overlay
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Go To                                ${URL_CAMPAGIN}${campagin_number}/ads/
    Wait Until Page Contains             Все объявления
    Wait Until Page Does Not Contain     Идет загрузка
    Wait Until Element Is Visible        xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='Test ADV']/../preceding-sibling::div[@class='thumbl ng-scope']/div[@class='img-place']
    Mouse Over                           xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='Test ADV']/../preceding-sibling::div[@class='thumbl ng-scope']/div[@class='img-place']
    Wait Until Page Contains             Тестовый Зыголовок
    Wait Until Page Contains             Тестовый Тыкст
    Capture Page Screenshot              ${TEST NAME}-{index}.png

Add VK advertisments
    Start Virtual Display                ${WIDTH}    ${HEIGHT}
    Open Browser                         ${URL_START}   browser=${BROWSER}
    Set Window Size                      ${WIDTH}    ${HEIGHT}
    Click Element                        ${Login}
    Wait Until Element Is Visible        ${Login-modal}
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Press Key                            name=username             ${REG_EMAIL}
    Press Key                            name=password             ${Password}
    Click Element                        ${Login-submit}
    Wait Until Page Contains             Все проекты
    ${project_number}=                   Get Project Number                  Тестовый проект 1
    ${campagin_number}=                  Get Campagin Number                 ${project_number}          Тecтовая кампания 3
    Go To                                ${URL_CAMPAGIN}${campagin_number}/ad/new/
    Wait Until Page Contains             Создание объявления
    Wait No Overlay
    Wait Until Element Is Visible        name=url
    Select Ad Dropdown                   Что рекламируем           Внешний ресурс (сайт)
    Wait No Overlay
    Focus                                name=url
    Press Key                            name=url                  ya.ru
    Focus                                name=header
    Press Key                            name=header               Тес
    Press Key                            name=header               товый Заголовок
    Focus                                name=body
    Press Key                            name=body                 Тестовый Текст
    Focus                                name=title
    Press Key                            name=title                Test AD1
    Choose File                          css=.leupload             ${CURDIR}/145-85.jpg
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Wait Until Element Is Visible        xpath=//div[@id='dropdown-edit-crop-image']//div[contains(@class, 'popup-body')]
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Click Element                        xpath=//div[@id='dropdown-edit-crop-image']//button
    Wait Until Element Is Not Visible    xpath=//div[@id='dropdown-edit-crop-image']//div[contains(@class, 'popup-body')]
    Select Ad Theme                      Тематика 1                 Авто/мото
    Clear Element Text                   name=price
    Press Key                            name=price        12.1
    Click Element                        ${Ad-Create}
    Wait No Overlay
    Wait Until Page Does Not Contain     Идет загрузка
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Go To                                ${URL_CAMPAGIN}${campagin_number}/ads/
    Wait Until Page Contains             Все объявления
    Wait Until Page Does Not Contain     Идет загрузка
    Wait Until Element Is Visible        xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='Test AD1']/../preceding-sibling::div[@class='thumbl ng-scope']/div[@class='img-place']
    Mouse Over                           xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='Test AD1']/../preceding-sibling::div[@class='thumbl ng-scope']/div[@class='img-place']
    Wait Until Page Contains             Тестовый Заголовок
    Wait Until Page Contains             Тестовый Текст
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Go To                                ${URL_CAMPAGIN}${campagin_number}/ad/new/
    Wait Until Page Contains             Создание объявления
    Wait No Overlay
    Wait Until Element Is Visible        name=url
    Select Ad Dropdown                   Что рекламируем           Внешний ресурс (сайт)
    Wait No Overlay
    Focus                                name=url
    Press Key                            name=url                  ya1.ru
    Focus                                name=header
    Press Key                            name=header               Тес
    Press Key                            name=header               товый Заголовок 2
    Focus                                name=body
    Press Key                            name=body                 Тестовый Текст 2
    Focus                                name=title
    Press Key                            name=title                Test AD2
    Choose File                          css=.leupload             ${CURDIR}/145-85.jpg
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Wait Until Element Is Visible        xpath=//div[@id='dropdown-edit-crop-image']//div[contains(@class, 'popup-body')]
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Click Element                        xpath=//div[@id='dropdown-edit-crop-image']//button
    Wait Until Element Is Not Visible    xpath=//div[@id='dropdown-edit-crop-image']//div[contains(@class, 'popup-body')]
    Select Ad Theme                      Тематика 1                 Авто/мото
    Clear Element Text                   name=price
    Press Key                            name=price        11.1
    Click Element                        ${Ad-Create}
    Wait No Overlay
    Wait Until Page Does Not Contain     Идет загрузка
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Go To                                ${URL_CAMPAGIN}${campagin_number}/ads/
    Wait Until Page Contains             Все объявления
    Wait Until Page Does Not Contain     Идет загрузка
    Wait Until Element Is Visible        xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='Test AD2']/../preceding-sibling::div[@class='thumbl ng-scope']/div[@class='img-place']
    Mouse Over                           xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='Test AD2']/../preceding-sibling::div[@class='thumbl ng-scope']/div[@class='img-place']
    Wait Until Page Contains             Тестовый Заголовок 2
    Wait Until Page Contains             Тестовый Текст 2
    Capture Page Screenshot              ${TEST NAME}-{index}.png

Edit VK Advertisment Rate
    Start Virtual Display                ${WIDTH}    ${HEIGHT}
    Open Browser                         ${URL_START}   browser=${BROWSER}
    Set Window Size                      ${WIDTH}    ${HEIGHT}
    Click Element                        ${Login}
    Wait Until Element Is Visible        ${Login-modal}
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Press Key                            name=username             ${REG_EMAIL}
    Press Key                            name=password             ${Password}
    Click Element                        ${Login-submit}
    Wait Until Page Contains             Все проекты
    ${project_number}=                   Get Project Number                  Тестовый проект 1
    ${campagin_number}=                  Get Campagin Number                 ${project_number}          Тecтовая кампания 3
    ${ad_number}=                        Get Ad Number                       ${campagin_number}         Test AD1
    Go To                                ${URL_AD}${ad_number}
    Wait Until Page Contains             Тестовый Заголовок
    Wait No Overlay
    Wait Until Element Is Visible        name=url
    Wait Until Element Is Visible        name=url
    Clear Element Text                   name=price
    Press Key                            name=price        13.5
    Click Element                        ${Ad-Save}
    Wait No Overlay
    Go To                                ${URL_CAMPAGIN}${campagin_number}/ads/
    Wait No Overlay
    Wait Until Page Does Not Contain     Идет загрузка
    ${text}=                             Get Ad Cell                    Test AD1               Ставка
    Should Contain                       ${text}                              13.5

Mass Edit VK Advertisment Rate
    Start Virtual Display                ${WIDTH}    ${HEIGHT}
    Open Browser                         ${URL_START}   browser=${BROWSER}
    Set Window Size                      ${WIDTH}    ${HEIGHT}
    Click Element                        ${Login}
    Wait Until Element Is Visible        ${Login-modal}
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Press Key                            name=username             ${REG_EMAIL}
    Press Key                            name=password             ${Password}
    Click Element                        ${Login-submit}
    Wait Until Page Contains             Все проекты
    ${project_number}=                   Get Project Number                  Тестовый проект 1
    ${campagin_number}=                  Get Campagin Number                 ${project_number}          Тecтовая кампания 3
    Go To                                ${URL_CAMPAGIN}${campagin_number}/ads/
    Wait Until Page Contains             Все объявления
    Wait Until Page Does Not Contain     Идет загрузка
    Select Ad                            Test AD1
    Select Ad                            Test AD2
    Wait Until Element Is Visible        xpath=//i[@uib-tooltip='Редактировать объявления']
    Click Element                        xpath=//i[@uib-tooltip='Редактировать объявления']
    Wait Until Page Contains             Массовое редактирование объявлений
    Wait No Overlay
    Wait Until Element Is Visible        name=url
    Clear Element Text                   name=price
    Press Key                            name=price        12.5
    Click Element                        ${Ad-Save}
    Wait No Overlay
    Wait Until Page Does Not Contain     Идет загрузка
    ${text}=                             Get Ad Cell                    Test AD1               Ставка
    Should Contain                       ${text}                              12.5
    ${text}=                             Get Ad Cell                    Test AD2               Ставка
    Should Contain                       ${text}                              12.5

Start Ad and Stop in Editor
    Start Virtual Display                ${WIDTH}    ${HEIGHT}
    Open Browser                         ${URL_START}   browser=${BROWSER}
    Set Window Size                      ${WIDTH}    ${HEIGHT}
    Click Element                        ${Login}
    Wait Until Element Is Visible        ${Login-modal}
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Press Key                            name=username             ${REG_EMAIL}
    Press Key                            name=password             ${Password}
    Click Element                        ${Login-submit}
    Wait Until Page Contains             Все проекты
    ${project_number}=                   Get Project Number                  Тестовый проект 1
    ${campagin_number}=                  Get Campagin Number                 ${project_number}          Тecтовая кумпания 1
    ${ad_number}=                        Get Ad Number                       ${campagin_number}         Test ADV
    Go To                                ${URL_CAMPAGIN}${campagin_number}/ads/
    Wait Until Page Contains             Все кампании
    Wait Until Page Does Not Contain     Идет загрузка
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Start Ad                             Test ADV
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Go To                                ${URL_AD}${ad_number}
    Wait Until Page Contains             Тестовый Зыголовок
    Wait No Overlay
    Select dropdown                      Статус объявления в системе                                 Остановлено
    Click Element                        ${Ad-Save}
    Wait No Overlay
    Go To                                ${URL_CAMPAGIN}${campagin_number}/ads/
    Wait Until Page Contains             Все объявления
    Wait Until Page Does Not Contain     Идет загрузка
    Wait Until Element Is Visible        xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='Test ADV']/../following-sibling::*/div[contains(text(),'Новое')]


Start in editor and Stop Ad
    Start Virtual Display                ${WIDTH}    ${HEIGHT}
    Open Browser                         ${URL_START}   browser=${BROWSER}
    Set Window Size                      ${WIDTH}    ${HEIGHT}
    Click Element                        ${Login}
    Wait Until Element Is Visible        ${Login-modal}
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Press Key                            name=username             ${REG_EMAIL}
    Press Key                            name=password             ${Password}
    Click Element                        ${Login-submit}
    Wait Until Page Contains             Все проекты
    ${project_number}=                   Get Project Number                  Тестовый проект 1
    ${campagin_number}=                  Get Campagin Number                 ${project_number}          Тecтовая кумпания 1
    ${ad_number}=                        Get Ad Number                       ${campagin_number}         Test ADV
    Go To                                ${URL_AD}${ad_number}
    Wait Until Page Contains             Тестовый Зыголовок
    Wait No Overlay
    Select dropdown                      Статус объявления в системе                                 Запущено
    Click Element                        ${Ad-Save}
    Wait No Overlay
    Go To                                ${URL_CAMPAGIN}${campagin_number}/ads/
    Wait Until Page Contains             Все объявления
    Wait Until Page Does Not Contain     Идет загрузка
    Wait Until Element Is Visible        xpath=//div[@class='b-table __ads ng-scope']//span[@ng-if='ad.title' and text()='Test ADV']/../following-sibling::*/div[contains(text(),'Запускается')]
    Go To                                ${URL_CAMPAGIN}${campagin_number}/ads/
    Wait Until Page Contains             Все кампании
    Wait Until Page Does Not Contain     Идет загрузка
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Stop Ad                             Test ADV
    Capture Page Screenshot              ${TEST NAME}-{index}.png

Delete Ad
    Start Virtual Display                ${WIDTH}    ${HEIGHT}
    Open Browser                         ${URL_START}   browser=${BROWSER}
    Set Window Size                      ${WIDTH}    ${HEIGHT}
    Click Element                        ${Login}
    Wait Until Element Is Visible        ${Login-modal}
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Press Key                            name=username             ${REG_EMAIL}
    Press Key                            name=password             ${Password}
    Click Element                        ${Login-submit}
    Wait Until Page Contains             Все проекты
    ${project_number}=                   Get Project Number                  Тестовый проект 1
    ${campagin_number}=                  Get Campagin Number                 ${project_number}          Тecтовая кумпания 1
    Go To                                ${URL_CAMPAGIN}${campagin_number}/ads/
    Wait Until Page Contains             Все кампании
    Wait Until Page Does Not Contain     Идет загрузка
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Delete Ad                            Test ADV
    Capture Page Screenshot              ${TEST NAME}-{index}.png

Stop campagin
    Start Virtual Display                ${WIDTH}    ${HEIGHT}
    Open Browser                         ${URL_START}   browser=${BROWSER}
    Set Window Size                      ${WIDTH}    ${HEIGHT}
    Click Element                        ${Login}
    Wait Until Element Is Visible        ${Login-modal}
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Press Key                            name=username             ${REG_EMAIL}
    Press Key                            name=password             ${Password}
    Click Element                        ${Login-submit}
    Wait Until Page Contains             Все проекты
    ${project_number}=                   Get Project Number                  Тестовый проект 1
    Go To                                ${URL_PROJECT}${project_number}/campaigns/
    Wait Until Page Contains             Все кампании
    Wait Until Page Does Not Contain     Идет загрузка
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Stop Campagin                        Тecтовая кумпания 1
    Capture Page Screenshot              ${TEST NAME}-{index}.png

Delete Campagin
    Start Virtual Display                ${WIDTH}    ${HEIGHT}
    Open Browser                         ${URL_START}   browser=${BROWSER}
    Set Window Size                      ${WIDTH}    ${HEIGHT}
    Click Element                        ${Login}
    Wait Until Element Is Visible        ${Login-modal}
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Press Key                            name=username             ${REG_EMAIL}
    Press Key                            name=password             ${Password}
    Click Element                        ${Login-submit}
    Wait Until Page Contains             Все проекты
    ${project_number}=                   Get Project Number                  Тестовый проект 1
    Go To                                ${URL_PROJECT}${project_number}/campaigns/
    Wait Until Page Contains             Все кампании
    Wait Until Page Does Not Contain     Идет загрузка
    Capture Page Screenshot              ${TEST NAME}-{index}.png
    Delete Campagin                      Тecтовая кумпания 1
    Capture Page Screenshot              ${TEST NAME}-{index}.png

Stop project
    Start Virtual Display               ${WIDTH}    ${HEIGHT}
    Open Browser                        ${URL_START}   browser=${BROWSER}
    Set Window Size                     ${WIDTH}    ${HEIGHT}
    Click Element                       ${Login}
    Wait Until Element Is Visible       ${Login-modal}
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Press Key                           name=username             ${REG_EMAIL}
    Press Key                           name=password             ${Password}
    Click Element                       ${Login-submit}
    Wait Until Page Contains            Все проекты
    Capture Page Screenshot             ${TEST NAME}-{index}.png
    Stop Project                        Тестовый проект 1
    Capture Page Screenshot             ${TEST NAME}-{index}.png