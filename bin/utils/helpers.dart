// // Utility to capitalize feature names
// extension StringExtension on String {
//   String capitalize() {
//     return this[0].toUpperCase() + substring(1);
//   }
// }


import 'dart:convert';
import 'dart:io';
import 'templates.dart';

extension StringExtension on String {
  String capitalize() {
    return this[0].toUpperCase() + substring(1);
  }
}

// Create feature structure
void createFeatureStructure(String featureName) {
  final root = 'lib/features/$featureName';
  final directories = [
    '$root/bloc',
    '$root/pages',
    '$root/widgets',
    '$root/models',
  ];

  for (var dir in directories) {
    Directory(dir).createSync(recursive: true);
    print('Created $dir');
  }

  final blocFile = File('$root/bloc/${featureName}_bloc.dart');
  blocFile.writeAsStringSync(blocTemplate(featureName));

  final eventFile = File('$root/bloc/${featureName}_event.dart');
  eventFile.writeAsStringSync(eventTemplate(featureName));

  final stateFile = File('$root/bloc/${featureName}_state.dart');
  stateFile.writeAsStringSync(stateTemplate(featureName));

  final pageFile = File('$root/pages/${featureName}_page.dart');
  pageFile.writeAsStringSync(pageTemplate(featureName));

  print('Created default BLoC, Event, State, and Page files for $featureName.');
}

// Add route to router
void addRouteToRouter(String featureName) {
  final routeFile = File('lib/config/routes.dart');

  if (!routeFile.existsSync()) {
    routeFile.createSync();
    routeFile.writeAsStringSync(routeTemplate());
  }

  String existingContent = routeFile.readAsStringSync();
  final importStatement =
      "import '../features/$featureName/pages/${featureName}_page.dart';";
  final newRoute = """
      GoRoute(
      name:'${featureName.capitalize()}',
        path: '/$featureName',
        builder: (context, state) => const ${featureName.capitalize()}Page(),
      ),""";

  if (!existingContent.contains(importStatement)) {
    existingContent = existingContent.replaceFirst(
        "// Page Imports",
        "$importStatement \n // Page Imports");
  }

  if (!existingContent.contains(newRoute.trim())) {
    existingContent =
        existingContent.replaceFirst('// Routes', '$newRoute\n      // Routes');
  }

  routeFile.writeAsStringSync(existingContent);
  print('Added import and route for $featureName in routes.dart');
}



void addBlocProviderToMain(String featureName) {
  final mainFile = File('lib/main.dart');

  if (!mainFile.existsSync()) {
    print('main.dart does not exist. Please initialize the project first.');
    return;
  }

  final existingContent = mainFile.readAsStringSync();
  final blocProviderStatement = '''
        BlocProvider<${featureName.capitalize()}Bloc>(
          create: (context) => ${featureName.capitalize()}Bloc(),
        ),''';

  final importStatement =
      "import 'features/$featureName/bloc/${featureName}_bloc.dart';";

  // Check if the BlocProvider for the feature already exists
  if (!existingContent.contains(blocProviderStatement.trim())) {
    // Add the BlocProvider inside the MultiBlocProvider
    final updatedContent = existingContent.replaceFirst(
        '// BlocProviders will be inserted here dynamically',
        '$blocProviderStatement\n        // BlocProviders will be inserted here dynamically');

    // Check if the import statement for the feature's bloc already exists
    if (!existingContent.contains(importStatement)) {
      // Add the import at the top
      final updatedContentWithImport = updatedContent.replaceFirst(
          "import 'package:flutter_bloc/flutter_bloc.dart';",
          "import 'package:flutter_bloc/flutter_bloc.dart';\n$importStatement");
      mainFile.writeAsStringSync(updatedContentWithImport);
    } else {
      mainFile.writeAsStringSync(updatedContent);
    }

    print('Added BlocProvider and import for $featureName in main.dart');
  } else {
    print('BlocProvider for $featureName already exists in main.dart');
  }
}



void createModelFromJson(String modelName, String jsonData,
    {String? featureName}) {
  Map<String, dynamic> jsonContent;

  // Check if jsonData is a path or direct JSON string
  if (File(jsonData).existsSync()) {
    // If it's a file path, read the file
    final file = File(jsonData);
    jsonContent = jsonDecode(file.readAsStringSync());
  } else {
    // If it's direct JSON data
    jsonContent = jsonDecode(jsonData);
  }

  // Determine the model directory
  String modelDir;
  if (featureName != null && featureName.isNotEmpty) {
    modelDir = 'lib/features/$featureName/models';
  } else {
    modelDir = 'lib/core/models';
  }

  // Create the model file in the appropriate directory
  final modelFile = File('$modelDir/${modelName.toLowerCase()}_model.dart');
  modelFile.createSync(recursive: true);
  modelFile.writeAsStringSync(modelTemplate(modelName, jsonContent));

  print('Created model $modelName.dart in $modelDir');
}
