import 'package:evently_app/core/config/gen/assets.gen.dart';
import 'package:evently_app/core/config/routes/app_routes_name.dart';
import 'package:evently_app/core/config/theme/app_colors.dart';
import 'package:evently_app/core/services/settings_provider/settings_config.dart';
import 'package:evently_app/core/widgets/app_button_widget.dart';
import 'package:evently_app/main.dart';
import 'package:evently_app/modules/on_boarding/widgets/language_selector.dart';
import 'package:evently_app/modules/on_boarding/widgets/theme_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LetsStartView extends StatelessWidget {
  const LetsStartView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settingsConfig = Provider.of<SettingsConfig>(context);

    return Scaffold(
      appBar: AppBar(
        title: Assets.images.eventlyImg.image(
          height: 70,
          width: 140,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Assets.images.onBoardingImg.image(
                    color: settingsConfig.isDarkMode() ? AppColors.white : AppColors.primary,
                  ),
                  SizedBox(height: 24,),
                  Text("Personalize Your Experience",
                    style: theme.textTheme.titleLarge,
                  ),
                  SizedBox(height: 8,),
                  Text("Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
                    style: theme.textTheme.bodyLarge,
                  ),
                  SizedBox(height: 16),
                  LanguageSelector(),
                  SizedBox(height: 16),
                  ThemeSelector(),
                  SizedBox(height: 224,),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
            child: AppButtonWidget(
              title: "Let's start",
              onTap: () {
                navigatorKey.currentState?.pushNamedAndRemoveUntil(
                    AppRoutesName.login,
                    (route) => false,
                );
              },
            ),
            ),
          ]
        ),
      ),
    );
  }
}
