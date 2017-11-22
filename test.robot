*** Settings ***
Documentation                           FloShip UI testing
Resource                                resource.robot
Suite Setup                             Setup Tests
Suite Teardown                          Close All Browsers
*** Test Cases ***
*** Test Cases ***

#

#
TC1183 - Successful upload, only required fields
    Go To                               ${SERVER}/orders/bulk
    login                               client+wmjsaipr@floship.com               12345678
    Bulk Upload                         Order Bulk Upload     order     3_cross_docking_order_missing_OrderID_value.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                      50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data which are not correct    Order ID	              This field may not be blank


TC1186 - Missing Name
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     4_cross_docking_order_missing_Contact_Name_value.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                      50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data which are not correct    Name	              This field may not be blank


TC1187 - Missing Address Line 1
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     5_cross_docking_order_missing_Address_1_value.xls
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                      50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data which are not correct    Address Line 1	              This field may not be blank


TC1188 - Missing City
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     6_cross_docking_order_missing_City_value.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                      50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data which are not correct    City	              This field may not be blank



TC1189 - Missing Country
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     7_cross_docking_order_missing_Country_Code_value.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                      50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data which are not correct    Country	              This field may not be blank



TC1190 - Missing Phone
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     8_cross_docking_order_missing_Phone_value.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                      50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data which are not correct    Phone	              This field may not be blank



TC1191 - Missing Value
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     9_cross_docking_order_missing_Value_value.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                      50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data for order (crossdocking)    Value	              A valid number is required




TC1192 - Missing QTY
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     10_cross_docking_order_missing_Quantity_value.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                      50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data for order (crossdocking)    QTY	             A valid integer is required



TC1193 - Missing C.Description
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     11_cross_docking_order_missing_Customs_Description_value.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                      50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data for order (crossdocking)    C.Description	              This field may not be blank


TC1194 - Missing Weight
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     12_cross_docking_order_missing_Weight_value.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                      50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data for order (crossdocking)                Weight	              A valid number is required.



TC1195 - Missing Manufacture
    Go To                               ${SERVER}/orders/bulk
    Bulk Upload                         Order Bulk Upload     order     13_cross_docking_order_missing_Country_value.xlsx
    wait until page contains            File uploaded successfully
    wait until page contains            Order Bulk Upload                      50 sec
    wait until page contains            Please make sure you resolve the issues below and try uploading the file again
    show buttons in bulk form           Valid 0    Invalid 1    All 1
    wait element and click              xpath=//div[@class="row ng-scope"]//span[contains(.,"Invalid")]
    check data for order (crossdocking)                 Manufacture	              This field may not be blank