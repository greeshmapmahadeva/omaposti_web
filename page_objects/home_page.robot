*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Variables ***


*** Keywords ***
Remove globalError from the page_objects
     Wait Until Element Is Visible    //div[@id='globalError']     20s
     Click Element    (//button[@aria-label='Close'])[1]

Select document_type from the list
    [Arguments]    ${document_type}
    Click Button        //button[contains(@aria-label,"Show only")]
    Log    ${document_type}
    Wait Until Element Is Visible    //li[@value="${document_type}"]    5s
    Click Element    //li[@value="${document_type}"]


Count the number of inbox feeds and list the document type
    ${count}=    Get Element Count    (//button[contains(@class,"omaposti-core__sc") and @lang="en"])
    @{list_feed}=    Create List

    FOR    ${i}    IN RANGE    1    ${count}+1

        ${document_type}    Get Text    (//div[contains(@class,"omaposti-core__sc")]/span[text()="Shipment" or text()="Letter" or text()="Invoice"])
        Append To List    ${list_feed}    ${document_type}
    END

#    for the count, add the document types into the list
      Log    ${list_feed}
      Set Test Variable    ${list_feed}

Validate list_feed contains only the filtered type - Letter
        List Should Not Contain Value    ${list_feed}    Shipment
        List Should Not Contain Value    ${list_feed}    Invoice
       # List Should Not Contain Value    ${list_feed}    Letter

Validate list_feed contains only the filtered type - Shipment(parcel)
        List Should Not Contain Value    ${list_feed}    Letter 
        List Should Not Contain Value    ${list_feed}    Invoice
        

Validate list_feed contains only the filtered type - Invoice
        List Should Not Contain Value    ${list_feed}    Shipment 
        List Should Not Contain Value    ${list_feed}    Letter



Select a document from inbox and send it to archive
    #Click Element    (//span[text()="Shipment" or text()='Invoice' or text()='Letter'])[1]
    #use this locator - //button[@aria-haspopup='listbox'] for below
    [Arguments]    ${feed_id}
    Set Test Variable    ${feed_id}
    Click Element    //div[contains(@class,"omaposti-core__sc")] /span[text()="${feed_id}"]
    Sleep    1s
    Click Element    //div[contains(@class,"omaposti-core__sc")] /span[text()="${feed_id}"]
    Wait Until Element Is Visible    (//button[@aria-haspopup='listbox'])[2]
    Click Element    (//button[@aria-haspopup='listbox'])[2]
    Wait Until Element Is Visible    //p[text()="Archive"]
    Click Element    //p[text()="Archive"]
    Wait Until Element is Not visible      //div[contains(@class,"omaposti-core__sc")] /span[text()="${feed_id}"]    5s
    Element Should Not Be Visible    //div[contains(@class,"omaposti-core__sc")] /span[text()="${feed_id}"]

Select document from feed and delete the document
    [Arguments]    ${feed_id}
    Click Element    //div[contains(@class,"omaposti-core__sc")] /span[text()="${feed_id}"]
    Wait Until Element Is Visible    (//button[@aria-haspopup='listbox'])[2]
    Click Element    (//button[@aria-haspopup='listbox'])[2]
    Wait Until Element Is Visible    //p[text()="Delete"]
    Click Element    //p[text()="Delete"]
    Wait Until Element Is Visible    id:delete-button    5s
    Click Element    id:delete-button

Validate element is not visible in feed
    Wait Until Element is Not visible      //div[contains(@class,"omaposti-core__sc")] /span[text()="${feed_id}"]    5s
    Element Should Not Be Visible    //div[contains(@class,"omaposti-core__sc")] /span[text()="${feed_id}"]

Select a document from archive and send it back to inbox
    [Arguments]    ${feed_id}
    Click Element    //div[text()="Archive"]
    Wait Until Element Is Visible    //button[contains(@id,"${feed_id}")]
    Click Element    //button[contains(@id,"${feed_id}")]
    Sleep    1s
    Click Element    //button[contains(@id,"${feed_id}")]
    Wait Until Element Is Visible     (//button[@aria-haspopup='listbox'])[2]
    Click Element    (//button[@aria-haspopup='listbox'])[2]
    Wait Until Element Is Visible    //p[text()="Move to inbox"]
    Click Element    //p[text()="Move to inbox"]
    Sleep    5s
    Click Element    id:label-mainMenuInbox


Validate the items sent to archive and sent back to inbox from archives is same
    Wait Until Element Is Visible    //div[contains(@class,"omaposti-core__sc")] /span[text()="${feed_id}"]    5s
    Element Should Be Visible    //div[contains(@class,"omaposti-core__sc")] /span[text()="${feed_id}"]


Click on track and enter shipment_id 
    [Arguments]    ${shipment_id}
    Click Element    //button[@aria-label="Track item"]
    Wait Until Element Is Visible     id:add-parcel-tracking-code     5s
    Input Text    id:add-parcel-tracking-code    ${shipment_id}
    Click Element    //button/span/span[text()="Track item"]

   



Validate addition of shipment_id in feed
    [Arguments]    ${shipment_id}
    Wait Until Element Is Visible    //div[contains(@class,"omaposti-core__sc")] /span[text()="${shipment_id}"]    5s
    Element Should Be Visible    //div[contains(@class,"omaposti-core__sc")] /span[text()="${shipment_id}"]


Validate deleted shipment_id is not visible in feed
    [Arguments]    ${deleted_id}
    Wait Until Element is Not visible      //div[contains(@class,"omaposti-core__sc")] /span[text()="${deleted_id}"]    5s
    Element Should Not Be Visible    //div[contains(@class,"omaposti-core__sc")] /span[text()="${deleted_id}"]

Select multiple items using edit and Send selected items to archive
    [Arguments]    ${item_id_1}    ${item_id_2}
    Wait Until Element Is Visible    id:feedHeaderEditButton    5s
    Click Element    id:feedHeaderEditButton
    Click Element    //div[contains(@class,"omaposti-core__sc")] /span[text()="${item_id_1}"]
    Click Element    //div[contains(@class,"omaposti-core__sc")] /span[text()="${item_id_2}"]
    Click Element    id:feedEditActionsPanelArchiveButton

Validate selected items are in archive folder
    [Arguments]    ${item_id_1}    ${item_id_2}
    Click Element    //div[text()="Archive"]
    Wait Until Element Is Visible    //div[contains(@class,"omaposti-core__sc")] /span[text()="${item_id_1}"]    5s
    Element Should Be Visible    //div[contains(@class,"omaposti-core__sc")] /span[text()="${item_id_1}"]
    Element Should Be Visible    //div[contains(@class,"omaposti-core__sc")] /span[text()="${item_id_2}"]

Send selected items back to inbox from archive
    [Arguments]    ${item_id_1}    ${item_id_2}
    #Click Element    //div[text()="Archive"]
    
    Wait Until Element Is Visible    //button[contains(@id,"${item_id_1}")]
    Click Element    id:feedHeaderEditButton
    Click Element    //div[contains(@class,"omaposti-core__sc")] /span[text()="${item_id_1}"]
    Click Element    //div[contains(@class,"omaposti-core__sc")] /span[text()="${item_id_2}"]
    Click Element    id:feedEditActionsPanelArchiveButton
    # Wait Until Element Is Visible    //p[text()="Move to inbox"]
    # Click Element    //p[text()="Move to inbox"]
    Sleep    5s
    Click Element    id:label-mainMenuInbox

Navigate to the pickup point setting
    Click Element    id:label-mainMenuSettings
    Wait Until Element Is Visible    id:label-lowerMenuSettingsMyPickUpPoint    5s
    Click Element    id:label-lowerMenuSettingsMyPickUpPoint
    Wait Until Element Is Visible    //h4[text()='My pickup point']    5s

Enter the pickup point zip code and enable the pickup point
    [Arguments]    ${zip_code}
    Click Element    //button/span/span[text()='CHANGE']
    Wait Until Element Is Visible    //input[@placeholder='Enter postal code or address']    5s
    Input Text    //input[@placeholder='Enter postal code or address']    ${zip_code}
    Sleep    3s
    Click Element    //h4[text()='Posti, K-Citymarket Hyvinkää']

Validate the selected pickup point is enabled
    Sleep     5s
    Wait Until Element Is Visible    (//h4[text()='Posti, K-Citymarket Hyvinkää'])[2]    10s
    Scroll Element Into View    (//h4[text()='Posti, K-Citymarket Hyvinkää'])[2]
    Element Should Be Visible    (//h4[text()='Posti, K-Citymarket Hyvinkää'])[2]
    Scroll Element Into View    //input[@type='checkbox' and @aria-disabled='false']
    Capture Page Screenshot
