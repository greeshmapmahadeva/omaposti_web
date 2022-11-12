*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://www.posti.fi/fi  
${browser}    Chrome


*** Keywords ***
Open browser and goto URL
    Open Browser    ${URL}    ${browser}
    Maximize Browser Window

    Wait Until Element Is Visible    id:onetrust-accept-btn-handler    10s
    Click Element    id:onetrust-accept-btn-handler
    
