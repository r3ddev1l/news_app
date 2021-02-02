import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:news_app/constants/constants.dart';

void main() {
  test("api_test", () async {
    NewsArticlesAPI newsArticlesAPI = NewsArticlesAPI();
    var newsArticles = await newsArticlesAPI.getNewsArticles();
  });
}

class NewsArticlesAPI {
  Future<NewsArticles> getNewsArticles() async {
    var response = await http.get(Strings.newsURL);
    var newsArticles = json.decode(response.body);
    print(newsArticles);
    print("News Article Title::::");
    print(newsArticles["articles"][0]["title"]);
  }
}

//Model class for news articles

NewsArticles newsArticlesFromJson(String str) =>
    NewsArticles.fromJson(json.decode(str));

String newsArticlesToJson(NewsArticles data) => json.encode(data.toJson());

class NewsArticles {
  NewsArticles({
    @required this.status,
    @required this.totalResults,
    @required this.articles,
  });

  final String status;
  final int totalResults;
  final List<Article> articles;

  factory NewsArticles.fromJson(Map<String, dynamic> json) => NewsArticles(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class Article {
  Article({
    @required this.source,
    @required this.author,
    @required this.title,
    @required this.description,
    @required this.url,
    @required this.urlToImage,
    @required this.publishedAt,
    @required this.content,
  });

  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"] == null ? null : json["author"],
        title: json["title"],
        description: json["description"] == null ? null : json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"] == null ? null : json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"] == null ? null : json["content"],
      );

  Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author == null ? null : author,
        "title": title,
        "description": description == null ? null : description,
        "url": url,
        "urlToImage": urlToImage == null ? null : urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content == null ? null : content,
      };
}

class Source {
  Source({
    @required this.id,
    @required this.name,
  });

  final String id;
  final String name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"] == null ? null : json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name,
      };
}
