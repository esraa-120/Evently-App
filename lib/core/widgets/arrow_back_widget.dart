import 'package:evently_app/core/config/gen/assets.gen.dart';
import 'package:evently_app/core/config/theme/app_colors.dart';
import 'package:evently_app/core/services/settings_provider/settings_config.dart';
import 'package:evently_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';

class ArrowBackWidget extends StatelessWidget {
  const ArrowBackWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final settingConfig = Provider.of<SettingsConfig>(context);
    return Bounceable(
      onTap: () {
        navigatorKey.currentState?.pop();
      } ,
      child: Container(
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: settingConfig.isDarkMode()
                ? AppColors.textFieldBackgroundDark
                : AppColors.white ,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: settingConfig.isDarkMode()
                  ? AppColors.strokeBorderDark
                  : AppColors.strokeBorder,
            )
        ),
        child: Assets.icons.arrowLeftLightIcn.svg(
          color: settingConfig.isDarkMode()
              ? AppColors.white
              : AppColors.primary,
        ),
      ),
    );
  }
}
