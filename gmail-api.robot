*** Settings ***
Documentation                           FloShip UI testing
Resource                                resource.robot
Suite Setup                             Setup Tests
Suite Teardown                          Close All Browsers
*** Test Cases ***


## B2C Piece pick rates

Password reset unsuccessful
    [Tags]                    Pass
    Open Mailbox                        host=${MAIL_HOST}       user=${MAIL_USER}          password=${MAIL_PASSWORD}
    ${LATEST}=	             Wait for Mail	        	    recipient=auto.testfloship1@gmail.com	       timeout=10
    ${body}=	             get email body	       ${LATEST}
    #log to console           ${body}
    ${pass_link}=	             Get Mail link Gmail  	      ${body}    /password/reset       \r\n      ${SERVER}/password/reset
    log to console           ${pass_link}
    #Delete Email                         ${LATEST}
    Close Mailbox
    Go To                               ${pass_link}
    wait until page contains           Password reset unsuccessful


Welcome to Floship
    [Tags]                        Welcome
    Open Mailbox                        host=${MAIL_HOST}       user=${MAIL_USER}          password=${MAIL_PASSWORD}
    ${LATEST}=	             Wait for Mail	        	    recipient=auto.testfloship1+wvturfmy@gmail.com.	       timeout=30
    ${HTML}=	      get email body	${LATEST}
    should contain        "${HTML}"      Dear user_12345!
    should contain        "${HTML}"      Your username is: auto.testfloship1+wvturfmy@gmail.com.
    should contain        "${HTML}"      Welcome to Floship! Thanks so much for joining us
    ${pass_link}=	             Get Mail link Gmail  	      ${HTML}    /password/reset       \r\n      ${SERVER}/password/reset
    log to console           ${pass_link}
    Delete Email                         ${LATEST}
    Close Mailbox


# A notification will be sent to you within 24 hours once your warehouse assignment is completed.
# Congratulations the Floship onboarding process has now been completed
ASN was approved (check mail)
    [Tags]                        Approved
    Open Mailbox                        host=${MAIL_HOST}       user=${MAIL_USER}          password=${MAIL_PASSWORD}
    ${LATEST}=	             Wait for Mail	        	    recipient=auto.testfloship1@gmail.com	       timeout=30
    ${HTML}=	      get email body	${LATEST}
    should contain        "${HTML}"      ASN FASN0001605: Approved
    should contain        "${HTML}"      Your ASN has been Approved
    should contain        "${HTML}"      Dear mycompany_16163044
    Delete Email                         ${LATEST}
    close mailbox