*** Settings ***
Documentation                           FloShip UI testing Client part
Resource                                resource.robot
Suite Setup                             Setup Tests
Suite Teardown                          Close All Browsers




*** Test Cases ***
TC825 - Preparing (create client)
    [Tags]                        CreateUser
    ${email}=                     Get Email Client     ${cli_role}
    set suite variable            ${rand_client}        ${email}
    log to console                ${rand_client}
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
    Create User                   ${rand_client}              12345678             12345678
    wait until page contains      The user "${rand_client}" was added successfully. You may edit it again below.
    Settings User                ${ch_name}    	${ch_lname}        ${rand_client}
    click element                 name=_save
    wait until page contains      The user "${rand_client}" was changed successfully.
    ${client_}=                   Get Rand ID           ${client_role}
    ${rand_refer_client}=                Get Rand ID        ${refer}
    set suite variable            ${client_name}    ${client_}
    log to console                ${client_name}
    Go To                         ${ADMIN}floship/client/
    Create Client                ${client_}        ${rand_client}            ${rand_client}       ${rand_refer_client}
    wait until page contains      The client "${client_}" was added successfully


TC897 - Add new notification (empty fields)
     Go To               ${ADMIN}
     #Login                           ${login_admin}         ${pass_admin}
     mouse over and click         Settings                /admin-backend/client_notifications/clientnotification/
     wait until page contains              Select client notification to change
     wait element and click          xpath=//a[contains(.,"Add client notification")]
    wait until page contains        Add client notification
    click button                    name=_save
    wait error this is required (Admin)         Title          This field is required
    wait error this is required (Admin)         Text          This field is required


TC898 - Add new notification for User (Info)
    Go To                          ${ADMIN}client_notifications/clientnotification/add/
    wait until page contains       Add client notification
    input text                     id=id_title                     New Info notification
    input text                     id=id_text                     New label for Info notification
    input text                     id=id_link          ${SERVER}
    click button                    name=_save
    wait until page contains       The client notification "info - New Info notification - New label for Info notification" was added successfully.
    show in table                  Info         New Info notification           New label for Info notification          Unpublished


TC899 - Public notification for User
    Go To                        ${ADMIN}client_notifications/clientnotification/
    Check Item in Search          New Info notification
    Open Check Order              Info
    wait until page contains      Change client notification
    wait element and click        name=_fsmtransition-status-publish
   wait until page contains       Info - New Info notification - New label for Info notification successfully set to Published
      Go To                       ${ADMIN}client_notifications/clientnotification/
    show in table                  Info         New Info notification           New label for Info notification          Published
    Logout Client

TC899 - Public notification for User (Check notification in Client)
    Go To                             ${SERVER}
    Login                            ${rand_client}                   12345678
    wait until page contains         New Info notification
    wait until page contains         New label for Info notification
    wait until page contains element         xpath=//a[contains(.,"View more")]
    Logout Client



TC900 - Add new notification for Administrator (Danger)
    Go To                          ${ADMIN}client_notifications/clientnotification/add/
    Login                           ${login_admin}         ${pass_admin}
    wait until page contains       Add client notification
    Select Fields                  Special for             Administrators            Administrators
    Select Fields                  Alert type            Danger              Danger
    input text                     id=id_title                    New Danger notification
    input text                     id=id_text                     New label for Danger notification
    click button                    name=_save
    wait until page contains       The client notification "danger - New Danger notification - New label for Danger notification" was added successfully.
    show in table                  Danger         New Danger notification           New label for Danger notification          Unpublished

TC901 - Public notification for Administrator
    Go To                        ${ADMIN}client_notifications/clientnotification/
    Check Item in Search          New Danger notification
    Open Check Order              Danger
    wait until page contains      Change client notification
    wait element and click        name=_fsmtransition-status-publish
    wait until page contains       Danger - New Danger notification - New label for Danger notification successfully set to Published
    wait until page contains         New Danger notification
    wait until page contains         New label for Danger notification
    wait until page does not contain element         xpath=//a[contains(.,"View more")]
    Go To                       ${ADMIN}client_notifications/clientnotification/
    show in table                  Info         New Info notification           New label for Info notification          Published

TC910 - Edit notification for User (Warning)
    Go To                          ${ADMIN}client_notifications/clientnotification/add/
    #Login                           ${login_admin}         ${pass_admin}
    wait until page contains       Add client notification
    Select Fields                  Special for             Administrators            Administrators
    input text                     id=id_title                    New Info notification Admin
    input text                     id=id_text                     New label for Info notification Admin
    input text                     id=id_link          ${SERVER}
    click element                  css=label.vCheckboxLabel
    click button                   name=_save
    wait until page contains       The client notification "info - New Info notification Admin - New label for Info notification Admin" was added successfully
    show in table                  Info         New Info notification Admin           New label for Info notification Admin          Unpublished
    Check Item in Search         New Info notification Admin
    Open Check Order              Info
    Select Fields                  Special for            User           User
    Select Fields                  Alert type            Warning             Warning
    input text                     id=id_title                    New Warning notification
    input text                     id=id_text                     New label for Warning notification
    clear element text                     id=id_link
    click element                  css=label.vCheckboxLabel
    click button                    name=_save
    wait until page contains       The client notification "warning - New Warning notification - New label for Warning notification" was changed successfully
    Go To                           ${ADMIN}client_notifications/clientnotification/
    show in table                  	Warning	           New Warning notification	           New label for Warning notification         Unpublished


TC911 - Edit notification for Administrator (Success)
    Go To                          ${ADMIN}client_notifications/clientnotification/add/
    wait until page contains       Add client notification
    Select Fields                  Alert type            Danger              Danger
    input text                     id=id_title                    New Danger notification User
    input text                     id=id_text                     New label for Danger notification User
    click element                  css=label.vCheckboxLabel
    click button                    name=_save
    wait until page contains       The client notification "danger - New Danger notification User - New label for Danger notification User" was added successfully
    Go To                           ${ADMIN}client_notifications/clientnotification/
    show in table                  Danger	   New Danger notification User	        New label for Danger notification User         Unpublished
    Check Item in Search          New Danger notification User
    Open Check Order              Danger
    Select Fields                  Special for            Administrator             Administrator
    Select Fields                  Alert type            Success            Success
    input text                     id=id_title                    New Success notification
    input text                     id=id_text                    New label for Success notification
    click element                  css=label.vCheckboxLabel
    click button                    name=_save
    wait until page contains       The client notification "success - New Success notification - New label for Success notification" was changed successfully
    Go To                           ${ADMIN}client_notifications/clientnotification/
    show in table                  	Success	         New Success notification	       New label for Success notification         Unpublished


TC904 - Public notifications (Warning)
    Go To                          ${ADMIN}client_notifications/clientnotification/
    Check Item in Search           New label for Warning notification
    Open Check Order               Warning
    wait until page contains      Change client notification
    wait element and click        name=_fsmtransition-status-publish
    wait until page contains       Warning - New Warning notification - New label for Warning notification successfully set to Published
    Logout Client

    Login                        client+ksjiorqj@floship.com             12345678
    wait until page contains         New Warning notification
    wait until page contains         New label for Warning notification
    wait until page does not contain element         xpath=//a[contains(.,"View more")]
    Logout Client


TC904 - Public notifications (Success)
    Go To                       ${ADMIN}client_notifications/clientnotification/
    Login                          ${login_admin}         ${pass_admin}
    Check Item in Search        New Success notification
    Open Check Order            Success
    wait element and click        name=_fsmtransition-status-publish
    wait until page contains       Success - New Success notification - New label for Success notification successfully set to Published
    wait until page contains         New Success notification
    wait until page contains         New label for Success notification
    wait until page does not contain element         xpath=//a[contains(.,"View more")]

TC912 - "Stack" notifications
    Go To                       ${ADMIN}client_notifications/clientnotification/
    Check Item in Search        New Success notification
    Open Check Order            Success
    wait element and click      css=label.vCheckboxLabel
    click button                    name=_save
    wait until page contains     The client notification "success - New Success notification - New label for Success notification" was changed successfully.
    wait until page contains         New Danger notification
    wait until page contains         New label for Danger notification
    wait until page does not contain element         xpath=//a[contains(.,"View more")]

TC907 - Sorting
  Go To                       ${ADMIN}client_notifications/clientnotification/
  Sorting for FAD                           Alert type         Danger        	Warning

TC908 - Filters
   Go To                       ${ADMIN}client_notifications/clientnotification/
   Check Filter                4         Users
   show in table               	Warning	             New Warning notification	      New label for Warning notification        Published
   Check Filter                2         Yes
   show in table               	Warning	             New Warning notification	      New label for Warning notification        Published
   Check Filter                3         Warning
   show in table               	Warning	             New Warning notification	      New label for Warning notification        Published
   Check Filter                1         Unpublished
   wait until page contains       0 client notifications


TC905 - Delete notification
  Go To                       ${ADMIN}client_notifications/clientnotification/
  Check Item in Search         New Danger notification
  Open Check Order            	Danger
  wait element and click        xpath=//a[contains(.,"Delete")]
  wait until page contains      Are you sure you want to delete the client notification "danger - New Danger notification - New label for Danger notification"?
  wait element and click        xpath=//*[@value="Yes, I'm sure"]
  wait until page contains      The client notification "danger - New Danger notification - New label for Danger notification" was deleted successfully.

TC906 - Bulk action
  Go To                       ${ADMIN}client_notifications/clientnotification/
  #Login                           ${login_admin}         ${pass_admin}
  choose checkbox          Success    New Success notification            New label for Success notification
  choose checkbox          Warning    New Warning notification            	New label for Warning notification
  choose checkbox          Info       New Info notification            	New label for Info notification
  wait until page contains          3 of
  Delete                   Delete selected client notifications
