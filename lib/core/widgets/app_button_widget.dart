import 'package:evently_app/core/config/theme/app_colors.dart';
import 'package:evently_app/core/services/settings_provider/settings_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';

class AppButtonWidget extends StatelessWidget {

  final void Function()? onTap;
  final String title;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? borderColor;
  final Widget? icon;
  const AppButtonWidget({super.key, this.onTap, required this.title, this.backgroundColor, this.titleColor, this.borderColor, this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final setttingConfig = Provider.of<SettingsConfig>(context);
    return Bounceable(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        // constraints: BoxConstraints(maxHeight: 50),
        decoration: BoxDecoration(
          color: backgroundColor ??  theme.primaryColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: borderColor ?? theme.primaryColor,
          )
        ),
        child: Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ?icon,
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                color: titleColor ?? AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
