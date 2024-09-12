import 'package:flutter/material.dart';
import '../Model/newsmodel.dart';

class DetailPage extends StatelessWidget {
  final NewsArticle article;

  DetailPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(article.urlToImage),
            SizedBox(height: 16),
            Text(
              article.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(article.content),
          ],
        ),
      ),
    );
  }
}
