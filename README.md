# biometric_dashboard

A new Flutter project.

## Getting Started

This project is using biometric authentication to go to the home page,
On the home page, we fetch 2 different data at the same time, one for showing quote of the day and another
to fetch news,
this data will be able to wait for the internet to comes back if there is an error in connecting and then fetch data,
if the touch id is wrong and you try this 5 times we have to wait 30 seconds or lock and unlock your device manually.
please read the error that will fetch on your screen !!! 

### N.B: 

local_auth package v.1.1.0 has an error please keep 0.6.3+4 version now, and if you want to use this package please make the changes that I made in MainActivity.kt file or copy it to your one project.


## Uncle Bob architecture

In order to arrange your code and to make it easier to implement other code we divide the project into 3 differents section:

### Models

The Model contains all the classes that I want to store execute and fetch, with repositories and services that I get the response back by a new reserved object.

### Domain

The Domain contains repositories and services

### Presentation

And finally,the presentation containes the bloc and the widgets folder:

1- Bloc is the middleware between domain,models and UI, moreover, it controls views and fetches into the last our models.

2- Widgets is where I found the interface that I want to figure out, here we set objects into UI.

and we have 2 additional folders one for images and named "assets" other for the "core" of my project that contains global and static functions or variables.



Please if you have questions don't hesitate to contact me.


N.B : you have to choose the master branch


Edward Mansour
