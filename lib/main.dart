import 'package:carros/views/home.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';

import 'bloc/cubit/home/carros_bloc_cubit.dart';

void main() {
  GetIt getIt = GetIt.I;
 
  WidgetsFlutterBinding.ensureInitialized();
  
  // getIt.registerSingleton<CarrosController>(CarrosController());
  getIt.registerSingleton<CarrosBlocCubit>(CarrosBlocCubit());
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
