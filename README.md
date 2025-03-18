# diamond_task

A new Flutter project.

## Getting Started

This project is a starting TASK for a KGK Diamonds (I) Pvt. Ltd.

Project structure:- MVVM
lib/
│── main.dart
│── data/
│   ├── data.dart 
│   ├── diamond_model.dart  // Model for a Diamond
│── blocs/
│   ├── diamond_bloc.dart  // Handles filtering and sorting
│   ├── cart_bloc.dart  // Manages cart state
│── repository/
│   ├── diamond_repository.dart  // Handles data fetching & filtering
│── screens/
│   ├── filter_page.dart
│   ├── result_page.dart
│   ├── cart_page.dart
│── services/
│   ├── hive_service.dart  // Manages Hive DB initialization
└── utils/
│   ├── common_utilites.dart

State management logic:- BLoC for state management 

Persistent storage usage :- Hive database for handling of data to add/remove cart. 

For run the project run bellow command
flutter pub get

