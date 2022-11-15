*** Settings ***
Library    SeleniumLibrary
Resource    ../page_objects/login_page.robot
Resource    ../page_objects/home_page.robot
Resource    ../resources/utilities.robot
Suite Setup    Open browser and goto URL


*** Variables ***

${username}    ${user} 
${password}    ${pass}

${shipment_id}    JJFI234567898
${feed_id}    JJFI234567892
${item_id_1}     JJFI234567891
${item_id_2}    JJFI234567890
${zip_code}    05800


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

TC_04_Validate archive any product from Inbox and send those back to inbox from archives
    Select document_type from the list    all
    Select a document from inbox and send it to archive    ${feed_id}
    Select a document from archive and send it back to inbox    ${feed_id}
    Validate the items sent to archive and sent back to inbox from archives is same    

TC_09_User should be able to access Archive folder and send items back to inbox
    [Setup]     Run Keywords    Select document_type from the list  all
                ...    AND   Select a document from inbox and send it to archive        ${feed_id}
    Select a document from archive and send it back to inbox        ${feed_id}
    Validate the items sent to archive and sent back to inbox from archives is same 

TC_05_Validate Click on track to add JJFI234567893 to the tracking and it should be immediately visible on feed
    Click on track and enter shipment_id     ${shipment_id}
    Validate addition of shipment_id in feed    ${shipment_id}


TC_06_Deleted shipment Letters or Invoices should not be visible and retrievable
    Select document from feed and delete the document    ${shipment_id}
    Validate deleted shipment_id is not visible in feed    ${shipment_id}

TC_08_User should be able to edit multiple items using edit option and selecting the item to be edited
    Select multiple items using edit and Send selected items to archive    ${item_id_1}    ${item_id_2}
    Validate selected items are in archive folder    ${item_id_1}    ${item_id_2}
    [Teardown]    Send selected items back to inbox from archive    ${item_id_1}    ${item_id_2}

TC_10_User should be able to find out and set nearest Posti Pickup point using the Zip code
    Navigate to the pickup point setting
    Enter the pickup point zip code and enable the pickup point    ${zip_code}
    Validate the selected pickup point is enabled

    
