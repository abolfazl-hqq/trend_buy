import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trendbuy/firebase_options.dart';
import 'package:trendbuy/my_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trendbuy/screens/auth_screen.dart';
import 'package:trendbuy/screens/home_screen.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: LightTheme.primaryColor,
      statusBarColor: LightTheme.primaryColor,
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
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
