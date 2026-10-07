import 'package:crewmanpower/controllers/admin_global_controller.dart';
import 'package:crewmanpower/core/service/theems/theme_provider.dart';
import 'package:crewmanpower/features/landing/landing_page.dart';
import 'package:crewmanpower/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'core/localization/app_localizations.dart';
import 'core/localization/locale_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 3. Initialize Firebase for Web (and other platforms)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final locale = await LocalePreferences.getSavedLocale();

  Get.put(AdminGlobalController());
  Get.put(ThemeProvider());

  runApp(MyApp(initialLocale: locale));
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
    final themeProvider = Get.find<ThemeProvider>();

    return ChangeNotifierProvider<ThemeProvider>.value(
      value: themeProvider,
      child: Consumer<ThemeProvider>(
        builder: (context, theme, _) => GetMaterialApp(
          title: 'Crewmanpower Enterprise Solutions',
          debugShowCheckedModeBanner: false,
          locale: _currentLocale,
          themeMode: theme.themeMode,
          supportedLocales: const [Locale('en'), Locale('hi'), Locale('ur')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppLocalizationsDelegate(),
          ],
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF0D47A1),
              brightness: Brightness.light,
              surface: Colors.white,
            ),
            scaffoldBackgroundColor: const Color(0xFFF8FAFC),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF3B82F6),
              brightness: Brightness.dark,
              surface: const Color(0xFF112240),
            ),
            scaffoldBackgroundColor: const Color(0xFF0A192F),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: WebLandingPage(onLanguageChange: (Locale p1) {}),
        ),
      ),
    );
  }
}
