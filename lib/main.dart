import 'package:flutter/material.dart';
import 'package:rickandmorty_2/app/locator.dart';
import 'package:rickandmorty_2/app/theme.dart';
import 'package:rickandmorty_2/services/api_service.dart';

import 'app/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
    );
  }
}
