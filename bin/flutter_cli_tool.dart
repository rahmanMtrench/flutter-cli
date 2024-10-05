#!/usr/bin/env dart

import 'dart:io';
import 'package:args/args.dart';
import 'utils/templates.dart';
import 'utils/helpers.dart';

void main(List<String> arguments) {

  final parser = ArgParser();

  // Define commands
  parser.addFlag('help',
      abbr: 'h', negatable: false, help: 'Show this help message.');
  parser.addFlag('init',
      abbr: 'i',
      negatable: false,
      help: 'Initialize the project structure with core and config folders.');
  parser.addOption('feature',
      abbr: 'f',
      help: 'Generate a feature with bloc, pages, widgets, and models.');
  parser.addOption('model',
      abbr: 'm', help: 'Generate a Dart model from JSON.');
  parser.addOption('json',
      abbr: 'j',
      help: 'Provide JSON data or a path to a JSON file to create the model.');
  parser.addOption('featureModel',
      help:
          'Specify the feature folder where the model will be placed (optional).');

  // Parse arguments
  final args = parser.parse(arguments);

  // Show help if --help or -h is passed
  if (args['help'] || arguments.isEmpty) {
    print(parser.usage);
    return;
  }

  if (args['init']) {
    _initializeProject();
    _createFeatureStructure('home');
    _addRouteToRouter('home');
    _addBlocProviderToMain('home');
  } else if (args.wasParsed('feature')) {
     final featureName = args['feature'].trim(); // Trim to handle extra spaces
    _createFeatureStructure(featureName);
    _addRouteToRouter(featureName);
    _addBlocProviderToMain(featureName);
  } else if (args.wasParsed('model') && args.wasParsed('json')) {
    final modelName = args['model'].trim();
    final jsonData = args['json'];
    final featureModel =
        args['featureModel']; // Optional feature name for the model
    createModelFromJson(modelName, jsonData, featureName: featureModel);
  } else {
    print('No valid command provided.');
    print('Use --help or -h to see the available options.');
  }
}
//    final parser = ArgParser();

//   // Command to initialize the project structure and generate 'home' feature
//   parser.addFlag('init',
//       abbr: 'i', negatable: false, help: 'Initialize the project');

//   // Command to generate a feature
//   parser.addOption('feature', abbr: 'f', help: 'Feature name to generate.');

//   // Command to generate a model
//   parser.addOption('model', abbr: 'm', help: 'Model name to generate.');
//   parser.addOption('json',
//       abbr: 'j', help: 'JSON data or file path to create model.');
//   parser.addOption('featureModel',
//       help: 'Feature name for the model (optional).');

//   final args = parser.parse(arguments);

//   if (args['init']) {
//     _initializeProject();
//     _createFeatureStructure('home');
//     _addRouteToRouter('home');
//     _addBlocProviderToMain('home');
//   } else if (args.wasParsed('feature')) {
//     final featureName = args['feature'];
//     _createFeatureStructure(featureName);
//     _addRouteToRouter(featureName);
//     _addBlocProviderToMain(featureName);
//   } else if (args.wasParsed('model') && args.wasParsed('json')) {
//     final modelName = args['model'];
//     final jsonData = args['json'];
//     final featureModel =
//         args['featureModel']; // Optional feature name for the model
//     createModelFromJson(modelName, jsonData, featureName: featureModel);
//   } else {
//     print('No valid command provided.');
//   }
// }

void _createFeatureStructure(String featureName) {
  createFeatureStructure(featureName);
}

void _addRouteToRouter(String featureName) {
  addRouteToRouter(featureName);
}

void _addBlocProviderToMain(String featureName) {
  addBlocProviderToMain(featureName);
}

// Initialize the project structure and generate 'home' feature
void _initializeProject() {
  // Check if the project is already initialized
  if (Directory('lib/core').existsSync() &&
      Directory('lib/config').existsSync()) {
    print('Project is already initialized. Skipping initialization.');
    return;
  }

  final directories = [
    'lib/core',
    'lib/config',
  ];

  for (var dir in directories) {
    Directory(dir).createSync(recursive: true);
    print('Created $dir');
  }

  final mainFile = File('lib/main.dart');
  mainFile.writeAsStringSync(mainTemplate());

  print(
      'Project initialized with core, config folders, and main.dart created.');
}
