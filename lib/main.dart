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
import 'package:trendbuy/l10n/app_localizations.dart';
import 'package:trendbuy/providers/language_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Load language preference before starting app
  final prefs = await SharedPreferences.getInstance();
  final languageCode = prefs.getString('language') ?? 'en';
  final initialLanguage = languageCode == 'fa' 
      ? AppLanguage.persian 
      : AppLanguage.english;
  runApp(ProviderScope(
    overrides: [
      languageProvider.overrideWith((ref) => LanguageNotifier(initialLanguage)),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch language provider to rebuild when language changes
    ref.watch(languageProvider);
    final languageNotifier = ref.read(languageProvider.notifier);
    final locale = languageNotifier.locale;
    final isRTL = languageNotifier.isRTL;

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: LightTheme.primaryColor,
      statusBarColor: LightTheme.primaryColor,
    ));
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('fa', 'IR'),
      ],
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: LightTheme.primaryColor,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: LightTheme.primaryColor,
              systemNavigationBarIconBrightness: Brightness.light,
            ),
          ),
          textTheme: const TextTheme(
              bodySmall: TextStyle(
                  color: LightTheme.secondaryTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              bodyMedium: TextStyle(
                  color: LightTheme.primaryTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              bodyLarge: TextStyle(
                  color: LightTheme.primaryTextColor,
                  fontSize: 20,
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
            return Directionality(
              textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
              child: const HomeScreen(),
            );
          } else {
            return Directionality(
              textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
              child: const AuthScreen(),
            );
          }
        },
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
          child: child!,
        );
      },
    );
  }
}
