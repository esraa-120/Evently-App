import 'package:evently_app/core/config/gen/assets.gen.dart';
import 'package:evently_app/core/config/routes/app_routes_name.dart';
import 'package:evently_app/core/config/theme/app_colors.dart';
import 'package:evently_app/core/services/settings_provider/settings_config.dart';
import 'package:evently_app/core/services/snack_service.dart';
import 'package:evently_app/core/utils/firebase_auth_service.dart';
import 'package:evently_app/core/widgets/app_button_widget.dart';
import 'package:evently_app/core/widgets/app_text_form_field.dart';
import 'package:evently_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settingConfig = Provider.of<SettingsConfig>(context);
    return Scaffold(
      appBar: AppBar(
        title: Assets.images.eventlyImg.image(
          width: 140,
          height: 70,
          color: theme.primaryColor,
        ),
        leading: Bounceable(
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
            child: Assets.icons.arrowLeftLightIcn.svg(),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Create your account",
                    style: theme.textTheme.headlineSmall,
                  ),
                  SizedBox(height: 24),
                  AppTextFormField(
                    controller: _nameController,
                    hintText: "Enter your name",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Assets.icons.userIcn.svg(),
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  AppTextFormField(
                    controller: _emailController,
                    hintText: "Enter your email",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Assets.icons.smsIcn.svg(),
                    ),
                    validator: (value) {
                      if(value == null || value.trim().isEmpty) {
                        return "Please enter your email";
                      }
                      final emailRegex = RegExp(
                        r'^[\w-.]+@([\w-]+\.)+[\w-]{2,}$',
                      );
                      if (!emailRegex.hasMatch(value)) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  AppTextFormField(
                    controller: _passwordController,
                    isPassword: true,
                    hintText: "Enter your password",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Assets.icons.lockIcn.svg(),
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      final RegExp strongPasswordRegex = RegExp(
                        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                      );
                      if (!strongPasswordRegex.hasMatch(value)) {
                        return "Please enter a strong password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  AppTextFormField(
                    controller: _confirmPasswordController,
                    isPassword: true,
                    hintText: "Confirm your password",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Assets.icons.lockIcn.svg(),
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return "Please confirm your password";
                      }
                      if(value != _passwordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  AppButtonWidget(
                    title: "Sign up",
                    onTap: () {
                      if(_formKey.currentState!.validate()) {
                        EasyLoading.show();
                        FirebaseAuthService.createAccount(
                            _emailController.text,
                            _passwordController.text
                        ).then((value) {
                          EasyLoading.dismiss();
                          if(value) {
                            SnackBarServer.showSuccessMessage(
                                "Account has been created successfully");
                            navigatorKey.currentState!.pop();
                          }
                        });
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Already have an account ?",
                              style: theme.textTheme.bodyMedium?.copyWith(),
                            ),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  navigatorKey.currentState?.pushNamed(
                                      AppRoutesName.register
                                  );
                                },
                                child: Text(
                                  " Login",
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                    decorationColor: theme.primaryColor,
                                    decorationThickness: 2,
                                  ),
                                ),
                              ),
                            ),
                          ]
                      )),
                  SizedBox(height: 24),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Divider(
                          endIndent: 20,
                          indent: 20,
                          color: settingConfig.isDarkMode() ? AppColors.strokeBorderDark : AppColors.strokeBorder,
                        ),
                        ),
                        Text("Or", style: theme.textTheme.bodyMedium?.copyWith(
                          color: settingConfig.isDarkMode() ? AppColors.primaryDark : AppColors.primary,
                        ),
                        ),
                        Expanded(child: Divider(
                          endIndent: 20,
                          indent: 20,
                          color: settingConfig.isDarkMode() ? AppColors.strokeBorderDark : AppColors.strokeBorder,
                        ),
                        ),
                      ],
                  ),
                  SizedBox(height: 5),
                  AppButtonWidget(
                    title: "Sign up with Google",
                    backgroundColor: settingConfig.isDarkMode()
                        ? AppColors.textFieldBackgroundDark
                        :AppColors.white,
                    borderColor: settingConfig.isDarkMode()
                        ? AppColors.strokeBorderDark
                        : AppColors.strokeBorder,
                    titleColor: theme.primaryColor,
                    icon: Assets.images.googleImg.image(),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
