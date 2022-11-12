*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${btn_language}    //button[@id="topbar-locale-dropdown"]/span
${btn_login}    //button[@aria-label="Log in"]
${lnk_omaposti}    //a[@aria-label="OmaPosti"]
${txt_loginpage}    //h1[text()="Posti Online Services"]

${btn_loginpage_login}    id:posti_login_btn
${txt_home}    //h3[text()="Home"]

*** Keywords ***
Select language    
    [Arguments]    ${language}
    Wait Until Element Is Visible    ${btn_language}    10s
    Click Element    ${btn_language}
    Wait Until Element Is Visible    id:${language}    5s
    Click Element    id:${language}


Click login and Select Omaposti
    Wait Until Element Is Visible    ${btn_login}    10s
    Click Element    ${btn_login}
    Wait Until Element Is Visible    ${lnk_omaposti}    5s
    Click Element    ${lnk_omaposti}
    Page Should Contain Element    ${txt_loginpage} 

Enter email address and password
    [Arguments]    ${email}    ${password}
    Set Log Level    NONE
    Input Text    id:username    ${email} 
    Set Log Level    INFO
    Input Password    id:password    ${password}
    Click Button    ${btn_loginpage_login}

Validate successful login
    Wait Until Element Is Visible    ${txt_home}    10s
    Page Should Contain Element    ${txt_home}