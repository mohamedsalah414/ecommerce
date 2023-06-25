import 'package:ecommercebusiness/src/core/utils/app_strings.dart';
import 'package:ecommercebusiness/src/modules/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'core/themes/app_theme.dart';

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightThemeData,
      darkTheme: AppTheme.darkThemeData,
      home: const HomeScreen(),
    );
  }
}
