import 'package:flutter/widgets.dart';
import 'package:news_app/pages/article_detail_page.dart';

import 'package:news_app/pages/article_list_page.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => ArticleListPage(),
  "articleDetailPage": (BuildContext context) => ArticleDetailPage()
};
