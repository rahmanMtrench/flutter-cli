
---

# Flutter Feature and Model Generator CLI

A command-line tool to help you quickly generate features and models for your Flutter projects using `Bloc` and `GoRouter` structures.

## Features

- Initialize project structure with `core` and `config` directories.
- Generate new features with a Bloc, pages, widgets, and models.
- Generate Dart models from JSON data or files.
- Automatically add routes to `routes.dart`.
- Handles PascalCase and snake_case conversions for feature names.

## Installation

Clone the repository:

```bash
dart pub global activate flutter_cli_tool
```

## Usage

### 1. Initialize the Project

This command initializes the project with the `core` and `config` directories and creates a `main.dart` file.

```bash
flutter_cli_tool --init
```

Example:

```bash
flutter_cli_tool --init
```

### 2. Create a Feature

To generate a new feature, use the `--feature` (or `-f`) flag. The feature name will be converted to PascalCase for internal usage and snake_case for folder names.

```bash
flutter_cli_tool --feature "hello world"
```

- This creates a feature named `HelloWorld` in the `lib/features/hello_world` folder with the following structure:
  ```
  lib/
  └── features/
      └── hello_world/
          ├── bloc/
          ├── pages/
          ├── widgets/
          └── models/
  ```

### 3. Create a Model from JSON

To generate a model, you can provide JSON data or the path to a JSON file using the `--model` (or `-m`) and `--json` (or `-j`) flags.

Example 1: Create a `User` model from JSON data:

```bash
flutter_cli_tool_tool --model User --json ./path/to/user.json
```

Example 2: Create a `Profile` model from a JSON file and place it inside a specific feature folder:

```bash
flutter_cli_tool_tool --model Profile --json ./path/to/user.json --featureModel profile
```

### 4. Help

To see a list of available commands and options:

```bash
flutter_cli_tool_tool --help
```

---

### Examples of Generated Code

#### `main.dart` Example:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        // BlocProviders will be inserted here dynamically
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerDelegate: createRouter().routerDelegate,
        routeInformationParser: createRouter().routeInformationParser,
      ),
    );
  }
}
```

#### Model Example:

```dart
class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  User copyWith({int? id, String? name, String? email}) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id && other.name == name && other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode;
}
```

---

### License

[MIT License](LICENSE)

---
