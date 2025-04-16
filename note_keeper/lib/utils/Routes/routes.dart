import 'package:flutter/material.dart';
import 'package:note_keeper/Screens/login_module/login_screen.dart';
import 'package:note_keeper/Screens/register_module/register_screen.dart';
import 'package:note_keeper/utils/Routes/routes_name.dart';

///Customise Routes
class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.home:
        return MaterialPageRoute(builder: (_) => Scaffold());
      case RoutesNames.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RoutesNames.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
