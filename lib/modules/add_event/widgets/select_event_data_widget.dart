import 'package:evently_app/core/config/extensions/padding_extension.dart';
import 'package:evently_app/core/config/gen/assets.gen.dart';
import 'package:evently_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectEventDataWidget extends StatelessWidget {

  final DateTime? selectedDateTime;
  final void Function()? onPressed;
  const SelectEventDataWidget({super.key, this.onPressed, this.selectedDateTime});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    return Row(
      children: [
        Assets.icons.calendarIcn.svg(),
        SizedBox(width: 8,),
        Text("Event Date",
    style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
        Spacer(),
        TextButton(
          onPressed: onPressed,
          child: Text(
             selectedDateTime != null
                 ? DateFormat("dd, MMM, yyyy").format(selectedDateTime!).toString()
                 : "Choose date",
          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500,
          color: AppColors.primary,
            decoration: TextDecoration.underline,
          decorationColor: AppColors.primary,
          decorationThickness: 2,
          ),
        ),)
      ],
    ).paddingSymmetric(horizontal: 16);
  }
}
