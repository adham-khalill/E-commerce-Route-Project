import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  // Import Provider
import 'AuthProvider.dart';
import 'home_screen.dart';
import 'login_page.dart';
import 'splash_screen.dart';
import 'register_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),  // Provide AuthProvider
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.splashScreenRoute,
      routes: {
        SplashScreen.splashScreenRoute: (context) => SplashScreen(),
        LoginScreen.loginScreenRoute: (context) => LoginScreen(),
        RegisterScreen.registerScreenRoute: (context) => RegisterScreen(),
        HomeScreen.homeScreenRoute: (context) => HomeScreen(),
      },
    );
  }
}
