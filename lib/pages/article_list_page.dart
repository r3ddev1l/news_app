import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app/bloc/news_article_bloc.dart';
import 'package:news_app/constants/constants.dart';
import 'package:pagination_view/pagination_view.dart';

class ArticleListPage extends StatefulWidget {
  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  int page;
  PaginationViewType paginationViewType;
  NewsArticleBloc _newsArticleBloc;
  ScrollController _scrollController = ScrollController();
  List articleList = List();
  GlobalKey<PaginationViewState> key;
  int shownItem = 6;

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
                  height: 600,
                  // MediaQuery.of(context).size.height *
                  //     .8, //Takes up 80 % of the screen height
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

                        //to display the initial List items
                        if (articleList.length == 0) {
                          for (var i = 0; i < shownItem; i++) {
                            articleList
                                .add(state.newsArticles.articles[i].source);
                          }
                        }

                        //add additional list items when the user scrolls beyond the end of the screen
                        _scrollController.addListener(
                          () {
                            if (_scrollController.position.pixels ==
                                _scrollController.position.maxScrollExtent) {
                              for (int i = shownItem; i < shownItem + 3; i++) {
                                articleList.add(state.newsArticles.articles[i]);
                              }

                              shownItem = shownItem + 3;
                              if (shownItem > articleList.length) {
                                shownItem = articleList.length - 1;
                              }
                              setState(
                                () {
                                  if (shownItem == articleList.length) {
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Loaded"),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  }
                                },
                              );
                            }
                          },
                        );
                        return ListView.builder(
                            controller: _scrollController,
                            itemCount: shownItem,
                            itemBuilder: (context, index) {
                              // if (shownItem == 19) {
                              //   setState(
                              //     () {
                              //       Scaffold.of(context).showSnackBar(
                              //         SnackBar(
                              //           content: Text("End of the List"),
                              //           duration: Duration(seconds: 1),
                              //         ),
                              //       );
                              //     },
                              //   );
                              // }
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
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
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
