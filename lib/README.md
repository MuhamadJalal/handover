# HandOver delivery App

### Table of Contents
- [System Requirements](#system-requirements)
- [Project Structure](#project-structure)
- [Libraries and tools used](#libraries-and-tools-used)

### System Requirements

Dart SDK Version 3.0.3  or greater.
Flutter SDK Version 3.10.4 or greater.

### Project Structure
After successful build, your application structure should look like this:

```
.
├── android                                       - contains files and folders required for running the application on an Android operating system.
├── assets                                        - contains all images and fonts of your application.
├── ios                                           - contains files required by the application to run the dart code on iOS platforms.
├── lib                                           - Most important folder in the project, used to write most of the Dart code.
    ├── di                                        - contains the dependencies injection.
    ├── helper                                    - contains all needed utils for the application
    ├── models                                    - contains all application's data models.
    ├── repository                                - App repository
    ├── view                                      - contains all screens and screen controllers
    │   └── common_widget                         - contains common widget over the application
    │   └── screens                               - contains all screens
    ├── view_model
    │   ├── barrel_view_model.dart                - contains commonly used file imports 
    │   ├── bus_driver_view_model.dart            - contains location services 
    │   ├── firebase_view_model.dart              - contains firebase services
    │   ├── language_view_model.dart              - contains language proccessing
    │   ├── local_notification_view_model.dart    - contains Locale notificaion services                  
    │   ├── rate_view_model.dart                  - contains rating utils
    │   └── splash_screen_view_model.dart         - contains intro screen services
    ├── localization                              - contains localization classes
    ├── firebase_options.dart                     - controlles all the firebase SDK configurations.
    ├── README.md                                 - About app.
    └── main.dart                                 - starting point of the application
```

### Libraries and tools used

- get - State management
  https://pub.dev/packages/get
- shared_preferences - Provide persistent storage for simple data
  https://pub.dev/packages/shared_preferences
- cached_network_image - For storing internet image into cache
  https://pub.dev/packages/cached_network_image
