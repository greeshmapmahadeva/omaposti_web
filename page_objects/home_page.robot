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
    Wait Until Element Is Visible    (//button[@aria-haspopup='listbox'])[2]
    Click Element    (//button[@aria-haspopup='listbox'])[2]
    Wait Until Element Is Visible    //p[text()="Archive"]
    Click Element    //p[text()="Archive"]
    Wait Until Element is Not visible      //div[contains(@class,"omaposti-core__sc")] /span[text()="${feed_id}"]    5s
    Element Should Not Be Visible    //div[contains(@class,"omaposti-core__sc")] /span[text()="${feed_id}"]


Select a document from archive and send it back to inbox
    [Arguments]    ${feed_id}
    Click Element    //div[text()="Archive"]
    Wait Until Element Is Visible    //button[contains(@id,"${feed_id}")]
    Click Element    //button[contains(@id,"${feed_id}")]
    Wait Until Element Is Visible     (//button[@aria-haspopup='listbox'])[2]
    Click Element    (//button[@aria-haspopup='listbox'])[2]
    Wait Until Element Is Visible    //p[text()="Move to inbox"]
    Click Element    //p[text()="Move to inbox"]
    Sleep    5s
    Click Element    id:label-mainMenuInbox


Validate the product sent to archive and sent back to inbox from archives is same
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