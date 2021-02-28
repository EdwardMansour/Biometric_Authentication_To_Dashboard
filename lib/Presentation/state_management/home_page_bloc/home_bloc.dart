import 'dart:async';

import 'package:biometric_dashboard/Domain/repositories/repository.dart';
import 'package:biometric_dashboard/models/most_popular_api_data/most_popular_news.dart';
import 'package:biometric_dashboard/models/most_popular_api_data/results.dart';
import 'package:biometric_dashboard/models/quotes_data/quotes.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Repositories repositories;
  HomeBloc({@required this.repositories}) : super(HomeInitial());

  Quotes _quote;
  List<Result> _result = [];

  List<Result> newsMostPopularData() => _result;
  get quoteFirst => _quote;

  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is FetchDataEvent) {
      yield* setAuthAvailableTopMap(event);
    } else if (event is InitializeEvent) {
      yield* initializeToMap(event);
    }
  }

  //! Initilize
  Stream<HomeState> initializeToMap(
    InitializeEvent event,
  ) async* {
    yield HomeInitial();
  }

  //! Fetch data at the same time
  Stream<HomeState> setAuthAvailableTopMap(
    FetchDataEvent event,
  ) async* {
    try {
      //! Start loading
      yield LoadingState(
        isLoading: true,
      );
      //! call 2 API's request at the same time
      await Future.wait([
        repositories.fetchTodayQuote(),
        repositories.fetchNews('all-sections', 1),
      ]).then((res) {
        List<Quotes> f = res[0];
        _quote = f.first;
        MostPopularData mostPopularData = res[1];
        _result = mostPopularData.results;
      });
      //! stop loading
      yield LoadingState(
        isLoading: false,
      );
    } catch (e) {
      //! stop loading
      yield LoadingState(
        isLoading: false,
      );
      //! Error
      yield ErrorLoadingState(
        message: 'Error $e !',
      );
    }
  }
}
