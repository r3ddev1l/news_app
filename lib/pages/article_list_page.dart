import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app/bloc/news_article_bloc.dart';
import 'package:news_app/constants/constants.dart';

class ArticleListPage extends StatefulWidget {
  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  NewsArticleBloc _newsArticleBloc;

  @override
  void initState() {
    super.initState();
    _newsArticleBloc = BlocProvider.of<NewsArticleBloc>(context);
    _newsArticleBloc.add(FetchNewsArticleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyBuilder(),
    );
  }

//main body building method
  Widget bodyBuilder() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '''News
App''',
                style: TextStyles.newsListPageHeaderStyle,
              ),
              Container(
                  height: MediaQuery.of(context).size.height *
                      .8, //Takes up 80 % of the screen height
                  child: BlocBuilder<NewsArticleBloc, NewsArticleState>(
                    cubit: _newsArticleBloc,
                    builder: (context, state) {
                      if (state is NewsArticleInitialState) {
                        print("NewsArticleInitialState");
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is NewsArticleLoadingState) {
                        print("NewsArticleLoadingState");
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is NewsArticleLoadedState) {
                        print("NewsArticleLoadedState");
                        return ListView.builder(
                            itemCount: state.newsArticles.articles.length,
                            itemBuilder: (context, index) {
                              return newsCardBuilder(
                                  index: index, state: state);
                            });
                      } else if (state is NewsArticleLoadingErrorState) {
                        print("NewsArticleLoadingErrorState");
                        return Center(
                          child: Text("Loading failed"),
                        );
                      }
                      return null;
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }

//news article card building method
  Widget newsCardBuilder({int index, var state}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 5,
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(
            context,
            "articleDetailPage",
            arguments: NewsDetailPageArguments(
                index: index,
                imageURL: state.newsArticles.articles[index].urlToImage,
                title: state.newsArticles.articles[index].title,
                description: state.newsArticles.articles[index].description,
                source: state.newsArticles.articles[index].source.name,
                date: dateFormatter(
                    date: state.newsArticles.articles[index].publishedAt)),
          );
        },
        leading: Hero(
          tag: index,
          child: Container(
            child: FadeInImage.assetNetwork(
                fit: BoxFit.fitWidth,
                placeholder: "assets/images/NewsImagePlaceHolder.png",
                image: state.newsArticles.articles[index].urlToImage),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            height: 64,
            width: 64,
          ),
        ),
        title: Wrap(
          children: [
            Text(state.newsArticles.articles[index].title),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(state.newsArticles.articles[index].source.name),
            Text(dateFormatter(
                date: state.newsArticles.articles[index].publishedAt))
          ],
        ),
      ),
    );
  }

  //Date formatter
  dateFormatter({var date}) {
    final DateFormat formatter = DateFormat.yMMMd('en_US');
    final String formattedDate = formatter.format(date);
    return formattedDate;
  }
}

class NewsDetailPageArguments {
  int index;
  String imageURL;
  String title;
  String description;
  String source;
  String date;
  NewsDetailPageArguments(
      {this.index,
      this.imageURL,
      this.title,
      this.description,
      this.source,
      this.date});
}
