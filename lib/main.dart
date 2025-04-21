import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trendbuy/my_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trendbuy/screens/home_screen.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: LightTheme.primaryColor,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: const TextTheme(
              bodySmall: TextStyle(
                  color: LightTheme.secondaryTextColor,
                  fontWeight: FontWeight.bold),
              bodyMedium: TextStyle(
                  color: LightTheme.primaryTextColor,
                  fontWeight: FontWeight.bold),
              bodyLarge: TextStyle(
                  color: LightTheme.primaryTextColor,
                  fontWeight: FontWeight.bold)),
          fontFamily: GoogleFonts.poppins().fontFamily,
          colorScheme: const ColorScheme.light(
              onPrimary: LightTheme.primaryTextColor,
              onSecondary: Colors.white,
              primary: LightTheme.primaryColor,
              secondary: LightTheme.secondaryColor)),
      home: const HomeScreen(),
    );
  }
}
