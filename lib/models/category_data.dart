import 'package:flutter/cupertino.dart';

class CategoryData {

  final String id;
  final String name;
  final String imagePath;
  final String darkImagePath;
  final IconData icon;

  CategoryData ({required this.id, required this.name, required this.imagePath, required this.darkImagePath, required this.icon});
}