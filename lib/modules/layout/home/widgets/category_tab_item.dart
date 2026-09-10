import 'package:evently_app/core/config/theme/app_colors.dart';
import 'package:evently_app/models/category_data.dart';
import 'package:flutter/material.dart';

class CategoryTabItem extends StatelessWidget {

  final CategoryData categoryData;
  final bool isSelected;
  const CategoryTabItem({super.key, required this.categoryData, required this.isSelected});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? theme.primaryColor : AppColors.white,
        border: Border.all(
          color: AppColors.strokeBorder,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
          spacing: 8,
          children: [
            Icon(categoryData.icon, color: isSelected ? AppColors.white : theme.primaryColor),
            Text(
                categoryData.name,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: isSelected ? AppColors.white : AppColors.mainText,
                  fontWeight: FontWeight.w500,
                ))
          ]
      ),
    );
  }
}
