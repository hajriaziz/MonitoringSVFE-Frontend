# smtmonitoring
### Table of contents
- [System requirements](#system-requirements)
- [Figma design guidelines for better UI accuracy](#figma-design-guideline-for-better-accuracy)
- [Check the uI of the entire app](#app-navigations)
- [Application structure](#project-structure)
- [How to format your code?](#how-you-can-do-code-formatting)
- [How you can improve code readability?](#how-you-can-improve-the-readability-of-code)
- [Libraries and tools used](#libraries-and-tools-used)
- [Support](#support) 

### System requirements

Dart SDK version 3.3.2 or greater.
Flutter SDK version 3.19.4 or greater.

### Figma design guidelines for better UI accuracy
 
Read our guidelines to increase the accuracy of design-to-code conversion by optimizing Figma designs.
https://docs.dhiwise.com/docs/Designguidelines/intro 

### Check the uI of the entire app

Check the uI of all the app screens from a single place by setting up the 'initialRoute' to AppNavigation in the AppRoutes.dart file.

### Application structure

After successful build, your application structure should look like this: 

|--android     - It contains files required to run the application on an Android platform.
|--assets      - It contains all images and fonts of your application.
|--ios         - It contains files required to run the application on an iOS platform.
|-- lib        - Most important folder in the application, used to write most of the Dart code..
    |-- main.dart    -Starting point of the application 
    |-- core         - It contains commonly used file imports.  
        |-- app_ export.dart   - It contains common files and utilities of the application 
        |-- constants          - It contains static constant class file
        |-- utils              - It contains common files and utilies of the application
    |-- presentation   - It contains widgets of the screens         
    |--routes          - It contains all the routes of the application
    |-- theme          - It contains app theme and decoration classes
    |-- widgets        - It contains all custom widget classes
    
       
### How to format your code? 

 - if your code is not formatted then run following command in your terminal to format code 

   dart format . 

### How you can improve code readability?

Resolve the errors and warnings that are shown in the application.

### Libraries and tools used 

- Provider - State management
https://pub.dev/packages/provider 
- cached network image - For storing internet image into cache https://pub.dev/packages/cached network image 

### Support 

If you have any problems or questions, go to our Discord channel, where we will help you as quickly as possible: https://discord.com/invite/rFmnCG5MZ7 


