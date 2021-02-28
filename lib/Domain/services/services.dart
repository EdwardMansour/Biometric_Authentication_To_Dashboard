import 'dart:convert';
import 'package:biometric_dashboard/models/most_popular_api_data/most_popular_news.dart';
import 'package:biometric_dashboard/models/quotes_data/quotes.dart';
import 'package:dio/dio.dart';

class Services {
  final Dio dio;
  final Options options;
  Services({
    this.dio,
    this.options,
  }) : assert(dio != null);

//! based url
  final _basedUrlNyTimes = 'https://api.nytimes.com';
  final _basedUrlQuote = 'https://zenquotes.io';
  //! token key of my account
  final _tokenKey = 'VKbSZ1UyoIHASQnpnT3fF4yFAWx63HX0';

  //! get the most populare news
  Future<MostPopularData> fetchNews(String section, int time) async {
    final url =
        '$_basedUrlNyTimes/svc/mostpopular/v2/mostviewed/$section/$time.json';
    var response = await dio.get(
      '$url',
      queryParameters: {
        "api-key": _tokenKey,
      },
      options: options,
    );
    final rawData = jsonDecode(jsonEncode(response.data));
    var data = MostPopularData.fromJson(rawData);

    return data;
  }

  //! get the quote of today
  Future<List<Quotes>> fetchTodayQuote() async {
    final url = '$_basedUrlQuote/api/today';
    var response = await dio.get(
      '$url',
      options: options,
    );
    List<Quotes> data = List<Quotes>.from(
        json.decode(response.data).map((x) => Quotes.fromJson(x)));

    return data;
  }
}
