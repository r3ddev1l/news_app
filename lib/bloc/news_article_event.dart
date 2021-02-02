part of 'news_article_bloc.dart';

abstract class NewsArticleEvent extends Equatable {}

class FetchNewsArticleEvent extends NewsArticleEvent {
  @override
  List<Object> get props => null;
}
