import 'package:evently_app/core/config/gen/assets.gen.dart';
import 'package:evently_app/core/config/theme/app_colors.dart';
import 'package:evently_app/core/services/settings_provider/settings_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settingsConfig = Provider.of<SettingsConfig>(context);

    return Row(
      children: [
        Expanded(
          child: Text("Theme",
            style: theme.textTheme.titleMedium,
          ),
        ),
        Bounceable(
          onTap: () {
            settingsConfig.changeCurrentTheme(ThemeMode.light);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5.5),
            decoration: BoxDecoration(
              color: settingsConfig.isDarkMode()
                  ? Colors.transparent
                  : AppColors.primary,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: settingsConfig.isDarkMode()
                    ? AppColors.strokeBorderDark
                    : Colors.transparent,
              )
            ),
            child: Assets.icons.sunIcn.svg(
              colorFilter: ColorFilter.mode(
                  AppColors.white, BlendMode.srcIn)
            ),
          ),
        ),
        SizedBox(width: 8,),

        Bounceable(
          onTap: () {
            settingsConfig.changeCurrentTheme(ThemeMode.dark);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5.5),
            decoration: BoxDecoration(
              color: settingsConfig.isDarkMode()
                  ? theme.primaryColor
                  : AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Assets.icons.moonIcn.svg(
              colorFilter: ColorFilter.mode(
                  settingsConfig.isDarkMode()
                  ? AppColors.white
                  : AppColors.primary,
                  BlendMode.srcIn)
            ),
          ),
        ),
      ],);
  }
}
