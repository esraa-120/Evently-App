import 'package:evently_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SettingCardItem extends StatelessWidget {

  final String actionName;
  final Widget action;
  const SettingCardItem({super.key, required this.actionName, required this.action});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.strokeBorder),
      ),
      child: Row(
        children: [
          Text(
            actionName,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          action,
        ]
      ),
    );
  }
}
