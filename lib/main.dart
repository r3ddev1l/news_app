import 'package:flutter/material.dart';
import 'package:news_app/pages/article_detail_page.dart';
import 'package:news_app/pages/article_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ArticleDetailPage(),
    );
  }
}
