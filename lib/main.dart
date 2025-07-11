import 'package:evently_app/config/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routes_manager/routes_manager.dart';

void main() {
  runApp(const EventlyApp());
}

class EventlyApp extends StatelessWidget {
  const EventlyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 841),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        onGenerateRoute: RoutesManager.getRoute,
        initialRoute: RoutesManager.register ,
        theme: ThemeManager.light,
        darkTheme: ThemeManager.dark,
        themeMode:ThemeMode.light ,
        locale: Locale("en") ,
      ),
    );
  }
}
