import 'package:evently_app/modules/add_event/add_event_view.dart';
import 'package:evently_app/modules/authentication/pages/forget_password_view.dart';
import 'package:evently_app/modules/authentication/pages/login_view.dart';
import 'package:evently_app/modules/authentication/pages/register_view.dart';
import 'package:evently_app/modules/layout/layout_view.dart';
import 'package:evently_app/modules/on_boarding/lets_start_view.dart';
import 'package:evently_app/modules/splash/splash_view.dart';
import 'package:flutter/material.dart';

import 'app_routes_name.dart';

abstract class AppRouteManager {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case AppRoutesName.initial:
        return MaterialPageRoute(
            builder: (context) => const SplashView(),
            settings: settings
        );

        case AppRoutesName.letsStart:
          return MaterialPageRoute(
              builder: (context) => const LetsStartView(),
              settings: settings
          );

          case AppRoutesName.login:
          return MaterialPageRoute(
              builder: (context) => const LoginView(),
              settings: settings
          );

          case AppRoutesName.register:
          return MaterialPageRoute(
              builder: (context) => const RegisterView(),
              settings: settings
          );

          case AppRoutesName.forgotPassword:
          return MaterialPageRoute(
              builder: (context) => const ForgetPasswordView(),
              settings: settings
          );

          case AppRoutesName.layout:
          return MaterialPageRoute(
              builder: (context) => const LayoutView(),
              settings: settings
          );

          case AppRoutesName.addEvent:
          return MaterialPageRoute(
              builder: (context) => const AddEventView(),
              settings: settings
          );

        default:
          return MaterialPageRoute(
              builder: (context) => const SplashView(),
              settings: settings
          );
    }
  }
}