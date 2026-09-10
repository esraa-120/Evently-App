import 'package:evently_app/core/config/theme/app_colors.dart';
import 'package:evently_app/core/services/settings_provider/settings_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';

class AppTextFormField extends StatefulWidget {

  final bool isPassword;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const AppTextFormField({super.key, this.hintText, this.prefixIcon, this.suffixIcon, this.controller, this.validator, this.maxLines = 1, this.isPassword = false});

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settingConfig = Provider.of<SettingsConfig>(context);
    return TextFormField(
        controller: widget.controller,
        cursorColor: theme.primaryColor,
        validator: widget.validator,
        obscureText: widget.isPassword ? isPasswordVisible : false,
        maxLines: widget.maxLines,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          filled: true,
          fillColor: settingConfig.isDarkMode()
              ? AppColors.textFieldBackgroundDark
              : AppColors.white,
          hintText: widget.hintText,
          hintStyle: theme.textTheme.bodyMedium,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: settingConfig.isDarkMode()
                  ? AppColors.strokeBorderDark
                  : AppColors.strokeBorder,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppColors.strokeBorder,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppColors.strokeBorder,
            ),
          ),
          prefixIcon: widget.prefixIcon,
          suffixIconConstraints: BoxConstraints(
            minHeight: 24,
            minWidth: 24,
          ),
          suffixIcon: widget.isPassword
              ? Bounceable(
            onTap: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
                child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(
                              isPasswordVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                color: AppColors.secondaryText,
                            ),
                          ),
              )
              : widget.suffixIcon,
        )
    );
  }
}
