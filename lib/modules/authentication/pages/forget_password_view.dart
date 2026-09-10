import 'package:evently_app/core/config/gen/assets.gen.dart';
import 'package:evently_app/core/config/theme/app_colors.dart';
import 'package:evently_app/core/services/settings_provider/settings_config.dart';
import 'package:evently_app/core/widgets/app_button_widget.dart';
import 'package:evently_app/core/widgets/arrow_back_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final settingConfig = Provider.of<SettingsConfig>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password",),
        leading: ArrowBackWidget(),
        ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          spacing: 40,
          children: [
            Assets.images.forgetPasswordImg.image(
              color: settingConfig.isDarkMode()
                  ? AppColors.white
                  : AppColors.primary,
            ),
            AppButtonWidget(
                title: "Reset password",
                onTap: () {
                  Navigator.pop(context);
                }
            )
          ],
        ),
      ),
    );
  }
}
