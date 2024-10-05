import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/setting/bloc/setting_bloc.dart';

import 'features/home/bloc/home_bloc.dart';
import 'routes.dart';

void main() {
  runApp(const MyApp());
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
                BlocProvider<SettingBloc>(
          create: (context) => SettingBloc(),
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
