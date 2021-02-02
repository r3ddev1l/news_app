part of 'news_article_bloc.dart';

abstract class NewsArticleState extends Equatable {}

class NewsArticleInitialState extends NewsArticleState {
  @override
  List<Object> get props => [];
}

class NewsArticleLoadingState extends NewsArticleState {
  @override
  List<Object> get props => [];
}

class NewsArticleLoadedState extends NewsArticleState {
  final NewsArticles newsArticles;

  NewsArticleLoadedState({this.newsArticles});

  @override
  List<Object> get props => [newsArticles];
}

class NewsArticleLoadingErrorState extends NewsArticleState {
  final String errorMessage;

  NewsArticleLoadingErrorState({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
