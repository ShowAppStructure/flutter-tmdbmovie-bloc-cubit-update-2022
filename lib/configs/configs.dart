import 'package:flutter_config/flutter_config.dart';

class Config {
  // static String apiKey = FlutterConfig.get('API_KEY');
  // static String baseUrl = FlutterConfig.get('BASE_URL');
  // static String baseImageUrl = FlutterConfig.get('IMAGE_URL');
  static String apiKey = "49ffbe6658eac030267d0603d24e1b22";
  static String baseUrl = "https://api.themoviedb.org/3";
  static String baseImageUrl = "https://image.tmdb.org/t/p/w500/";

  static String popularUrl = '$baseUrl/movie/popular?api_key=$apiKey&page=1';
  static String genreMovieListUrl =
      '$baseUrl/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1';
  static String topRatedUrl =
      '$baseUrl/movie/top_rated?api_key=$apiKey&language=en-EN&page=1';
  static String seacrhMovieUrl =
      '$baseUrl/search/movie?api_key=$apiKey&language=en-US&page=1&include_adult=false';
  static String upcomingMovieUrl =
      '$baseUrl/movie/upcoming?api_key=$apiKey&language=en-US&page=1';
  static movieDetailUrl(int movieId) =>
      '$baseUrl/movie/$movieId?api_key=$apiKey&append_to_response=images';
  static movieCreditlUrl(int movieId) =>
      '$baseUrl/movie/$movieId/credits?api_key=$apiKey';
  static similiarMovieUrl(int movieId) => '$baseUrl/movie/$movieId/similar?api_key=$apiKey&page=1';
}
