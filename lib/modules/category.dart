import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;
  final AssetImage imageURL;

  Category(
      {required this.imageURL,
      required this.id,
      required this.title,
      this.color = Colors.orange});
}
