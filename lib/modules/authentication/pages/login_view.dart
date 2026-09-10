import 'package:evently_app/core/config/gen/assets.gen.dart';
import 'package:evently_app/core/config/routes/app_routes_name.dart';
import 'package:evently_app/core/config/theme/app_colors.dart';
import 'package:evently_app/core/services/settings_provider/settings_config.dart';
import 'package:evently_app/core/utils/firebase_auth_service.dart';
import 'package:evently_app/core/widgets/app_button_widget.dart';
import 'package:evently_app/core/widgets/app_text_form_field.dart';
import 'package:evently_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Login to your account",
                style: theme.textTheme.headlineSmall,
                ),
                SizedBox(height: 24),
                AppTextFormField(
                  controller: _emailController,
                  hintText: "Enter your email",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Assets.icons.smsIcn.svg(),
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    return null;
                  }
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
                    return null;
                  }
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    navigatorKey.currentState?.pushNamed(
                        AppRoutesName.forgotPassword
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    textAlign: TextAlign.end,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: theme.primaryColor,
                      decorationThickness: 2,
                    ),
                  ),
                ),
                SizedBox(height: 45),
                AppButtonWidget(
                  title: "Login",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      EasyLoading.show();

                      FirebaseAuthService.signInWithAccount(_emailController.text, _passwordController.text
                      ).then((value){
                        EasyLoading.dismiss();
                        if(value){
                          navigatorKey.currentState?.pushNamedAndRemoveUntil(
                            AppRoutesName.layout,
                                (route) => false,
                          );
                        }
                      });
                    }
                  }
                ),
                SizedBox(height: 45),
                RichText(
                  textAlign: TextAlign.center,
                    text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Don’t have an account ?",
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
                           " Signup",
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
                SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Divider(
                      endIndent: 20,
                      indent: 20,
                    )),
                    Text("Or",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: settingConfig.isDarkMode() ? AppColors.primaryDark : AppColors.primary,
                    ),
                    ),
                    Expanded(child: Divider(
                      endIndent: 20,
                      indent: 20,
                    )),]),
                    SizedBox(height: 20),
                    AppButtonWidget(
                        title: "Login with Google",
                      backgroundColor: settingConfig.isDarkMode()
                          ? AppColors.textFieldBackgroundDark
                          :AppColors.white,
                      borderColor: settingConfig.isDarkMode()
                          ? AppColors.strokeBorderDark
                          : AppColors.strokeBorder,
                      titleColor: theme.primaryColor,
                      icon: Assets.images.googleImg.image(),

                      onTap: () async {
                        EasyLoading.show();

                        try {
                          final value = await FirebaseAuthService.signInWithGoogle();

                          if (!mounted) return;

                          if (value.user != null) {
                            navigatorKey.currentState?.pushNamedAndRemoveUntil(
                              AppRoutesName.layout,
                                  (route) => false,
                            );
                          }
                        } finally {
                          EasyLoading.dismiss();
                        }
                      },
                      ),
                  ],
            ),
          ),
        ),
      ),
    );
  }
}
