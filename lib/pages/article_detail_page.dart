import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_article_bloc.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/pages/article_list_page.dart';

class ArticleDetailPage extends StatefulWidget {
  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  NewsArticleBloc _newsArticleBloc;
  NewsDetailPageArguments _newsDetailPageArguments;

  @override
  void initState() {
    super.initState();
    _newsArticleBloc = BlocProvider.of<NewsArticleBloc>(context);
    _newsArticleBloc.add(FetchNewsArticleEvent());
  }

  @override
  Widget build(BuildContext context) {
    _newsDetailPageArguments = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Hero(
                      tag: _newsDetailPageArguments.index,
                      child: Container(
                        child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder:
                                "assets/images/NewsImagePlaceHolder.png",
                            image: _newsDetailPageArguments.imageURL),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: MediaQuery.of(context).size.height * .4,
                        width: double.infinity,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_outlined),
                      color: Colors.grey,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  _newsDetailPageArguments.title,
                  style: TextStyles.newsArticleTitle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _newsDetailPageArguments.source,
                      style: TextStyles.newsArticleDateSource,
                    ),
                    Text(
                      _newsDetailPageArguments.date,
                      style: TextStyles.newsArticleDateSource,
                    ),
                  ],
                ),
                Text(
                  _newsDetailPageArguments.description,
                  style: TextStyles.newsArticleDescription,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
