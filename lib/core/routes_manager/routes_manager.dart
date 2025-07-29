import 'package:flutter/cupertino.dart';

import '../../features/authentication/login/login_screen.dart';
import '../../features/authentication/register/register_screen.dart';

class RoutesManager{
  static const String login = "/login";
  static const String register = "/register";

  static Route? getRoute(RouteSettings settings){
    switch(settings.name){
      case login:
        return CupertinoPageRoute(builder: (context) => const LoginScreen(),);
        case register:
        return CupertinoPageRoute(builder: (context) => const RegisterScreen(),);
      default:
        return null;
    }
  }
}