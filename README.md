# OMAPOSTI WEB Project

## Prerequisite

Navigate to https://www.posti.fi/fi    select Omaposti

log in using your own credentials  if you don’t have your won creds created yet follow the process to create a new consumer account by selecting Create a new consumer account

once you are In OmaPosti web

Click load all your Inbox feeds




## Test Cases and Robot Script

###Testcase and corresponding Robot Scripts:

1. while using Filter for letters only letters should be visible in the feed - 
    **TC_01_Validate Filter for letters - only letters should be visible in the feed**


2. While using Filter for Parcels only parcels should load in the feed -
    **TC_02_Validate Filter for parcels - only parcel should be visible in the feed**

3. Invoice if any should be only visible applying Invoice filter - 
    **TC_03_Validate Filter for invoice - only invoice should be visible in the feed**

4. User can archive any product from Inbox and send those back to inbox from archives - 
    **TC_04_Validate archive any product from Inbox and send those back to inbox from archives**

5. User should Click on track to add JJFI234567890 to the tracking and it should be immediately visible on feed - 
    **TC_05_Validate Click on track to add JJFI234567893 to the tracking and it should be immediately visible on feed**



6. Deleted shipment Letters or Invoices should not be visible and retrievable - **TC_06_Deleted shipment Letters or Invoices should not be visible and retrievable**

7. Adding an invoice manually should be possible by using Omaposti app - 
    


8. User should be able to edit multiple items using edit option and selecting the item to be edited - 
    **TC_08_User should be able to edit multiple items using edit option and selecting the item to be edited**


9. User should be able to access Archive folder and send items back to inbox - 
    **TC_09_User should be able to access Archive folder and send items back to inbox**

10. User should be able to find out and set nearest Posti Pickup point using the Zip code -     **TC_10_User should be able to find out and set nearest Posti Pickup point using the Zip code**


# How to run the execution


`robot -v user: ${username} -v pass:${password} -d reports tests/homepage_test.robot`

The values of variables can be edited as per requirement.

## List of variables
- ${username}    ${user}
- ${password}    ${pass}

- ${shipment_id}     *JJFI234567898*
- ${feed_id}    *JJFI234567892*
- ${item_id_1}     *JJFI234567891*
- ${item_id_2}    *JJFI234567890*
- ${zip_code}    *05800*

# Folder Structure

1. tests - All test cases
2. page objects - All page objects related keywords
3. resources - utilities
4. reports - All reports