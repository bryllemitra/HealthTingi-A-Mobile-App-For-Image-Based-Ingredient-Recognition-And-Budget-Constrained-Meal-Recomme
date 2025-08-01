import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/reverse_ingredient.dart';
import 'pages/index.dart';
import 'pages/login.dart';
import 'pages/register.dart';
import 'pages/meal_scan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthTingi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Orbitron',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellowAccent),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const IndexPage(),
        '/home': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          return HomePage(
            title: 'HealthTingi',
            userId: args['userId'],
          );
        },
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/meal-scan': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          return MealScanPage(userId: args['userId']);
        },
        '/reverse-ingredient': (context) => const ReverseIngredientPage(),
      },
    );
  }
}