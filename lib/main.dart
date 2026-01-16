import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'config/firebase_options.dart';

import 'pages/login_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/book_page.dart';
import 'styles/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,

      initialRoute: "/",

      routes: {
        "/": (_) => const LoginPage(),
        "/dashboard": (_) => const DashboardPage(),
        "/crud": (_) => BookPage(),
      },
    );
  }
}
