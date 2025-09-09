import 'package:evently_app/config/theme/theme_manager.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/config_provider.dart';
import 'package:evently_app/providers/lang_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider, Provider, MultiProvider;
import 'core/routes_manager/routes_manager.dart';

void main() {
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
    var themeProvider=Provider.of<ThemeProvider>(context);
    var langProvider=Provider.of<LanguageProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(393, 841),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RoutesManager.getRoute,
          initialRoute: RoutesManager.Mainlayout,
          theme: ThemeManager.light,
          darkTheme: ThemeManager.dark,
          themeMode: themeProvider.currentTheme,
          localizationsDelegates:[
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],

          supportedLocales: [
            Locale('en'), // English
            Locale('ar'), // Spanish
          ],

          locale:  Locale(langProvider.currentLanguage),
        );
      },
    );
  }
}
