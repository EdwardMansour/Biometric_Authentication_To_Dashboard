import 'package:biometric_dashboard/Domain/services/services.dart';
import 'package:biometric_dashboard/models/most_popular_api_data/most_popular_news.dart';
import 'package:biometric_dashboard/models/quotes_data/quotes.dart';
import 'package:flutter/material.dart';

class Repositories {
  final Services services;
  Repositories({
    @required this.services,
  }) : assert(services != null);

  //! most popular list data
  Future<MostPopularData> fetchNews(String section, int time) async {
    return await services.fetchNews(section, time);
  }

  //! quote today data
  Future<List<Quotes>> fetchTodayQuote() async {
    return await services.fetchTodayQuote();
  }
}
