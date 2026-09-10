import 'dart:async';

import 'package:evently_app/core/config/gen/assets.gen.dart';
import 'package:evently_app/core/config/routes/app_routes_name.dart';
import 'package:evently_app/main.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  late Timer _timer;

  @override
  void initState() {
    super.initState();

    ///TODO: Get Current Theme and Languages From Shared Preferences
    _timer = Timer(
        Duration(seconds: 2),
            () {
          navigatorKey.currentState?.pushReplacementNamed(AppRoutesName.login,);
});}

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0),
        child: Center(
          child: Assets.images.eventlyImg.image(),
        ),
      ),
    );
  }
}
