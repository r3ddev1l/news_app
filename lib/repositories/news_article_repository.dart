import 'dart:convert';

import 'package:news_app/constants/constants.dart';
import 'package:news_app/models/news_Articles.dart';
import 'package:http/http.dart' as http;

abstract class NewsArticleRepository {
  Future<NewsArticles> getNewsArticles();
}

class NewsArticleRepositoryImplementation implements NewsArticleRepository {
  @override
  Future<NewsArticles> getNewsArticles() async {
    try {
      var response = await http.get(Strings.newsURL);
      if (response.statusCode == 200) {
        var articles = json.decode(response.body);
        var newsArticles = NewsArticles.fromJson(articles);

        return newsArticles;
      } else {
        throw Exception('Network error');
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
