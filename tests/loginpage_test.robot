*** Settings ***
Library    SeleniumLibrary
Resource    ../page_objects/login_page.robot
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
    



    
