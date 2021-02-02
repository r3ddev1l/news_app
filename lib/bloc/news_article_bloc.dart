import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/models/news_Articles.dart';
import 'package:news_app/repositories/news_article_repository.dart';

part 'news_article_event.dart';
part 'news_article_state.dart';

class NewsArticleBloc extends Bloc<NewsArticleEvent, NewsArticleState> {
  NewsArticleRepository newsArticleRepository;
  NewsArticleBloc({this.newsArticleRepository})
      : super(NewsArticleInitialState());

  @override
  Stream<NewsArticleState> mapEventToState(
    NewsArticleEvent event,
  ) async* {
    if (event is FetchNewsArticleEvent) {
      yield NewsArticleLoadingState();
      try {
        NewsArticles newsArticles =
            await newsArticleRepository.getNewsArticles();
        yield NewsArticleLoadedState(newsArticles: newsArticles);
      } catch (e) {
        yield NewsArticleLoadingErrorState(errorMessage: e.toString());
      }
    }
  }
}
