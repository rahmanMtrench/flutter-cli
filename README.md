Here’s a sample `README.md` documentation for your CLI tool, explaining its usage with examples:

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
git clone https://github.com/your-repo/flutter-cli-tool.git
cd flutter-cli-tool
```

## Usage

### 1. Initialize the Project

This command initializes the project with the `core` and `config` directories and creates a `main.dart` file.

```bash
dart cli.dart --init
```

Example:

```bash
dart cli.dart --init
```

### 2. Create a Feature

To generate a new feature, use the `--feature` (or `-f`) flag. The feature name will be converted to PascalCase for internal usage and snake_case for folder names.

```bash
dart cli.dart --feature "hello world"
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
dart cli.dart --model User --json '{"id": 1, "name": "John", "email": "john@example.com"}'
```

Example 2: Create a `Profile` model from a JSON file and place it inside a specific feature folder:

```bash
dart cli.dart --model Profile --json ./path/to/user.json --featureModel profile
```

### 4. Help

To see a list of available commands and options:

```bash
dart cli.dart --help
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

This `README.md` provides instructions on how to use your CLI tool, including examples of each command and how it works.