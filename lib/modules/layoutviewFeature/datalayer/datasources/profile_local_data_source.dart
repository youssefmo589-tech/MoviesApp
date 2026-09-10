import 'dart:convert';
import 'package:movieapp/modules/layoutviewFeature/datalayer/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProfileLocalDataSource {

  Future<List<MovieModel>> getWatchList();
  Future<void> saveToWatchList(List<MovieModel> watchList);

  Future<List<MovieModel>> getHistory();
  Future<void> saveToHistory(List<MovieModel> history);
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  static const String _watchListKey = 'WATCH_LIST_KEY';
  static const String _historyKey = 'HISTORY_KEY';

  @override
  Future<List<MovieModel>> getWatchList() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString(_watchListKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);

      return jsonList.map((item) => MovieModel.fromJson(item)).toList();
    }
    return [];
  }

  @override
  Future<List<MovieModel>> getHistory() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString(_historyKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);

      return jsonList.map((item) => MovieModel.fromJson(item)).toList();
    }
    return [];
  }

  @override
  Future<void> saveToWatchList(List<MovieModel> watchList) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final jsonList = watchList.map((movie) => movie.toJson()).toList();
    await sharedPreferences.setString(_watchListKey, jsonEncode(jsonList));
  }

  @override
  Future<void> saveToHistory(List<MovieModel> history) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final jsonList = history.map((movie) => movie.toJson()).toList();
    await sharedPreferences.setString(_historyKey, jsonEncode(jsonList));
  }
}