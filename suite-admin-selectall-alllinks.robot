*** Settings ***
Documentation                           FloShip UI testing Admin part
Resource                                resource.robot
Suite Setup                             Setup Tests
Suite Teardown                          Close All Browsers

*** Test Cases ***

TC580 - FP-2264 Fix select all in admin (Customers)
    Login                         ${login_admin}        ${pass_admin}
    Wait Until Page Contains      Dashboard

# Customers

    Mouse over and Click          Customers             /admin-backend/auth/user/
    wait until page contains      Select user to change
    Check Select All checkbox     Select all
    Check a few select

    Mouse over and Click          Customers            /admin-backend/floship/client/
    wait until page contains      Select client to change
    Check Select All checkbox     Select all
    Check a few select

    Mouse over and Click          Customers            /admin-backend/authtoken/token/
    wait until page contains      Select Token to change
    Check Select All checkbox     selected
    Check a few select

    Mouse over and Click          Customers            /admin-backend/preferences/clientshippingoption/
    wait until page contains      Select client shipping option to change
    Check Select All checkbox     Select all
    Check a few select

    Mouse over and Click          Customers            /admin-backend/preferences/clientshippingoptionupload/
    wait until page contains      Select client shipping option upload to change
    Check Select All checkbox     Select all
    Check a few select

TC580 - FP-2264 Fix select all in admin (Order)
    Mouse over and Click          Orders            /admin-backend/orders/salesorder/
    wait until page contains      Select sales order to change
    Check Select All checkbox     Select all
    Check a few select

    Mouse over and Click          Orders            /admin-backend/crowd_funding/crowdfundingorder/
    wait until page contains      Select crowd funding order to change
    Check Select All checkbox     Select all
    Check a few select

    Mouse over and Click          Orders            /admin-backend/orders/warehousefulfilledorder/
    wait until page contains      Select Fulfilled Order to change
    Check Select All checkbox     Select all
    Check a few select

    Mouse over and Click          Orders            /admin-backend/orders/ordercsvupload/
    wait until page contains      Select order csv upload to change
    Check Select All checkbox     Select all
    Check a few select

    Mouse over and Click          Orders            /admin-backend/orders/warehousependingfulfillmentorder/
    wait until page contains      Select Pending Fulfillment Order to change
    Check Select All checkbox     Select all
    Check a few select

    Mouse over and Click          Orders            /admin-backend/orders/threeplexceptionsupdateupload/
    wait until page contains      Select three pl exceptions update upload to change
    Check Select All checkbox     selected
    Check a few select

    Mouse over and Click          Orders            /admin-backend/orders/warehousesalesorderupload/
    wait until page contains      Select warehouse sales order upload to change
    Check Select All checkbox     Select all
    Check a few select

TC580 - FP-2264 Fix select all in admin (ASN)
    Mouse over and Click          ASN            /admin-backend/asns/asnitemsupload/
    wait until page contains      Select asn items upload to change
    Check Select All checkbox     Select all
    Check a few select


TC580 - FP-2264 Fix select all in admin (Products)

    Mouse over and Click          Inventory            /admin-backend/inventory/product/
    wait until page contains      Select product to change
    Check Select All checkbox     Select all
    Check a few select

    Mouse over and Click          Inventory           /admin-backend/items/itemcsvupload/
    wait until page contains      Select item csv upload to change
    Check Select All checkbox     Select all
    Check a few select

TC580 - FP-2264 Fix select all in admin (Tools)

    Mouse over and Click          Tools            /admin-backend/tools/batchlabelupload/
    wait until page contains      Select batch label upload to change
    Check Select All checkbox     selected
    Check a few select

    Mouse over and Click          Tools            /admin-backend/tools/orderupdateupload/
    wait until page contains      Select order update upload to change
    Check Select All checkbox     selected
    Check a few select

    Mouse over and Click          Tools            /admin-backend/tools/salesordercostupload/
    wait until page contains     Select sales order cost upload to change
    Check Select All checkbox     Select all
    Check a few select

    Mouse over and Click          Tools            /admin-backend/tools/vendorbillupload/
    wait until page contains     Select vendor bill upload to change
    Check Select All checkbox     selected
    Check one select

    Mouse over and Click          Tools            /admin-backend/tools/vendorbillitem/
    wait until page contains      Select vendor bill item to change
    Check Select All checkbox     selected
    Check a few select


TC580 - FP-2264 Fix select all in admin (Accounting)

    Mouse over and Click          Accounting            /admin-backend/accounting/salesinvoice/
    wait until page contains      Select sales invoice to change
    Check Select All checkbox     selected
    Check a few select

    Mouse over and Click          Accounting            /admin-backend/accounting/creditnote/
    wait until page contains      Select credit note to change
    Check Select All checkbox     Select all
    Check a few select

    Mouse over and Click          Accounting            /admin-backend/accounting/batchinvoice/
    wait until page contains      Select batch invoice to change
    Check Select All checkbox     Select all
    Check a few select

    Mouse over and Click          Accounting            /admin-backend/accounting/invoiceerror/
    wait until page contains      Select invoice error to change
    Check Select All checkbox     Select all
    Check a few select

    Mouse over and Click          Accounting            /admin-backend/billing/paymentmethod/
    wait until page contains      Select payment method to change
    Check Select All checkbox     Select all
    Check a few select

    Mouse over and Click          Accounting            /admin-backend/billing/transaction/
    wait until page contains      Select transaction to change
    Check Select All checkbox     Select all
    Check a few select

    Mouse over and Click          Accounting            /admin-backend/rates/b2cpiecepickrate/
    wait until page contains      Select B2C Piece pick rate to change
    Check Select All checkbox     selected
    Check one select

    Mouse over and Click          Accounting            /admin-backend/rates/cartonpickrate/
    wait until page contains      Select Carton pick rate to change
    Check Select All checkbox     selected
    Check a few select

    Mouse over and Click          Accounting            /admin-backend/rates/crowdfundingrate/
    wait until page contains      Select crowd funding rate to change
    Check Select All checkbox     selected
    Check a few select

    Mouse over and Click          Accounting            /admin-backend/accounting/servicetype/
    wait until page contains      Select Sales Account Code to change
    Check Select All checkbox     selected
    Check a few select

    Mouse over and Click          Accounting            /admin-backend/accounting/serviceitemcode/
    wait until page contains      Select service item code to change
    Check Select All checkbox     selected
    Check a few select

    Mouse over and Click          Accounting            /admin-backend/accounting/serviceitem/
    wait until page contains      Select Summary to change
    Check Select All checkbox     Select all
    Check a few select

    Mouse over and Click          Accounting            /admin-backend/accounting/vas/
    wait until page contains      Select VAS to change
    Check Select All checkbox     Select all
    Check a few select


    Mouse over and Click          Accounting            /admin-backend/accounting/vasupload/
    wait until page contains      Select vas upload to change
    Check Select All checkbox     selected
    Check a few select






TC580 - FP-2264 Fix select all in admin (Miscellaneous)
    Mouse over and Click          Miscellaneous            /admin-backend/oauth2_provider/accesstoken/
    wait until page contains      Select access token to change
    Check Select All checkbox     selected
    Check a few select

    Mouse over and Click          Miscellaneous            /admin-backend/oauth2_provider/refreshtoken/
    wait until page contains      Select refresh token to change
    Check Select All checkbox     selected
    Check a few select

    Mouse over and Click          Miscellaneous            /admin-backend/crm/salesperson/
    wait until page contains      Select Sales Person to change
    Check Select All checkbox     selected
    Check a few select

    Mouse over and Click          Miscellaneous            /admin-backend/crm/salesdeal/
    wait until page contains      Select sales deal to change
    Check Select All checkbox     selected
    Check one select

TC580 - FP-2264 Fix select all in admins (Settings)

    Mouse over and Click          Settings            /admin-backend/auth/group/
    wait until page contains      Select group to change
    Check Select All checkbox     selected
    Check a few select

    Mouse over and Click          Settings            /admin-backend/waffle/flag/
    wait until page contains      Select flag to change
    Check Select All checkbox     selected
    Check a few select


    Mouse over and Click          Settings            /admin-backend/client_notifications/clientnotification/
    wait until page contains      Select client notification to change
    Check Select All checkbox     selected
    Check a few select

    Mouse over and Click          Settings            /admin-backend/waffle/sample/
    wait until page contains      Select sample to change
    Check Select All checkbox     selected
    Check one select


    Mouse over and Click          Settings            /admin-backend/waffle/switch/
    wait until page contains      Select switch to change
    Check Select All checkbox     selected

TC580 - FP-2264 Fix select all in admin (Reports)

    Mouse over and Click          Reports                /admin-backend/reports/courierlabelreport/
    wait until page contains      Select courier label report to change
    Check Select All checkbox     Select all
    Check a few select

    Mouse over and Click          Reports                /admin-backend/reports/floshipreport/
    wait until page contains      Select floship report to change
    Check Select All checkbox     Select all
    Check a few select

    Mouse over and Click          Reports                /admin-backend/reports/fulfillmentreportmodel/
    wait until page contains      Select Fulfilment report to change
    Check Select All checkbox     Select all
    Check a few select

    Mouse over and Click          Reports                /admin-backend/reports/inventoryreport/
    wait until page contains      Select inventory report to change
    Check Select All checkbox     Select all
    Check a few select

    Mouse over and Click          Reports                /admin-backend/reports/statelogreportmodel/
    wait until page contains      Select State Log report to change
    Check Select All checkbox     Select all
    Check a few select

    Mouse over and Click          Reports                /admin-backend/reports/transactionsreport/
    wait until page contains      Select transactions report to change
    Check Select All checkbox     selected
    Check a few select

    Mouse over and Click          Reports                /admin-backend/reports/vasreport/
    wait until page contains      Select vas report to change
    Check Select All checkbox     selected
    Check a few select


TC929 - ONBOARDING
    Go To                            ${ADMIN}
    wait until page contains         Dashboard
    wait until page contains          Onboarding
    check onboarding in dashboard        Term Of Service Step
    Show Product               Term Of Service Step             Active
    Go To                         ${ADMIN}

    check onboarding in dashboard        Billing Step
    Show Product               Billing Step             Active
    Go To                         ${ADMIN}

    check onboarding in dashboard        Prepayment Step
    Show Product               	Prepayment Step             Active
    Go To                         ${ADMIN}

    check onboarding in dashboard        3pl Step
    Show Product               3pl Step             Active
    Go To                         ${ADMIN}

    check onboarding in dashboard        Product Step
    Show Product               Product Step             Active
    Go To                         ${ADMIN}

    check onboarding in dashboard        ASN Step
    Show Product                ASN Step             Active
    Go To                         ${ADMIN}

    check onboarding in dashboard        Finished
    Show Product                Finished             Active
    Go To                         ${ADMIN}


TC926 - ORDERS
    [Tags]            Test

    check order in dashboard        Incomplete        Select sales order to change
    check status and state orders            Incomplete            Incomplete
    check order in dashboard        Pending approval    Select sales order to change
   check status and state orders             Pending approval         Pending approval
    check order in dashboard        Pending Fulfillment - Pending fulfillment      Select sales order to change
   check status and state orders                Pending Fulfillment     Pending fulfillment
    check order in dashboard        Pending Fulfillment - Generating shipping labels         Select sales order to change
   check status and state orders                 Pending Fulfillment       Generating shipping labels
    check order in dashboard         Pending Fulfillment - Labels Generated          Select sales order to change
   check status and state orders             Pending Fulfillment       Labels Generated
    check order in dashboard        Pending Fulfillment - Notifying 3PL            Select sales order to change
   check status and state orders                Pending Fulfillment        Notifying 3PL
    check order in dashboard        Pending Fulfillment - Sent to 3PL              Select sales order to change
  check status and state orders                 Pending Fulfillment      Sent to 3PL
    check order in dashboard        Pending Fulfillment - Received by 3PL         Select sales order to change
   check status and state orders                Pending Fulfillment      Received by 3PL
    check order in dashboard        Pending Fulfillment - Picked                 Select sales order to change
   check status and state orders       Pending Fulfillment        Picked
    check order in dashboard        Pending Fulfillment - Packed                 Select sales order to change
   check status and state orders                    Pending Fulfillment      Packed
    check order in dashboard        Pending Fulfillment - On Hold              Select sales order to change
   check status and state orders              Pending Fulfillment         On Hold
    check order in dashboard        Fulfilled - Fulfilled                     Select sales order to change
   check status and state orders                  Fulfilled        Fulfilled
    check order in dashboard        Fulfilled - Tracking integrations notified        Select sales order to change
  check status and state orders                    Fulfilled     Tracking integrations notified
    check order in dashboard        Canceled             Select sales order to change
   check status and state orders                  Canceled         Canceled


TC931 - ASNS
    check order in dashboard       Approved       Select ASN to change
    check status and state orders                  FASN        Approved

    Go To                          ${ADMIN}
    wait until page contains        Dashboard
    Sleep                           2 sec
    wait element and click            xpath=//a[contains(@href,"/admin-backend/asns/asn/?status__exact=5")]
    wait until page contains       Select ASN to change

    check status and state orders                  FASN        Canceled
    check order in dashboard       Pending Arrival       Select ASN to change
    check status and state orders                  FASN        Pending Arrival
    check order in dashboard       In Review       Select ASN to change
    check status and state orders                  FASN        In Review

    Go To                          ${ADMIN}
    wait until page contains        Dashboard
    Sleep                           2 sec
    wait element and click            xpath=//a[contains(@href,"/admin-backend/asns/asn/?status__exact=3")]
    wait until page contains       Select ASN to change

    check status and state orders                  FASN        On Hold
    check order in dashboard       Draft       Select ASN to change
    check status and state orders                  FASN        Draft

TC932 - EXCEPTIONS
    check exceptions in dashboard         Duplicated       2     Incomplete         Incomplete
    check exceptions in dashboard         Duplicated       3     Pending Approval         Pending Approval
    check exceptions in dashboard         Duplicated       4     Pending Fulfillment         Pending fulfillment
    check exceptions in dashboard         Duplicated       5     Fulfilled        Tracking integrations notified

    check exceptions in dashboard         Courier is not available       2     Incomplete	Incomplete
    check exceptions in dashboard         Courier is not available       3     Pending Approval         Pending Approval
    check exceptions in dashboard         Courier is not available       4     Pending Fulfillment         Pending fulfillment
    check exceptions in dashboard         Courier is not available       5     Fulfilled        Tracking integrations notified

    check exceptions in dashboard         Courier is not assigned       2     Incomplete	Incomplete
    check exceptions in dashboard         Courier is not assigned       3     Pending Approval         Pending Approval
    check exceptions in dashboard         Courier is not assigned       4     Pending Fulfillment         Pending fulfillment
    check exceptions in dashboard         Courier is not assigned       5     Fulfilled        Tracking integrations notified

    check exceptions in dashboard         Items are not valid       2     Incomplete	        Incomplete
    check exceptions in dashboard         Items are not valid       3     Pending Approval         Pending Approval
    check exceptions in dashboard         Items are not valid       4     Pending Fulfillment         Pending fulfillment
    check exceptions in dashboard         Items are not valid       5     Fulfilled        Tracking integrations notified

    check exceptions in dashboard         Shipping Errors       2     Incomplete	          Incomplete
    check exceptions in dashboard         Shipping Errors       3     Pending Approval         Pending Approval
    check exceptions in dashboard         Shipping Errors       4     Pending Fulfillment         Pending fulfillment
    check exceptions in dashboard         Shipping Errors       5     Fulfilled        Tracking integrations notified

    check exceptions in dashboard         No suitable package was found       2     Incomplete	        Incomplete
    check exceptions in dashboard         No suitable package was found       3     Pending Approval         Pending Approval
    check exceptions in dashboard         No suitable package was found       4     Pending Fulfillment         Pending fulfillment
    check exceptions in dashboard         No suitable package was found       5     Fulfilled        Tracking integrations notified

    check exceptions in dashboard         Order is not valid       2     Incomplete	             Incomplete
    check exceptions in dashboard         Order is not valid       3     Pending Approval         Pending Approval
    check exceptions in dashboard         Order is not valid       4     Pending Fulfillment         Pending fulfillment
    check exceptions in dashboard         Order is not valid       5     Fulfilled        Tracking integrations notified

    check exceptions in dashboard         Warehouse sync problem       2     Incomplete	             Incomplete
    check exceptions in dashboard         Warehouse sync problem       3     Pending Approval         Pending Approval
    check exceptions in dashboard         Warehouse sync problem       4     Pending Fulfillment         Pending fulfillment
    check exceptions in dashboard         Warehouse sync problem       5     Fulfilled        Tracking integrations notified

    check exceptions in dashboard         Aftership sync problem       2     Incomplete	             Incomplete
    check exceptions in dashboard         Aftership sync problem       3     Pending Approval         Pending Approval
    check exceptions in dashboard         Aftership sync problem       4     Pending Fulfillment         Pending fulfillment
    check exceptions in dashboard         Aftership sync problem       5     Fulfilled        Tracking integrations notified

    check exceptions in dashboard         Source sync problem       2     Incomplete	        Incomplete
    check exceptions in dashboard         Source sync problem       3     Pending Approval         Pending Approval
    check exceptions in dashboard         Source sync problem       4     Pending Fulfillment         Pending fulfillment
    check exceptions in dashboard         Source sync problem       5     Fulfilled        Tracking integrations notified

TC933 - CUSTOMER ACTIVITY
    check customs activity         HP
    check customs activity         Stuff company
    check customs activity         Google
    check customs activity         Globavend Labs
    check customs activity         batidedero
    check customs activity         PakoTeam LTD
    check customs activity         Android LTD
    check customs activity         PakoTeam LTD
    check customs activity         Android LTD


TC928 - PENDING FULFILLMENT ORDERS BY 3PL
    check PENDING FULFILLMENT      Geodis       Pending Fulfillment            Sent to 3PL

TC923 - Widgets at the top of the page
    check Widgets in Admin Panel         Incomplete
    check Widgets in Admin Panel         Pending Approval
    check Widgets in Admin Panel         Pending Fulfillment
    check Widgets in Admin Panel         Fulfilled













