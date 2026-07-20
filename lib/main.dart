import 'package:crewmanpower/features/landing/landing_page.dart';
import 'package:crewmanpower/core/service/theems/theme_provider.dart'; // Ensure this path is correct
import 'package:provider/provider.dart';
import 'core/localization/app_localizations.dart';
import 'core/localization/locale_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final locale = await LocalePreferences.getSavedLocale();
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(initialLocale: locale),
    ),
  );
}

class MyApp extends StatefulWidget {
  final Locale initialLocale;
  const MyApp({super.key, required this.initialLocale});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _currentLocale;

  @override
  void initState() {
    super.initState();
    _currentLocale = widget.initialLocale;
  }

  void changeLanguage(Locale locale) async {
    await LocalePreferences.saveLocale(locale);
    setState(() {
      _currentLocale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch the ThemeProvider for state changes
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      title: 'Crewmanpower Enterprise Solutions',
      debugShowCheckedModeBanner: false,
      locale: _currentLocale,
      themeMode: themeProvider.themeMode, // Switches dynamically between dark and light
      supportedLocales: const [Locale('en'), Locale('hi'), Locale('ur')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizationsDelegate(),
      ],
      // Light Theme configuration
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF0D47A1),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),
      // Dark Theme configuration
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF1E88E5),
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: WebLandingPage(onLanguageChange: changeLanguage),
    );
  }
}