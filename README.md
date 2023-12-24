# Homework 5

This is a Flutter project that demonstrates various functionalities such as welcome screen, user list, and saved user list.

## Getting Started

To run this project locally, please follow the instructions below.

### Prerequisites

Before running the project, make sure you have the Flutter and Dart SDK are installed on your machine.

### Explaination

The project consists of the following main parts:

- **lib/main.dart**: The entry point of the application. It initializes the Flutter app and defines the `MyApp` widget.
- **lib/screens/welcome_screen.dart**: The welcome screen of the application. It displays a welcome message and a button to continue.
- **lib/screens/user_list_screen.dart**: The user list screen. It shows a list of users and a button for performing an action.
- **lib/screens/saved_user_list_screen.dart**: The saved user list screen. It displays a list of users loaded from a file.

Each screen is implemented as a `StatefulWidget` to manage its own state and update the UI accordingly. The screens use various Flutter widgets, such as `Scaffold`, `AppBar`, `Text`, and `ElevatedButton`, to create the user interface.

The project also utilizes external packages, including `shared_preferences` for storing user preferences, `http` for making HTTP requests, and `sqflite` for database operations.

