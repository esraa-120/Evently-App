import 'package:evently_app/core/config/extensions/padding_extension.dart';
import 'package:evently_app/core/config/gen/assets.gen.dart';
import 'package:evently_app/core/config/routes/app_routes_name.dart';
import 'package:evently_app/core/config/theme/app_colors.dart';
import 'package:evently_app/core/utils/firebase_cloud_store_service.dart';
import 'package:evently_app/data_source/category_data.dart';
import 'package:evently_app/models/event_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCardItem extends StatelessWidget {

  final EventData eventData;
  const EventCardItem({super.key, required this.eventData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(AppRoutesName.eventDetails, arguments: eventData);
      },
      child: Container(
        height: 195,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(image: AssetImage(CategoryList.getCategoryById(eventData.categoryId).imagePath),
        ),),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.scaffoldBackground,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.strokeBorder,
              )
            ),
            child: Text(
              DateFormat("dd MMM").format(eventData.selectedDateTime),
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.primaryColor,
            ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: AppColors.scaffoldBackground,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.strokeBorder,
                )
            ),
            child: Row(
              spacing: 8,
              children: [
                Expanded(
                  child: Text(
                    eventData.title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.mainText,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    eventData.isFavorite = !eventData.isFavorite;
                    await FirebaseCloudStoreService.updateEvent(eventData);
                  },
                  child: eventData.isFavorite
                    ? Assets.icons.selectHeartIcn.svg()
                    : Assets.icons.unselectedHeartIcn.svg(),
                ),
                ],
            ),
          ),
        ],
        ).paddingSymmetric(horizontal: 8, vertical: 8),
      ),
    );
  }
}
