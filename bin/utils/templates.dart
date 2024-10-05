

import 'helpers.dart';

// Main Template with GoRouter and MultiBlocProvider
String mainTemplate() {
  return '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/home/bloc/home_bloc.dart';
import 'config/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
''';
}

// BLoC Template
String blocTemplate(String featureName) {
  return '''
import 'package:bloc/bloc.dart';

part '${featureName}_event.dart';
part '${featureName}_state.dart';

class ${featureName.capitalize()}Bloc extends Bloc<${featureName.capitalize()}Event, ${featureName.capitalize()}State> {
  ${featureName.capitalize()}Bloc() : super(${featureName.capitalize()}Initial()) {
    on<${featureName.capitalize()}Event>((event, emit) {
      // TODO: implement event handler
    });
  }
}
''';
}

// Event Template
String eventTemplate(String featureName) {
  return '''
part of '${featureName}_bloc.dart';
abstract class ${featureName.capitalize()}Event {}

class ${featureName.capitalize()}Started extends ${featureName.capitalize()}Event {}
''';
}

// State Template
String stateTemplate(String featureName) {
  return '''
part of '${featureName}_bloc.dart';
abstract class ${featureName.capitalize()}State {}

class ${featureName.capitalize()}Initial extends ${featureName.capitalize()}State {}
''';
}

// Page Template
String pageTemplate(String featureName) {
  return '''
import 'package:flutter/material.dart';

class ${featureName.capitalize()}Page extends StatelessWidget {
const ${featureName.capitalize()}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('${featureName.capitalize()} Page')),
      body: const Center(
        child: Text('Welcome to the $featureName page!'),
      ),
    );
  }
}
''';
}

// Route Template
String routeTemplate() {
  return '''
import 'package:go_router/go_router.dart';
// DO NOT REMOVE THIS COMENT
// Page Imports

GoRouter createRouter() {
  return GoRouter(
   initialLocation: '/home',
    routes: [
      // Routes will be added here dynamically
    ],
  );
}
''';
}


// String modelTemplate(String modelName, Map<String, dynamic> jsonContent) {
//   final fields = jsonContent.keys.map((key) {
//     final type = _getDartType(jsonContent[key]);
//     return '  final $type $key;';
//   }).join('\n');

//   final constructorParams =
//       jsonContent.keys.map((key) => 'required this.$key').join(', ');

//   return '''
// class ${modelName.capitalize()} {
// $fields

//   ${modelName.capitalize()}({
//     $constructorParams
//   });

//   factory ${modelName.capitalize()}.fromJson(Map<String, dynamic> json) {
//     return ${modelName.capitalize()}(
//       ${jsonContent.keys.map((key) => '$key: json[\'$key\']').join(',\n      ')}
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       ${jsonContent.keys.map((key) => '\'$key\': $key').join(',\n      ')}
//     };
//   }
// }
// ''';
// }


String modelTemplate(String modelName, Map<String, dynamic> jsonContent) {
  final fields = jsonContent.keys.map((key) {
    final type = _getDartType(jsonContent[key]);
    return '  final $type $key;';
  }).join('\n');

  final constructorParams =
      jsonContent.keys.map((key) => 'required this.$key').join(', ');

  final copyWithParams = jsonContent.keys.map((key) {
    final type = _getDartType(jsonContent[key]);
    return '$type? $key';
  }).join(', ');

  final copyWithAssignments = jsonContent.keys.map((key) {
    return '$key: $key ?? this.$key';
  }).join(', ');

  final toStringFields =
      jsonContent.keys.map((key) => '$key: \$$key').join(', ');

  final equalityFields =
      jsonContent.keys.map((key) => '$key == other.$key').join(' && ');

  final hashFields = jsonContent.keys.map((key) => '$key.hashCode').join(' ^ ');

  return '''
class ${modelName.capitalize()} {
$fields

  ${modelName.capitalize()}({
    $constructorParams
  });

  // CopyWith method
  ${modelName.capitalize()} copyWith({
    $copyWithParams
  }) {
    return ${modelName.capitalize()}(
      $copyWithAssignments
    );
  }

  // JSON serialization methods
  factory ${modelName.capitalize()}.fromJson(Map<String, dynamic> json) {
    return ${modelName.capitalize()}(
      ${jsonContent.keys.map((key) => '$key: json[\'$key\']').join(',\n      ')}
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ${jsonContent.keys.map((key) => '\'$key\': $key').join(',\n      ')}
    };
  }

  // toString method
  @override
  String toString() {
    return '${modelName.capitalize()}($toStringFields)';
  }

  // Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ${modelName.capitalize()} &&
      $equalityFields;
  }

  // hashCode method
  @override
  int get hashCode => $hashFields;
}
''';
}

// Helper function to infer Dart types from JSON values
String _getDartType(dynamic value) {
  if (value is int) {
    return 'int';
  } else if (value is double) {
    return 'double';
  } else if (value is bool) {
    return 'bool';
  } else if (value is List) {
    return 'List<${_getDartType(value.isNotEmpty ? value[0] : null)}>';
  } else {
    return 'String';
  }
}
