import 'package:evently_app/core/config/gen/assets.gen.dart';
import 'package:evently_app/core/config/routes/app_routes_name.dart';
import 'package:evently_app/core/config/theme/app_colors.dart';
import 'package:evently_app/main.dart';
import 'package:evently_app/modules/layout/profile/profile_view.dart';
import 'package:flutter/material.dart';

import 'favorite/favorite_view.dart';
import 'home/home_view.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {

  final List<Widget> _pages = [
    HomeView(),
    FavoriteView(),
    ProfileView(),
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          navigatorKey.currentState?.pushNamed(
            AppRoutesName.addEvent
          );
        },
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.primaryColor,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 12, color: Color (0xFF0E3A99).withValues(alpha: 0.5)
              ),
            ],
          ),
          child: Icon(
            Icons.add,
            color: AppColors.white,
            size: 24,
          ),
        ),
      ),
      body: _pages [currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: theme.primaryColor,
        selectedIconTheme: IconThemeData(
          color: theme.primaryColor,
        ),
        unselectedIconTheme: IconThemeData(
          color: AppColors.disabled,
        ),
        unselectedItemColor: AppColors.disabled,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        backgroundColor: AppColors.white,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Assets.icons.unselectHomeIcn.svg(color: AppColors.disabled),
            activeIcon: Assets.icons.selectHomeIcn.svg(color: theme.primaryColor),
          ),
          BottomNavigationBarItem(
            label: "Favorite",
            icon: Assets.icons.unselectHeartIcn.svg(color: AppColors.disabled),
            activeIcon: Assets.icons.selectHeartIcn.svg(color: theme.primaryColor),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Assets.icons.unselectUserIcn.svg(color: AppColors.disabled),
            activeIcon: Assets.icons.selectUserIcn.svg(color: theme.primaryColor),
          ),
        ]
      ),
    );
  }
}
