import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/core/config/extensions/padding_extension.dart';
import 'package:evently_app/core/config/gen/assets.gen.dart';
import 'package:evently_app/core/config/theme/app_colors.dart';
import 'package:evently_app/core/utils/firebase_cloud_store_service.dart';
import 'package:evently_app/data_source/category_data.dart';
import 'package:evently_app/models/event_data.dart';
import 'package:evently_app/modules/layout/home/widgets/category_tab_item.dart';
import 'package:evently_app/modules/layout/home/widgets/event_card_item.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome Back ✨ ", style: theme.textTheme.bodyMedium),
                  Text("Hossam Bakry ", style: theme.textTheme.titleLarge),
                ],
              ),
              Spacer(),
              Assets.icons.sunIcn.svg(
                colorFilter: ColorFilter.mode(
                  theme.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5.5),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "EN",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 16),
          SizedBox(height: 24),
          DefaultTabController(
            length: CategoryList.categories.length,
            child: TabBar(
              onTap: (index) {
                setState(() {
                  selectedTabIndex = index;
                });
              },
              dividerHeight: 0,
              isScrollable: true,
              labelPadding: EdgeInsets.symmetric(horizontal: 4),
              indicator: BoxDecoration(),
              tabAlignment: TabAlignment.start,
              padding: EdgeInsets.symmetric(horizontal: 8),
              tabs: CategoryList.categories
                  .map(
                    (categoryData) => CategoryTabItem(
                      categoryData: categoryData,
                      isSelected:
                          CategoryList.categories.indexOf(categoryData) ==
                          selectedTabIndex,
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(height: 24),

          StreamBuilder<QuerySnapshot<EventData>>(
            stream: FirebaseCloudStoreService.getRealTimeEventsData(
              CategoryList.categories[selectedTabIndex].id,
            ),
            builder: (context, snapshot) {
              /// 1- wait
              /// 2- error
              /// 3- data

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              List<EventData> events = snapshot.data!.docs.map((data) {
                return data.data();
              }).toList();

              if (events.isEmpty) {
                return Text("No events found");
              }

              return Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    return EventCardItem(eventData: events[index]);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16);
                  },
                  itemCount: events.length,
                ),
              );
            },
          ),

          // FutureBuilder<List<EventData>>(
          //   future: FirebaseCloudStoreService.getEventsData(),
          //   builder: (context, snapshot) {
          //     /// 1- wait
          //     /// 2- error
          //     /// 3- data
          //     ///
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return CircularProgressIndicator();
          //     }
          //     if (snapshot.hasError) {
          //       return Text(snapshot.error.toString());
          //     }
          //     List<EventData> events = snapshot.data ?? [];
          //
          //     return Expanded(
          //       child: ListView.separated(
          //         padding: EdgeInsets.symmetric(horizontal: 16),
          //         itemBuilder: (context, index) {
          //           return EventCardItem(eventData: events[index]);
          //         },
          //         separatorBuilder: (context, index) {
          //           return SizedBox(height: 16);
          //         },
          //         itemCount: events.length,
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
