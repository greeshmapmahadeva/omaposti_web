*** Settings ***
Library    SeleniumLibrary
Resource    ../page_objects/login_page.robot
Resource    ../page_objects/home_page.robot
Resource    ../resources/utilities.robot
Suite Setup    Open browser and goto URL


*** Variables ***

${username}    ${user} 
${password}    ${pass}

*** Test Cases ***
Validate successful login into homepage
    Select language    EN
    Click login and Select Omaposti
    Enter email address and password       ${username}    ${password}
    Validate successful login
    
TC_01_Validate Filter for letters - only letters should be visible in the feed
    Select document_type from the list    letter
    Count the number of inbox feeds and list the document type
    Validate list_feed contains only the filtered type - Letter


TC_02_Validate Filter for parcels - only parcel should be visible in the feed
    Select document_type from the list    parcel
    Count the number of inbox feeds and list the document type
    Validate list_feed contains only the filtered type - Shipment(parcel)

TC_03_Validate Filter for invoice - only invoice should be visible in the feed
    Select document_type from the list    invoice
    Count the number of inbox feeds and list the document type
    Validate list_feed contains only the filtered type - Invoice



    
