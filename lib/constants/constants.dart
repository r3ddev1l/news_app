import 'package:flutter/material.dart';

class Strings {
  static String newsURL =
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=08d66a7ff9d64331873302995b360f95';
}

class TextStyles {
  static const newsArticleTitle = TextStyle(
    fontSize: 56,
    fontWeight: FontWeight.bold,
  );
  static const newsArticleDescription = TextStyle(
    fontSize: 32,
  );
  static const newsArticleDateSource =
      TextStyle(fontSize: 16, color: Colors.grey);
}
