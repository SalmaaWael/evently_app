import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// تأكدي إن المسارات دي صح عندك
import 'config/theme/theme_manager.dart';
import 'core/routes_manager/routes_manager.dart';
import 'firebase_options.dart'; // الملف اللي اتعمل جديد
import 'l10n/app_localizations.dart';
import 'providers/config_provider.dart';
import 'providers/lang_provider.dart';

void main() async {
  // 1. ضمان تهيئة النظام للأكواد الـ Native
  WidgetsFlutterBinding.ensureInitialized();

  // 2. تفعيل Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 3. تشغيل التطبيق
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ],
      child: const EventlyApp()));
}

class EventlyApp extends StatelessWidget {
  const EventlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var langProvider = Provider.of<LanguageProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(393, 841),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          // الـ Routes
          onGenerateRoute: RoutesManager.getRoute,
          initialRoute: RoutesManager.register, // أو Login لو عايزة تبدأي بالدخول

          // الـ Theme
          theme: ThemeManager.light,
          darkTheme: ThemeManager.dark,
          themeMode: themeProvider.currentTheme,

          // اللغة Localization
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en'), // English
            Locale('ar'), // Arabic
          ],
          locale: Locale(langProvider.currentLanguage),
        );
      },
    );
  }
}