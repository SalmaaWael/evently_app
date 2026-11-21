
import 'package:flutter/cupertino.dart';
import '../../features/authentication/login/login_screen.dart';
import '../../features/authentication/register/register_screen.dart';

import '../../features/create_event/create_event.dart';
import '../../main_layout/layout.dart';

class RoutesManager{
  static const String login = "/login";
  static const String register = "/register";
  static const String Mainlayout = "/Mainlayout";
  static const String createEvent = "/createEvent";



  static Route? getRoute(RouteSettings settings){
    switch(settings.name){
      case login:
        return CupertinoPageRoute(builder: (context) => const LoginScreen(),);
        case register:
        return CupertinoPageRoute(builder: (context) => const RegisterScreen(),);
        case Mainlayout:
        return CupertinoPageRoute(builder: (context) => const LayoutScreen(),);
      case createEvent:
        return CupertinoPageRoute(
          builder: (context) => CreateEventPage(),
        );

      default:
        return null;
    }
  }
}