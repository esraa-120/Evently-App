import 'package:evently_app/core/config/gen/assets.gen.dart';
import 'package:evently_app/models/category_data.dart';
import 'package:flutter/material.dart';

class CategoryList {

  static final categories = [
    CategoryData(
      id: "sports",
      name: "Sports",
      imagePath: Assets.images.sportImg.path,
      darkImagePath: Assets.images.sportDarkImg.path,
      icon: Icons.motorcycle_outlined,
    ),
    CategoryData(
      id: "birthday",
      name: "Birthday",
      imagePath: Assets.images.birthdayImg.path,
      darkImagePath: Assets.images.birthdayDarkImg.path,
      icon: Icons.cake_outlined,
    ),
    CategoryData(
      id: "book_club",
      name: "Book Club",
      imagePath: Assets.images.bookClubImg.path,
      darkImagePath: Assets.images.bookClubDarkImg.path,
      icon: Icons.chrome_reader_mode_outlined,
    ),
    CategoryData(
      id: "meeting",
      name: "Meeting",
      imagePath: Assets.images.meetingImg.path,
      darkImagePath: Assets.images.meetingDarkImg.path,
      icon: Icons.group_outlined,
    ),
    CategoryData(
      id: "exhibition",
      name: "Exhibition",
      imagePath: Assets.images.exhibitionImg.path,
      darkImagePath: Assets.images.exhibitionDarkImg.path,
      icon: Icons.sports_handball,
    ),
  ];


  static CategoryData getCategoryById(String categoryId) {
    return categories.firstWhere((category) => category.id == categoryId);
  }
}