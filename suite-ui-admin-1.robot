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

Invalid User Name (Admin)
    Go To                         ${ADMIN}auth/user/
    Invalid User Name         test @.        Enter a valid username. This value may contain only letters, numbers and @/./+/-/_ characters.      This field is required

TC467 - Prepare client's warehouse
    ${name}=                    Get Rand ID          FName_
    ${lname}=                    Get Rand ID          LName_
    set suite variable          ${ch_name}        ${name}
    set suite variable          ${ch_lname}       ${lname}
    Create User                   ${rand_email}              12345678             12345678
    wait until page contains      The user "${rand_email}" was added successfully. You may edit it again below.
    Settings User                ${ch_name}    	${ch_lname}        ${rand_email}
    Select role (super user)
    wait until page contains      The user "${rand_email}" was changed successfully.

    # create a new client
Create a new client (Admin)
    ${client_}=                   Get Rand ID        ${client}
    ${rand_refer_client}=                Get Rand ID        ${refer}
    set suite variable            ${rand_client_name}    ${client_}
    log to console                ${rand_client_name}
    Go To                         ${ADMIN}floship/client/
    Create Client                ${rand_client_name}        ${rand_email}            ${rand_email}       ${rand_refer_client}
    wait until page contains      The client "${rand_client_name}" was added successfully

#################### Product (Admin)


TC612 - Create product (Out of Stock)
    [Tags]                             AdminSearch
    ${sku}=                            Get Rand Sku
    ${desc}=                           Get Rand ID        ${sku_desc}
    set suite variable                 ${search_sku}        ${sku}
    set suite variable                 ${search_desc}       ${desc}
    Go To                             ${ADMIN}inventory/product/add/
    Create Product Admin                   ${rand_client_name}             ${search_sku}          ${search_desc}
    Add SKU and Item for Product (Admin)           ${rand_client_name}            ${search_sku}
    log to console                  ${search_sku}
    log to console                  ${search_desc}
    wait until page contains        The product "${search_desc}" was added successfully.
    Show Product                    ${search_sku}        ${search_desc}

TC614 - Edit product
    Go To                          ${ADMIN}inventory/product/
    Edit Product Admin             ${search_sku}      ${rand_client_name}             ${search_sku}          ${search_desc}
    wait until page contains        The product "${search_desc}" was changed successfully



################ Item CSV Upload



TC653 - Create item (empty fields)
    Mouse over and Click               Inventory              /admin-backend/items/itemcsvupload/
    wait until page contains           Select item csv upload to change
    Add report                     Add item csv upload           Add item csv upload
    wait element and click         xpath=//input[contains(@name,"_save")]
    wait until page contains        Please correct the error below
    wait error this is required (Admin)           Client              This field is required

TC627 - Create item: empty file
    Check Item CSV Upload             empty.xlsx       ${rand_client_name}       The file is empty

TC628 - Create item: missing 1 column (SKU)
    Check Item CSV Upload             3_missing_1_column.xlsx       ${rand_client_name}       Missing_headers: ['SKU']

TC629 - Create item: missing 2 column (Description)
    Check Item CSV Upload             3_missing_2_column.xlsx       ${rand_client_name}       Missing_headers: ['Description']

TC630 - Create item: missing 3 column (Brand/Manufacturer)
    Check Item CSV Upload             3_missing_3_column.xlsx       ${rand_client_name}       Missing_headers: ['Brand/Manufacturer']

Check "Item CSV Upload" (Missing UPC/EAN/MPN)
    Check Item CSV Upload             3_missing_4_column.xlsx       ${rand_client_name}       Missing_headers: ['UPC/EAN/MPN']

TC632 - Create item: missing 5 column (Harmonized Code)
    Check Item CSV Upload             3_missing_5_column.xlsx       ${rand_client_name}       Missing_headers: ['Harmonized Code']

TC633 - Create item: missing 6 column (Gross Weight (kg))
    Check Item CSV Upload             3_missing_6_column.xlsx       ${rand_client_name}       Missing_headers: ['Gross Weight (kg)']

TC634 - Create item: missing 7 column (Gross Length (cm))
    Check Item CSV Upload             3_missing_7_column.xlsx       ${rand_client_name}       Missing_headers: ['Gross Length (cm)']

TC635 - Create item: missing 8 column (Gross Width (cm))
    Check Item CSV Upload             3_missing_8_column.xlsx       ${rand_client_name}       Missing_headers: ['Gross Width (cm)']

TC636 - Create item: missing 9 column (Gross Height (cm))
    Check Item CSV Upload             3_missing_9_column.xlsx       ${rand_client_name}       Missing_headers: ['Gross Height (cm)']

TC637 - Create item: missing 10 column (Customs Value (USD))
    Check Item CSV Upload             3_missing_10_column.xlsx       ${rand_client_name}       Missing_headers: ['Customs Value (USD)']

TC638 - Create item: missing 11 column (Customs Description)
    Check Item CSV Upload             3_missing_11_column.xlsx       ${rand_client_name}       Missing_headers: ['Customs Description']

TC639 - Create item: missing 12 column (Category (if known))
    Check Item CSV Upload             3_missing_12_column.xlsx       ${rand_client_name}       Missing_headers: ['Category (if known)']

TC640 - Create item: missing 13 column (Lithium Ion Battery (Y/N))
    Check Item CSV Upload             3_missing_13_column.xlsx       ${rand_client_name}       Missing_headers: ['Lithium Ion Battery (Y/N)']

TC641 - Create item: missing 14 column (Expiry Date (Y/N))
    Check Item CSV Upload             3_missing_14_column.xlsx       ${rand_client_name}       Missing_headers: ['Expiry Date (Y/N)']

TC642 - Create item: missing 15 column (Liquid (Y/N))
    Check Item CSV Upload             3_missing_15_column.xlsx       ${rand_client_name}       Missing_headers: ['Liquid (Y/N)']

TC643 - Create item: missing 16 column (Item Image URL)
    Check Item CSV Upload             3_missing_16_column.xlsx       ${rand_client_name}       Missing_headers: ['Item Image URL']

TC644 - Create item: missing 17 column (Packaging SKU)
    Check Item CSV Upload             3_missing_17_column.xlsx       ${rand_client_name}       Missing_headers: ['Packaging SKU']

TC645 - Create item: missing 18 column (Country of Manufacture)
    Check Item CSV Upload             3_missing_18_column.xlsx       ${rand_client_name}       Missing_headers: ['Country of Manufacture']

#TC646 - Create item: missing 19 column (Unit QTY)
#    Check Item CSV Upload             3_missing_19_column.xlsx       ${rand_client_name}       Missing_headers: ['Unit QTY']
#
#TC647 - Create item: missing 20 column (Unit type)
#    Check Item CSV Upload             3_missing_20_column.xlsx       ${rand_client_name}       Missing_headers: ['Unit type']



TC648 - Create item: file with invalid data (product exists)
    Check Item CSV Upload             4_invalid_data.xlsx       ${rand_client_name}       Items Csv Upload
    wait until page contains       Items Csv Upload
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    click element                  css=button.close > span
    wait until page does not contain element         xpath=//input[contains(@value,"Save Items Item Csv Upload")]

TC654 - Delete item
    wait element and click               xpath=//a[contains(.,"Delete")]
    wait until page contains          Are you sure you want to delete the item csv upload
    wait element and click            xpath=//input[contains(@value,"Yes, I'm sure")]
    wait until page contains          The item csv upload

TC650 - Create item: file with missed fields
    Check Item CSV Upload             5_missing_fields.xlsx       ${rand_client_name}       Items Csv Upload
    wait until page contains       Items Csv Upload
    show buttons in bulk form           Valid 2    Invalid 1    All 3
    click element                  css=button.close > span
    wait until page does not contain element         xpath=//input[contains(@value,"Save Items Item Csv Upload")]


TC621 - Create item
    Check Item CSV Upload             original2.xlsx       ${rand_client_name}       Items Csv Upload
    wait until page contains       Items Csv Upload
    show buttons in bulk form           Valid 6    Invalid 0    All 6
    click element                  css=button.close > span
    wait element and click         xpath=//input[contains(@value,"Save Items Item Csv Upload")]
    wait until page contains       The item csv upload "${save_item_csv}" was changed successfully
    Sleep                          3 sec

TC621 - Check item (check PROD_1 and PROD_2)
    Go to                               ${ADMIN}inventory/product/
    Check Data Row                    PROD_1         A product one         ${rand_client_name}          987654321
    Check Data Row                   PROD_2         A product two         ${rand_client_name}          	987654321

#############ASN Admin

TC665 - Create ASN
    Go To                         ${ADMIN}
    ${tracking}=                         Get Rand ID        ${tracking}
    ${reference}=                        Get Rand ID        ${refer}
    set suite variable                 ${search_tracking}   ${tracking}
    set suite variable                 ${search_refer}      ${reference}
    Wait Until Page Contains            Dashboard
    Go To                           ${ADMIN}asns/asn/add/
    Add SKU in ASN in Admin         ${search_sku}
    Create ASN Admin                ${rand_client_name}            ${search_refer}     ${search_tracking}
    log to console                  ${search_tracking}
    log to console                  ${search_refer}
    wait until page contains        was added successfully
    ${id}=                          Get FASN in Admin           ${search_refer}
    log to console                  ${id}
    set suite variable              ${search_fsn}                ${id}
    Show ASN                        ${search_refer}

TC666 - Create ASN (approve) - Create ASN in Admin Panel (Filter - Pending Arrival)
    Go To                            ${ADMIN}asns/asn/
    Check Item in Search             ${search_fsn}
    Check ASN Approve                ${search_fsn}        Pending Arrival Asn
    wait until page contains         ${search_fsn} successfully set to Pending Arrival
    Go To                            ${ADMIN}asns/asn/
    show in table                    ${search_fsn}       ${rand_client_name}         Pending Arrival         Geodis

TC666 - Create ASN (approve) - Create ASN in Admin Panel (Pending Arrival)
    Go To                            ${ADMIN}asns/asn/
    Check Filter                1      ${rand_client_name}
    Check Filter                2      Pending Arrival
    Show Product                       ${search_fsn}       Pending Arrival


TC666 - Create ASN (approve) - Create ASN in Admin Panel (to In Review)
    Go To                            ${ADMIN}asns/asn/
    Check Item in Search                        ${search_fsn}
    Check ASN Approve                ${search_fsn}    In Review Asn
    wait until page contains         ${search_fsn} successfully set to In Review
    Go To                            ${ADMIN}asns/asn/
    show in table                    ${search_fsn}       ${rand_client_name}         In Review         Geodis

TC666 - Create ASN (approve) - Create ASN in Admin Panel (Filter - In Review)
    Go To                            ${ADMIN}asns/asn/
    Check Filter                1      ${rand_client_name}
    Check Filter                2      In Review
    Show Product                       ${search_fsn}        In Review


TC666 - Create ASN (approve) - Create ASN in Admin Panel (In Review - Approved)
    Go To                            ${ADMIN}asns/asn/
    Check Item in Search              ${search_fsn}
    Check ASN Approve                 ${search_fsn}  Approve Asn
    wait until page contains         ${search_fsn} successfully set to Approve
    Go To                            ${ADMIN}asns/asn/
    show in table                    ${search_fsn}       ${rand_client_name}         Approved        Geodis

TC666 - Create ASN (approve) - Create ASN in Admin Panel (Filter - Approve)
    Go To                            ${ADMIN}asns/asn/
    Check Filter                1      ${rand_client_name}
    Check Filter                2      Approved
    Show Product                       ${search_fsn}        Approved


TC667 - Check product after adding ASN
    Go To                             ${ADMIN}inventory/product/
    Check Item in Search               ${search_sku}
    show in table                      ${search_sku}     ${search_desc}    ${rand_client_name}     123

############ ASN Upload CSV

TC699 - ASN items uploads (empty fields)
    Go To                         ${ADMIN}
    Mouse over and Click               ASN                    /admin-backend/asns/asnitemsupload/
    wait until page contains           Select asn items upload to change
    Add report                     Add asn items upload            Add asn items upload
    wait element and click         xpath=//input[contains(@name,"_save")]
    wait until page contains        Please correct the error below
    wait error this is required (Admin)           Client              This field is required

TC688 - ASN items uploads: empty file
    Check ASN CSV Upload       2_empty.xlsx       ${rand_client_name}       The file is empty

TC689 - ASN items uploads: missing 1 column (SKU)
    Check ASN CSV Upload     3_missing_1_column.xlsx       ${rand_client_name}    Missing_headers: ['SKU']

TC690 - ASN items uploads: missing 2 column (Quantity)
    Check ASN CSV Upload    3.1_missing_2_column.xlsx      ${rand_client_name}    Missing_headers: ['Quantity']

TC691 - ASN items uploads: missing 3 column (Unit Type)
    Check ASN CSV Upload   3.2_missing_3_column.xlsx      ${rand_client_name}    Missing_headers: ['Unit Type']

TC692 - ASN items uploads: file with invalid data
    Check ASN CSV Upload   4_invalid_data.xlsx      ${rand_client_name}     Asn Items Upload
    wait until page contains       Asn Items Upload
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    click element                  css=button.close > span
    wait until page does not contain element         xpath=//input[contains(@value,"Save Items Item Csv Upload")]

TC960 - ASN items uploads: delete
    wait element and click               xpath=//a[contains(.,"Delete")]
    wait until page contains          Are you sure you want to delete the asn items upload
    wait element and click            xpath=//input[contains(@value,"Yes, I'm sure")]
    wait until page contains          The asn items upload

TC694 - ASN items uploads: file with missed fields
    Check ASN CSV Upload    5_missing_fields.xlsx       ${rand_client_name}     Asn Items Upload
    wait until page contains       Asn Items Upload
    show buttons in bulk form           Valid 0    Invalid 2    All 2
    click element                  css=button.close > span
    wait until page does not contain element         xpath=//input[contains(@value,"Save Items Asn Item Upload")]

TC684 - ASN items uploads: successful upload
    Check ASN CSV Upload     1_success.xlsx       ${rand_client_name}     Asn Items Upload
    wait until page contains       Asn Items Upload
    show buttons in bulk form           Valid 2    Invalid 0    All 2
    click element                  css=button.close > span
    click element                  name=_save
    wait until page contains       The asn items upload "${save_item_csv}" was changed successfully
    show in table                  ${save_item_csv}        ${rand_client_name}         Download           Saved

TC615 - Delete product
    Go To                               ${ADMIN}inventory/product/
    wait until page contains        Dashboard
    Check Item in Search           ${search_sku}
    wait until page contains element        xpath=//tr[@class="row1"][contains(.,"${search_sku}")]
    Delete Something              products
    wait until page contains      Successfully deleted


######## SO

TC700 - Create Shipping option (empty fields)
     Go To                     ${ADMIN}
     Mouse over and Click          Customers                  /admin-backend/preferences/clientshippingoption/
     wait until page contains             Select client shipping option to change
     click element                 xpath=//a[contains(.,"Add client shipping option")]
     wait until page contains          Add client shipping option
     click button                  name=_save
     wait error this is required (Admin)                Client              This field is required

TC697 - Create Shipping option
    ${ship_op}=                        Get Rand ID            ${shipping_name}
    log to console                     ${ship_op}
    set suite variable                  ${ship_op_edit}                         ${ship_op}
    Go To                           ${ADMIN}preferences/clientshippingoption/add/
    wait until page contains          Add client shipping option
    Select Fields Country SO            United States of America
    input text                       name=shipping_option                  ${ship_op_edit}
    Select Fields (Client, Courier) SO          select2-id_client-container           ${rand_client_name}
    Select Fields (Client, Courier) SO          select2-id_courier_service-container                       WMP YAMATO
    click element                  name=_save
    wait until page contains             The client shipping option "${rand_client_name} - ${ship_op_edit}" was added successfully

TC701 - Edit Shipping option
    Go To                           ${ADMIN}preferences/clientshippingoption/
    Check Item in Search      ${ship_op_edit}
    Open Check Order          ${ship_op_edit}
    wait until page contains               Change client shipping option
    Select Fields (Client, Courier) SO          select2-id_client-container           ${rand_client_name}
    Select Fields Country SO            Australia
    click element                  name=_save
    wait until page contains             The client shipping option "${rand_client_name} - ${ship_op_edit}" was changed successfully

TC705 - Bulk actions
    Go To                           ${ADMIN}preferences/clientshippingoption/
    Delete user                     Delete selected client shipping options
    wait until page contains        Successfully deleted 1 client shipping option
    Go To                           ${ADMIN}preferences/clientshippingoption/
    Check Item in Search            ${ship_op_edit}
    wait until page contains        0 client shipping options

### SO Upload Item


######## SO



TC706 - Create client shipping option uploads (empty fields)
     Go To                     ${ADMIN}
     Mouse over and Click          Customers                  /admin-backend/preferences/clientshippingoptionupload/
     wait until page contains             Select client shipping option upload to change
     click element                 xpath=//a[contains(.,"Add client shipping option upload")]
     wait until page contains          Add client shipping option upload
     click button                  name=_save
     wait error this is required (Admin)                Client              This field is required

TC710 - Client shipping option uploads: empty file
    Check SO CSV Upload       2_empty.xlsx       ${rand_client_name}       The file is empty
TC711 - Client shipping option uploads: missing 1 column (Courier Service)
    Check SO CSV Upload       3_missing_1_column.xlsx       ${rand_client_name}       Missing_headers: ['Courier Service']
TC712 - Client shipping option uploads: missing 1 column (Shipping Option)
    Check SO CSV Upload       3.1_missing_2_column.xlsx       ${rand_client_name}       Missing_headers: ['Shipping Option']
TC713 - Client shipping option uploads: missing 3 column (Countries)
    Check SO CSV Upload       3.2_missing_3_column.xlsx       ${rand_client_name}       Missing_headers: ['Countries']
TC714 - Client shipping option uploads: file with invalid data
   Check SO CSV Upload   4_invalid_data.xlsx      ${rand_client_name}     Client Shipping Option Upload
    wait until page contains       Client Shipping Option Upload
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    click element                  css=button.close > span
    wait until page does not contain element         name=_fsmtransition-status-save_

TC1065 - Client shipping option uploads: missing row
   Check SO CSV Upload   5_missing_fields.xlsx      ${rand_client_name}     Client Shipping Option Upload
    wait until page contains       Client Shipping Option Upload
    show buttons in bulk form           Valid 2    Invalid 1    All 3
    click element                  css=button.close > span
    wait until page does not contain element         name=_fsmtransition-status-save_

TC707 - Client shipping option uploads: successful upload
    Check SO CSV Upload     1_success.xlsx       ${rand_client_name}     Client Shipping Option Upload
    wait until page contains       Client Shipping Option Upload
    show buttons in bulk form           Valid 3    Invalid 0    All 3
    click element                  css=button.close > span
    wait element and click         name=_fsmtransition-status-save_
    wait until page contains       The client shipping option upload "${save_item_csv}" was changed successfully.
    set suite variable             ${check_item}           ${save_item_csv}
    show in table                  ${check_item}        ${rand_client_name}         Download           Sav

TC717 - Bulk actions
    Go To                  ${ADMIN}preferences/clientshippingoptionupload/
    Delete user                     Delete selected client shipping option uploads
    wait until page contains        Successfully deleted 1 client shipping option upload






#### 3PL

TC720 - Edit 3PL
    ${test_3pl}=              Get Rand ID                  ${3pl_rand}
    Go To                     ${ADMIN}floship/threepl/
    wait element and click         xpath=//a[contains(.,"3PL_")]
    wait until page contains    Change 3PL
    input text                        id=id_name               ${test_3pl}
    click element                 name=_save
    wait until page contains element          xpath=//a[contains(.,"${test_3pl}")]


### Courier

TC723 - Edit courier

    ${test_courier}=              Get Rand ID         ${couirier_rand}
    set suite variable         ${edit_courier}        ${test_courier}
    Go To                     ${ADMIN}couriers/courier/
    Check Item in Search        Courier
    Open Check Order            Courier
    wait until page contains    Change courier
    input text                        id=id_display_name               Courier${edit_courier}
    click element                 name=_save
    wait until page contains       The courier "Courier${edit_courier}" was changed successfully.
    wait until page contains element          xpath=//a[contains(.,"Courier${edit_courier}")]

    ## Check all checks to the order's page


TC955 - Order bulk upload (empty fields)
    Go to                              ${ADMIN}
    wait until page contains           Dashboard
    mouse over and click               Orders                         /admin-backend/orders/ordersimportrecord/
    wait until page contains           Select order csv upload to change
    Add report                     Add order csv upload            Add order csv upload
    wait element and click         xpath=//input[contains(@name,"_save")]
    wait until page contains        Please correct the error below
    wait error this is required (Admin)           Client              This field is required

TC776 - Order bulk upload: empty file
    Check Order CSV Upload        2_empty.xlsx       ${rand_client_name}       The file is empty    The file is empty

TC777 - Order bulk upload: missing 1 column (OrderID)
    Check Order CSV Upload     3_missing_1_column.xlsx       ${rand_client_name}    Missed headers   OrderID

TC778 - Order bulk upload: missing column (Insurance Value)
    Check Order CSV Upload    3_missing_2_column.xlsx      ${rand_client_name}    Missed headers    Insurance Value (in USD)

TC779 - Order bulk upload: missing column (Company)
    Check Order CSV Upload     3_missing_3_column.xlsx       ${rand_client_name}    Missed headers   Company

TC780 - Order bulk upload: missing column (Contact Name)
    Check Order CSV Upload    3_missing_4_column.xlsx      ${rand_client_name}    Missed headers   Contact Name

TC781 - Order bulk upload: missing column (Address 1)
    Check Order CSV Upload     3_missing_5_column.xlsx       ${rand_client_name}    Missed headers  Address 1

TC782 - Order bulk upload: missing column (Address 2)
    Check Order CSV Upload    3_missing_6_column.xlsx      ${rand_client_name}    Missed headers  Address 2


TC783 - Order bulk upload: missing column (City)
    Check Order CSV Upload     3_missing_7_column.xlsx       ${rand_client_name}    Missed headers    City

TC784 - Order bulk upload: missing column (State)
    Check Order CSV Upload    3_missing_8_column.xlsx      ${rand_client_name}    Missed headers    State


TC785 - Order bulk upload: missing column (Zip Code)
    Check Order CSV Upload     3_missing_9_column.xlsx       ${rand_client_name}    Missed headers    Zip Code

TC786 - Order bulk upload: missing column (Country Code* (2-letter))
    Check Order CSV Upload    3_missing_10_column.xlsx      ${rand_client_name}    Missed headers   Country Code (2-letter)

TC787 - Order bulk upload: missing column (Phone)
    Check Order CSV Upload     3_missing_11_column.xlsx       ${rand_client_name}   Missed headers    Phone

TC788 - Order bulk upload: missing column (Email)
    Check Order CSV Upload    3_missing_12_column.xlsx      ${rand_client_name}    Missed headers    Email

TC789 - Order bulk upload: missing column (Unit Value (in USD))
    Check Order CSV Upload     3_missing_13_column.xlsx       ${rand_client_name}    Missed headers    Unit Value (in USD)

TC790 - Order bulk upload: missing column (Shipping Option)
    Check Order CSV Upload    3_missing_14_column.xlsx      ${rand_client_name}    Missed headers    Shipping Option

TC791 - Order bulk upload: missing column (Quantity)
    Check Order CSV Upload     3_missing_15_column.xlsx       ${rand_client_name}    Missed headers    Quantity

TC792 - Order bulk upload: missing column (Item SKU)
    Check Order CSV Upload    3_missing_16_column.xlsx      ${rand_client_name}    Missed headers    Item SKU

TC793 - Order bulk upload: missing column (Packaging Item)
    Check Order CSV Upload     3_missing_17_column.xlsx       ${rand_client_name}    Missed headers    Packaging Item

TC794 - Order bulk upload: file with invalid data
    Check Order CSV Upload   4_invalid_data.xlsx       ${rand_client_name}      Order Bulk Upload       Order Bulk Upload
    wait until page contains       Order Bulk Upload
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    click element                  css=button.close > span
    wait until page does not contain element         xpath=//input[contains(@value,"Validate Orders Import Record")]

Check "Order CSV Upload" (Delete Item)
    wait element and click               xpath=//a[contains(.,"Delete")]
    wait until page contains          Are you sure you want to delete the order csv upload
    wait element and click            xpath=//input[contains(@value,"Yes, I'm sure")]
    wait until page contains          The order csv upload

TC796 - Order bulk upload: missed fields
    Check Order CSV Upload    5_missing_fields.xlsx       ${rand_client_name}     Order Bulk Upload      Order Bulk Upload
    show buttons in bulk form           Valid 1    Invalid 1    All 2
    click element                  css=button.close > span
    wait until page does not contain element         xpath=//input[contains(@value,"Validate Orders Import Record")]

TC771 - Order bulk upload: successful upload
    Check Order CSV Upload         1_success.xlsx       ${rand_client_name}     Order Bulk Upload     Order Bulk Upload
    show buttons in bulk form           Valid 2    Invalid 0    All 2
    wait element and click                  css=button.close > span
    Sleep                          2 sec
    wait until page contains element    name=_save
    click button                    name=_save
    wait until page contains       The order csv upload "${save_item_csv}" was changed successfully
    show in table                  ${save_item_csv}       ${rand_client_name}         Download           Valid

#############Fulfill################


TC501 - Fulfill order by batch
  go to                        ${ADMIN}orders/warehousependingfulfillmentorder/
  wait until page contains      Select Pending Fulfillment Order to change
  ${fs_fulfil}=                 get element attribute               xpath=//tr[@class="row1"]//a@text
  log to console               ${fs_fulfil}
  set suite variable           ${fs_for_sales_upload}                ${fs_fulfil}

   ${test_file}=                write test          ${fs_for_sales_upload}
   Go To                        ${ADMIN}
   Mouse over and Click         Order                              /admin-backend/orders/warehousesalesorderupload/
   Sales Order Uploads          testOrder.csv
   Update Sales Order Uploads     Pending         Saved


## CROWD

TC820 - Edit Crowd funding order

    Go To                          ${ADMIN}crowd_funding/crowdfundingorder/add/
    wait until page contains       Add crowd funding order
    Select Fields                   Client             ${rand_client_name}           ${rand_client_name}
    Data Today                     1
    wait element and click            name=_save
    wait until page contains        The crowd funding order
    Show Product                    ${rand_client_name}         Pending
    ${crowd}=                      get element attribute                  xpath=//*[@class="row1"]//a@text
    log to console                 ${crowd}
    set suite variable              ${crowd_}          ${crowd}

TC823 - Complete Crowd funding order
    Go To                          ${ADMIN}crowd_funding/crowdfundingorder/
    wait element and click         xpath=//*[@class="row1"]//a[contains(.,"${crowd_}")]
    Select Fields                  Client              ${rand_client_name}          ${rand_client_name}
    wait element and click         name=_fsmtransition-status-notify_three_pl
    wait until page contains       ${crowd_} successfully set to Sent to 3PL
    Go To                          ${ADMIN}crowd_funding/crowdfundingorder/
    Show Product                   ${rand_client_name}         Sent to 3PL

TC822 - Order CSV uploads
    Go To                          ${ADMIN}crowd_funding/crowdfundingorder/
    wait element and click         xpath=//*[@class="row1"]//a[contains(.,"${crowd_}")]
    Header link Admin              Workshop orders import records             Add another Workshop orders import record
    click element                  xpath=//a[contains(.,"Add another Workshop orders import record")]
    choose file                    xpath=//input[@type="file"]                 ${CURDIR}/crowd.xlsx
    Select Client Crowd            ${rand_client_name}
    wait until page contains       Remove
    wait element and click         name=_save
    wait until page contains       The crowd funding order "${crowd_}" was changed successfully.
    Show Product                   ${rand_client_name}         Sent to 3PL

TC821 - Delete Crowd funding order
     Go To                         ${ADMIN}crowd_funding/crowdfundingorder/
      wait element and click         xpath=//*[@class="row1"]//a[contains(.,"${crowd_}")]
      wait element and click         xpath=//a[contains(.,"Delete")]
      wait until page contains       Are you sure you want to delete the crowd funding order "${crowd_}"
      wait element and click             xpath=//*[@value="Yes, I'm sure"]
      wait until page contains        The crowd funding order "${crowd_}" was deleted successfully.
      product does not find in table      ${crowd_}      ${rand_client_name}         ${crowd_}

TC817 - Bulk actions
     Go To                         ${ADMIN}crowd_funding/crowdfundingorder/
     wait element and click        xpath=//tr[@class="row1"]//label
     Delete                        Delete selected crowd funding orders
     wait until page contains       Successfully deleted 1 crowd funding order

