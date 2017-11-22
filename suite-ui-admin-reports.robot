*** Settings ***
Documentation                           FloShip UI testing Admin part
Resource                                resource.robot
Suite Setup                             Setup Tests
Suite Teardown                          Close All Browsers

*** Test Cases ***

Create a new user (Admin)
    [Tags]                        CreateUser
    ${email}=                     Get Email Client     ${client mail}
    set suite variable            ${rand_email}        ${email}
    log to console                ${rand_email}
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
    Create User                   ${rand_email}              12345678             12345678
    wait until page contains      The user "${rand_email}" was added successfully. You may edit it again below.
    Settings User                ${ch_name}    	${ch_lname}        ${rand_email}
    Select role (super user)
    wait until page contains      The user "${rand_email}" was changed successfully

    # create a new client
Create a new client (Admin)
    ${client_}=                   Get Rand ID        ${client}
    ${rand_refer_client}=                Get Rand ID        ${refer}
    set suite variable            ${rand_client_name}    ${client_}
    log to console                ${rand_client_name}
    Go To                         ${ADMIN}floship/client/
    Create Client                ${rand_client_name}        ${rand_email}            ${rand_email}       ${rand_refer_client}
    wait until page contains      The client "${rand_client_name}" was added successfully

################ REPORTS #########################

TC117 - Create "Courier label" report
    Go To                        ${ADMIN}
    Mouse over and Click                Reports                /admin-backend/reports/courierlabelreport/
    wait until page contains            Select courier label report to change

#Courier

    Add report                      Add courier label report          Add courier label report
    #Select Fields                    File format        CSV            CSV
    Select Fields                    Template           Asendia AU/NZ          Asendia AU/NZ
    Select Fields                    Courier            WMP YAMATO     WMP YAMATO
    click button                    Save
    wait until page contains        The courier label report
    ${file_name}=                   get element attribute                   xpath=//tr[@class="row1"]//a@text
    log to console                  ${file_name}
    set suite variable              ${generate_report}           ${file_name}
    Check Status Report             Asendia AU/NZ                WMP YAMATO          Pending            ${generate_report}

TC118 - Generate "Courier label" report
    Go To                           ${ADMIN}reports/courierlabelreport/

TC119 - Generated "Courier label" report in "Saved" status
    Generate report                 ${generate_report}        Change courier label report       Generate Courier Label Report
    wait until page contains        ${generate_report} successfully set to Saving
    Go To                           ${ADMIN}reports/courierlabelreport/
    Check Status Report             Asendia AU/NZ                WMP YAMATO          Sav            ${generate_report}

TC1123 - Courier label report - DPEX
    Go To                        ${ADMIN}
    Mouse over and Click                Reports                /admin-backend/reports/courierlabelreport/
    wait until page contains            Select courier label report to change
    Add report                      Add courier label report          Add courier label report
    #Select Fields                    File format        CSV            CSV
    Select Fields                    Template           DPEX           DPEX
    Select Fields                    Courier            WMP YAMATO     WMP YAMATO
    click button                    Save
    wait until page contains        The courier label report
    ${file_name}=                   get element attribute                   xpath=//tr[@class="row1"]//a@text
    log to console                  ${file_name}
    set suite variable              ${generate_report}           ${file_name}
    Check Status Report             DPEX                WMP YAMATO          Pending            ${generate_report}
    Go To                           ${ADMIN}reports/courierlabelreport/
    Generate report                 ${generate_report}        Change courier label report       Generate Courier Label Report
    wait until page contains        ${generate_report} successfully set to Saving
    Go To                           ${ADMIN}reports/courierlabelreport/
    Check Status Report             DPEX                WMP YAMATO          Sav            ${generate_report}


TC1123 - Courier label report - DHL Parcel Direct
    Go To                        ${ADMIN}
    Mouse over and Click                Reports                /admin-backend/reports/courierlabelreport/
    wait until page contains            Select courier label report to change
    Add report                      Add courier label report          Add courier label report
    #Select Fields                    File format        CSV            CSV
    Select Fields                    Template           DHL Parcel Direct           DHL Parcel Direct
    Select Fields                    Courier            WMP YAMATO     WMP YAMATO
    click button                    Save
    wait until page contains        The courier label report
    ${file_name}=                   get element attribute                   xpath=//tr[@class="row1"]//a@text
    log to console                  ${file_name}
    set suite variable              ${generate_report}           ${file_name}
    Check Status Report             DHL Parcel Direct                WMP YAMATO          Pending            ${generate_report}
    Go To                           ${ADMIN}reports/courierlabelreport/
    Generate report                 ${generate_report}        Change courier label report       Generate Courier Label Report
    wait until page contains        ${generate_report} successfully set to Saving
    Go To                           ${ADMIN}reports/courierlabelreport/
    Check Status Report             DHL Parcel Direct                WMP YAMATO          Sav            ${generate_report}

TC1123 - Courier label report - Fedex (IP, IE)
    Go To                        ${ADMIN}
    Mouse over and Click                Reports                /admin-backend/reports/courierlabelreport/
    wait until page contains            Select courier label report to change
    Add report                      Add courier label report          Add courier label report
    #Select Fields                    File format        CSV            CSV
    Select Fields                    Template           Fedex (IP, IE)           Fedex (IP, IE)
    Select Fields                    Courier            WMP YAMATO     WMP YAMATO
    click button                    Save
    wait until page contains        The courier label report
    ${file_name}=                   get element attribute                   xpath=//tr[@class="row1"]//a@text
    log to console                  ${file_name}
    set suite variable              ${generate_report}           ${file_name}
    Check Status Report             Fedex (IP, IE)                WMP YAMATO          Pending            ${generate_report}
    Go To                           ${ADMIN}reports/courierlabelreport/
    Generate report                 ${generate_report}        Change courier label report       Generate Courier Label Report
    wait until page contains        ${generate_report} successfully set to Saving
    Go To                           ${ADMIN}reports/courierlabelreport/
    Check Status Report             Fedex (IP, IE)                WMP YAMATO          Sav            ${generate_report}

TC1123 - Courier label report - Globavend
    Go To                        ${ADMIN}
    Mouse over and Click                Reports                /admin-backend/reports/courierlabelreport/
    wait until page contains            Select courier label report to change
    Add report                      Add courier label report          Add courier label report
    #Select Fields                    File format        CSV            CSV
    Select Fields                    Template           Globavend           Globavend
    Select Fields                    Courier            WMP YAMATO     WMP YAMATO
    click button                    Save
    wait until page contains        The courier label report
    ${file_name}=                   get element attribute                   xpath=//tr[@class="row1"]//a@text
    log to console                  ${file_name}
    set suite variable              ${generate_report}           ${file_name}
    Check Status Report             Globavend                WMP YAMATO          Pending            ${generate_report}
    Go To                           ${ADMIN}reports/courierlabelreport/
    Generate report                 ${generate_report}        Change courier label report       Generate Courier Label Report
    wait until page contains        ${generate_report} successfully set to Saving
    Go To                           ${ADMIN}reports/courierlabelreport/
    Check Status Report             Globavend                WMP YAMATO          Sav            ${generate_report}


TC1123 - Courier label report - HKPost (EEX)
    Go To                        ${ADMIN}
    Mouse over and Click                Reports                /admin-backend/reports/courierlabelreport/
    wait until page contains            Select courier label report to change
    Add report                      Add courier label report          Add courier label report
    #Select Fields                    File format        CSV            CSV
    Select Fields                    Template           HKPost (EEX)           HKPost (EEX)
    Select Fields                    Courier            WMP YAMATO     WMP YAMATO
    click button                    Save
    wait until page contains        The courier label report
    ${file_name}=                   get element attribute                   xpath=//tr[@class="row1"]//a@text
    log to console                  ${file_name}
    set suite variable              ${generate_report}           ${file_name}
    Check Status Report             HKPost (EEX)                WMP YAMATO          Pending            ${generate_report}
    Go To                           ${ADMIN}reports/courierlabelreport/
    Generate report                 ${generate_report}        Change courier label report       Generate Courier Label Report
    wait until page contains        ${generate_report} successfully set to Saving
    Go To                           ${ADMIN}reports/courierlabelreport/
    Check Status Report             HKPost (EEX)               WMP YAMATO          Sav            ${generate_report}

TC1123 - Courier label report - HKPost (Packet, Parcel)
    Go To                        ${ADMIN}
    Mouse over and Click                Reports                /admin-backend/reports/courierlabelreport/
    wait until page contains            Select courier label report to change
    Add report                      Add courier label report          Add courier label report
    #Select Fields                    File format        CSV            CSV
    Select Fields                    Template           HKPost (Packet, Parcel)           HKPost (Packet, Parcel)
    Select Fields                    Courier            WMP YAMATO     WMP YAMATO
    click button                    Save
    wait until page contains        The courier label report
    ${file_name}=                   get element attribute                   xpath=//tr[@class="row1"]//a@text
    log to console                  ${file_name}
    set suite variable              ${generate_report}           ${file_name}
    Check Status Report             HKPost (Packet, Parcel)                WMP YAMATO          Pending            ${generate_report}
    Go To                           ${ADMIN}reports/courierlabelreport/
    Generate report                 ${generate_report}        Change courier label report       Generate Courier Label Report
    wait until page contains        ${generate_report} successfully set to Saving
    Go To                           ${ADMIN}reports/courierlabelreport/
    Check Status Report             HKPost (Packet, Parcel)               WMP YAMATO          Sav            ${generate_report}

TC1123 - Courier label report - HKPost (RAM, EMS, AP)
    Go To                        ${ADMIN}
    Mouse over and Click                Reports                /admin-backend/reports/courierlabelreport/
    wait until page contains            Select courier label report to change
    Add report                      Add courier label report          Add courier label report
    #Select Fields                    File format        CSV            CSV
    Select Fields                    Template           HKPost (RAM, EMS, AP)           HKPost (RAM, EMS, AP)
    Select Fields                    Courier            WMP YAMATO     WMP YAMATO
    click button                    Save
    wait until page contains        The courier label report
    ${file_name}=                   get element attribute                   xpath=//tr[@class="row1"]//a@text
    log to console                  ${file_name}
    set suite variable              ${generate_report}           ${file_name}
    Check Status Report             HKPost (RAM, EMS, AP)                WMP YAMATO          Pending            ${generate_report}
    Go To                           ${ADMIN}reports/courierlabelreport/
    Generate report                 ${generate_report}        Change courier label report       Generate Courier Label Report
    wait until page contains        ${generate_report} successfully set to Saving
    Go To                           ${ADMIN}reports/courierlabelreport/
    Check Status Report             HKPost (RAM, EMS, AP)               WMP YAMATO          Sav            ${generate_report}














# Floship



TC121 - Create "Floship" report
    Go To                           ${ADMIN}
    Mouse over and Click                Reports                /admin-backend/reports/floshipreport/
    wait until page contains            Select floship report to change
    Add report                     Add floship report           Add floship report
    #Select Fields                    File format        CSV            CSV
    Data Today                      1
    Time Now                        1
    Select Fields                   Client              ${rand_client_name}                ${rand_client_name}
    Select Fields                    Courier            WMP YAMATO     WMP YAMATO
    #Select Fields                   Report type           Per order       Per order
    click button                    Save
    wait until page contains        The floship report
    ${floship_report}=                   get element attribute                   xpath=//tr[@class="row1"]//a@text
    log to console                  ${floship_report}
    set suite variable              ${generate_flo_report}        ${floship_report}
    Check Status Report             ${rand_client_name}                WMP YAMATO          Pending            ${generate_flo_report}


TC122 - Generate "Floship" report
    Go To                           ${ADMIN}reports/floshipreport/
    Generate report                 ${generate_flo_report}       Change floship report       Generate Floship Report
    wait until page contains        ${generate_flo_report} successfully set to Saving

TC123 - Generated "Floship" report in "Saved" status
    Go To                           ${ADMIN}reports/floshipreport/
    Check Status Report             ${rand_client_name}                WMP YAMATO          Sav            ${generate_flo_report}


# Fulfilment


TC125 - Create "Fulfilment" report
    Go To                           ${ADMIN}
    Mouse over and Click                Reports                /admin-backend/reports/fulfillmentreportmodel/
    wait until page contains            Select Fulfilment report to change
    Add report                     Add Fulfilment report           Add Fulfilment report
    Data Today                      1
    Time Now                        1
    Select Fields                   Client              ${rand_client_name}                ${rand_client_name}
    #Select Fields                   File format        CSV            CSV
    click button                    Save
    wait until page contains        The Fulfilment report
    ${fulfilment_report}=                   get element attribute                   xpath=//tr[@class="row1"]//a@text
    log to console                  ${fulfilment_report}
    set suite variable              ${generate_fulfilment_report}        ${fulfilment_report}
    Check Status Report             ${rand_client_name}               NS report per order          Pending            ${generate_fulfilment_report}

TC126 - Generate "Fulfilment" report
    Go To                           ${ADMIN}reports/fulfillmentreportmodel/
    Generate report                 ${generate_fulfilment_report}      Change Fulfilment report       Generate Fulfilment Report
    wait until page contains        ${generate_fulfilment_report} successfully set to Saving

TC127 - Generated "Fulfilment" report in "Saved" status
    Go To                           ${ADMIN}reports/fulfillmentreportmodel/
    Check Status Report             ${rand_client_name}           NS report per order              Sav           ${generate_fulfilment_report}





 ##Inventory

TC129 - Create "Inventory" report
    Go To                               ${ADMIN}
    Mouse over and Click                Reports                /admin-backend/reports/inventoryreport/
    wait until page contains            Select inventory report to change

TC130 - Generate "Inventory" report - 1
    Add report                      Add inventory report           Add inventory report
    #Select Fields                   File format        CSV            CSV
    Select Fields                   Client              ${rand_client_name}                 ${rand_client_name}
    click button                    Save
    wait until page contains        The inventory report
    ${inventory_report}=                   get element attribute                   xpath=//tr[@class="row1"]//a@text
    log to console                  ${inventory_report}
    set suite variable              ${generate_inventory_report}        ${inventory_report}
    Check Status Report without Courier             ${rand_client_name}                     Pending           ${generate_inventory_report}
TC130 - Generate "Inventory" report - 2
    Go To                           ${ADMIN}reports/inventoryreport/
    Generate report                 ${generate_inventory_report}      Change inventory report       Generate Inventory Report
    wait until page contains        ${generate_inventory_report} successfully set to Saving

TC131 - Generated "Inventory" report in "Saved" status
    Go To                           ${ADMIN}reports/inventoryreport/
    Check Status Report without Courier             ${rand_client_name}           Sav            ${generate_inventory_report}


 # State Log



TC133 - Create "State Log" report

    Go To                               ${ADMIN}
    Mouse over and Click                Reports                /admin-backend/reports/statelogreportmodel/
    wait until page contains            Select State Log report to change

TC134 - Generate "State Log" report - 1
    Add report                      Add State Log report           Add State Log report
    #Select Fields                    File format        CSV            CSV
    Data Today                      1
    Time Now                        1
    Select Fields                   Client              ${rand_client_name}          ${rand_client_name}
    Select Fields                    Courier            WMP YAMATO     WMP YAMATO
    click button                    Save
    wait until page contains        The State Log report
    ${state_log_report}=                   get element attribute                   xpath=//tr[@class="row1"]//a@text
    log to console                  ${state_log_report}
    set suite variable              ${generate_state_log_report}       ${state_log_report}
    Check Status Report             ${rand_client_name}                WMP YAMATO          Pending            ${generate_state_log_report}


TC134 - Generate "State Log" report - 2
    Go To                           ${ADMIN}reports/statelogreportmodel/
    Generate report                 ${generate_state_log_report}      Change State Log report       Generate State Log Report
    wait until page contains        ${generate_state_log_report} successfully set to Saving

TC135 - Generated "State Log" report in "Saved" status
    Go To                           ${ADMIN}reports/statelogreportmodel/
    Check Status Report             ${rand_client_name}         WMP YAMATO       Sav                 ${generate_state_log_report}


# Transaction


TC137 - Create "Transactions" report
    Go To                               ${ADMIN}
    Mouse over and Click                Reports               /admin-backend/reports/transactionsreport/
    wait until page contains            Select transactions report to change

TC138 - Generate "Transactions" report - 1
    Add report                     Add transactions report           Add transactions report
    Data Today                      1
    Select Fields                   Client              ${rand_client_name}        ${rand_client_name}
    click button                    Save
    wait until page contains        The transactions report
    ${transaction_report}=                   get element attribute                   xpath=//tr[@class="row1"]//a@text
    log to console                  ${transaction_report}
    set suite variable              ${generate_transaction_report}       ${transaction_report}
    Check Status Report without Courier            ${rand_client_name}                         Pending            ${generate_transaction_report}


TC138 - Generate "Transactions" report - 2
    Go To                           ${ADMIN}reports/transactionsreport/
    Generate report                 ${generate_transaction_report}      Change transactions report        Generate Transactions Report
    wait until page contains        ${generate_transaction_report} successfully set to Saving

TC139 - Generated "Transactions" report in "Saved" status
    Go To                           ${ADMIN}reports/transactionsreport/
    Check Status Report without Courier             ${rand_client_name}               Sav                 ${generate_transaction_report}


 ## VAS Report


TC141 - Create "Vas" report
    Go To                               ${ADMIN}
    Mouse over and Click                Reports               /admin-backend/reports/vasreport/
    wait until page contains            Select vas report to change

TC142 - Generate "Vas" report - 1
    Add report                     Add vas report           Add vas report
    #Select Fields                    File format        CSV            CSV
    Data Today                      1
    Select Fields                   Client              ${rand_client_name}          ${rand_client_name}
    click button                    Save
    wait until page contains        The vas repor
    ${vas_report}=                   get element attribute                   xpath=//tr[@class="row1"]//a@text
    log to console                  ${vas_report}
    set suite variable              ${generate_vas_report}       ${vas_report}
    Check Status Report without Courier            ${rand_client_name}                        Pending            ${generate_vas_report}


TC142 - Generate "Vas" report - 2
    Go To                           ${ADMIN}reports/vasreport/
    Generate report                 ${generate_vas_report}      Change vas report        Generate Vas Report
    wait until page contains        ${generate_vas_report} successfully set to Saving

TC143 - Generated "Vas" report in "Saved" status
    Go To                           ${ADMIN}reports/vasreport/
    Check Status Report without Courier            ${rand_client_name}               Sav                 ${generate_vas_report}