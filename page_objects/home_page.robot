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
        
