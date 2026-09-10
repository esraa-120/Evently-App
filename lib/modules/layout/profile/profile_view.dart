import 'package:evently_app/core/config/extensions/padding_extension.dart';
import 'package:evently_app/core/config/gen/assets.gen.dart';
import 'package:evently_app/core/config/theme/app_colors.dart';
import 'package:evently_app/modules/layout/favorite/widgets/setting_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  bool status = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
        child: Column(
          children: [
            CircleAvatar(
              radius: 52,
              backgroundImage: Assets.images.routeLogoImg.provider(),
            ),
            SizedBox(height: 16,),
            Text(
              "Hossam Bakry",
              style: theme.textTheme.titleLarge,
            ),
            SizedBox(height: 16),
            Text(
              "HossamBakry@gmail.com",
              style: theme.textTheme.bodyMedium,
            ),
            SizedBox(height: 32),
            SettingCardItem(
              actionName: "Dark Mode",
              action: FlutterSwitch(
                activeColor: AppColors.primary,
                inactiveColor: AppColors.disabled,
                width: 40.0,
                height: 24.0,
                valueFontSize: 25,
                toggleSize: 16.0,
                value: status,
                borderRadius: 30.0,
                onToggle: (val) {
                  setState(() {
                    status = val;
                  });
                }
                ),
              ),
            SizedBox(height: 16),
            SettingCardItem(
              actionName: "Language",
              action: Assets.icons.arrowRightIcn.svg(),
            ),
            SizedBox(height: 16),
            SettingCardItem(
              actionName: "Logout",
              action: Assets.icons.logoutIcn.svg(),
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
    );
  }
}
