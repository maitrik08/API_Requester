import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../Model/newsmodel.dart';

class NewsController with ChangeNotifier {
  List<NewsArticle> _articles = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<NewsArticle> get articles => _articles;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchNewsWithHttp() async {
    final url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=3b0fae72f0cc4992b73a70a51aef56ce';
    try {
      _isLoading = true;
      notifyListeners();
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List articles = data['articles'];
        _articles = articles.map((article) => NewsArticle.fromJson(article)).toList();
      } else {
        _errorMessage = 'Failed to load news.';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchNewsWithDio() async {
    final url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=3b0fae72f0cc4992b73a70a51aef56ce';
    Dio dio = Dio();
    try {
      _isLoading = true;
      notifyListeners();
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        List articles = response.data['articles'];
        _articles = articles.map((article) => NewsArticle.fromJson(article)).toList();
      } else {
        _errorMessage = 'Failed to load news.';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String formatDate(String dateString) {
  DateTime date = DateTime.parse(dateString);
  return DateFormat('yyyy-MM-dd  h:mm a').format(date);
  }
}
