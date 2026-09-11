import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'core/config/routes/app_route_manager.dart';
import 'core/config/routes/app_routes_name.dart';
import 'core/config/theme/app_theme_manager.dart';

import 'package:firebase_core/firebase_core.dart';
import 'core/services/loading_service.dart';
import 'core/services/settings_provider/settings_config.dart';
import 'firebase_options.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
 await dotenv.load( fileName: ".env");

  runApp (ChangeNotifierProvider(
      create: (context) => SettingsConfig(),
      child: const MyApp()));

  configureEasyLoading();
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final settingsConfig = Provider.of<SettingsConfig>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Evently App',
      theme: AppThemeManager.getLightTheme(),
      darkTheme: AppThemeManager.getDarkTheme(),
      themeMode: settingsConfig.currentTheme,
      initialRoute: AppRoutesName.initial,
      onGenerateRoute: AppRouteManager.onGenerateRoute,
      navigatorKey: navigatorKey,
      builder: EasyLoading.init(
        builder: BotToastInit()
      ),
    );
  }
}

