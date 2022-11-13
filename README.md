##TEST CASES

Navigate to https://www.posti.fi/fi    select Omaposti

log in using your own credentials  if you don’t have your won creds created yet follow the process to create a new consumer account by selecting Create a new consumer account

once you are In OmaPosti web

Click load all your Inbox feeds
Testcase :

1)while using Filter for letters only letters should be visible in the feed

2) While using Filter for Parcels only parcels should load in the feed

3) Invoice if any should be only visible applying Invoice filter

4) User can archive any product from Inbox and send those back to inbox from archives

5)User should Click on track to add JJFI234567890 to the tracking and it should be immediately visible on feed

6) Deleted shipment Letters or Invoices should not be visible and retrievable

7)Adding an invoice manually should be possible by using Omaposti app

8) User should be able to edit multiple items using edit option and selecting the item to be edited

9)User should be able to access Archive folder and send items back to inbox

10) User should be able to find out and set nearest Posti Pickup point using the Zip code






${count}=    Get Element Count    //button[contains(@class, 'omaposti-core__sc') and @lang='en']

#     @{list_feed}=    Create List

    
#     FOR    ${i}    IN RANGE    1    ${count}+1    
#         ${document_type}=     Get Text    (//div[contains(@class,'omaposti-core__sc')]/span[text()='Shipment' or text()='Letter' or text()='Invoice'])[${i}]
#         Append To List    ${list_feed}    ${document_type}
        
#     END