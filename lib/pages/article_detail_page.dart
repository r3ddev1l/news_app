import 'package:flutter/material.dart';
import 'package:news_app/constants/constants.dart';

class ArticleDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(16)),
                      height: MediaQuery.of(context).size.height * .4,
                      width: double.infinity,
                    ),
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios_outlined),
                        onPressed: () {}),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Title",
                  style: TextStyles.newsArticleTitle,
                ),
                Text(
                  "Description",
                  style: TextStyles.newsArticleDescription,
                ),
                Text(
                  "Source",
                  style: TextStyles.newsArticleDateSource,
                ),
                Text(
                  "Date",
                  style: TextStyles.newsArticleDateSource,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
