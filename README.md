# Utilities Software 

Utilities app for connection customers and protable water providers in countries suffer from lack of portable water services.
the customer can order protable water from his provider or any other provider in his area, following his provider truck on map.
using this app makes the proccess of getting clean water easier and faster !


## Table of contents
*About the Project
*General Preview
*Short discription
*Team
*Installation Guidelines (if applicable)
*Promotional Video
*Description
*Screenshots
*Disclaimer
*License
*Table

## GENERAL PREVIEW Utilities 
<img src="https://i.ibb.co/XZYFHTh/4a5c2c0a-d44a-490b-b4f2-0ade1f7da362.jpg" width="280" height="470" /> | <img src="/5ea8ef8d-e2f4-47a8-9218-824b5761562d.jfif" width="280" height="470" float="100" /> | <img src="/1be7acac-9723-44e5-ab77-449689d0bb88.jfif" width="280" height="470" /> 
 


## About the Project
The project is built using flutter cross platform which supports both Android & ios mobile operating systems
aiming to cover the largest number of mobile applications users.



## List of the Contributors on GitHub (Team)
[Basel Hadrous](https://github.com/byshy)
[Mohammad Isleem](https://github.com/mohammadeslim22)

## Installation Guidelines (if applicable)
the project is built on Android Studio platform, you need to download the Studio & sdk for android beside Java as well
then you need to set up the Emulator to test the android or you can do that on a real device by USB Debugging 



## Promo Video (Click for full video)
[![IMAGE ALT TEXT HERE](http://img.youtube.com/vi/UfQFs5SrogU/0.jpg)](https://youtu.be/UfQFs5SrogU)

## Description
Overall function of the app: deliver basic utilities like water and gas to customers.
What we used in development:
-	BLoC state management
-	Shared preferences
-	SQLite DBMS
-	Firebase
-	Google maps
How did we use them?
-	The state management solution was present at the very beginning of the app, 
since it will handle all the API requests and database queries for now (will be changed later).
-	Shared preferences is primarily used for caching the user and app settings.
-	SQLite is used to store the orders locally so that the user can check them even when offline.
-	Firebase, we used it for storage, real time notifications and providing authentication for the users, 
we only used the authentication by e-mail and password for the time being, we may add logging in using google account or even Facebook. 
Real time notifications are triggered from the customer app and are delivered to the providers phone using the unique id that the provider have.
The storage part holds the user’s info (customers or providers) and the orders for the providers.
-	Google maps are used to show the customer where the providers are and help him to choose where to deliver his order.
User Journey:
-	Users start by creating a new account which will be transferred to firebase to get handled, 
all error codes from firebase are handled inside the app, after that the home screen pops up automatically, 
or Users can login straight away if they already have an account, 
the app remembers if the user is logged in or not using the shared preferences from there they can find a list of providers 
as long as they are not subscribed to any provider, once they subscribe to a provider, 
he will be displayed on the main screen when the user open the app again.
-	Inside the provider screen the user can find the new order button, the repeat last order button and a list of previous orders 
with their details (quantity ordered, date, price), also the user can find contact information of the provider which will automatically get copied to the dialer app to make the process faster.
-	Past orders screen displays all orders of the customer from all the providers sorted using the date, speaking of sorting, 
the providers list will display providers sorted using their location starting from the nearest.
NOTE: the application in its current state sends a notification to every provider on the platform since we made a category called providers in firebase and made the provider subscribe to it, 
after the submission this will be changed.

## Screenshots
 
<img src="/61bdbcc8-be23-42ee-827f-e1aaf2a6c329.jfif" width="280" height="470" /> | <img src="/ec6b8f14-6a00-4dcc-906b-636ec8fdb226.jfif" width="280" height="470" float="100" /> 


<img src="/4a099a1b-765a-46d4-ab2d-c3150d3838a9.jfif" width="280" height="470" /> | <img src="/9b8d0f48-a5fd-4a7d-a1a1-2aabddcb1c62.jfif" width="280" height="470" float="100" />   | <img src="/2.jfif" width="280" height="470" />


<img src="/app_video1.jfif" width="280" height="470" /> | <img src="/60d6aa87-c012-47c1-b255-0cd26ee078b9.jfif" width="280" height="470" float="100" />  | <img src="/4a5c2c0a-d44a-490b-b4f2-0ade1f7da362.jfif" width="280" height="470" />

<img src="/5ea8ef8d-e2f4-47a8-9218-824b5761562d.jfif" width="280" height="470" /> | <img src="/ea16d4bc-7876-4ffa-b585-2384bd603ac0.jfif" width="280" height="470" float="100" />  | <img src="/faa742f9-7182-4f8f-b33f-f69fa9e7226b.jfif" width="280" height="470" />


## Disclaimer
Voluny is a product designed and developed by Marton Zeisler and Uyen Vicky Vo. All photos used in the app or promotional collaterals are open-source and royalty free from Unsplash.com.

## Summary
| Utilities Software  | Utilities | Team Name: Utilities Software | Utilities Software project service provider connticting customers with portable water & gas providers in the country  | LICENSE |Mohammad Isleem | Basel Hadrous
