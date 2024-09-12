import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Controller/newscontroller.dart';
import 'detailpage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<NewsController>(context, listen: false).fetchNewsWithHttp();// Or fetchNewsWithDio() for comparison
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsController = Provider.of<NewsController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              newsController
                  .fetchNewsWithHttp(); // Or fetchNewsWithDio() for comparison
            },
          )
        ],
      ),
      body: newsController.isLoading
          ? Center(child: CircularProgressIndicator())
          : newsController.errorMessage.isNotEmpty
              ? Center(child: Text(newsController.errorMessage))
              : ListView.builder(
                  itemCount: newsController.articles.length,
                  itemBuilder: (context, index) {
                    final article = newsController.articles[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(article: article),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              article.urlToImage,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(article.title),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 15),
                              child: Text(newsController.formatDate(article.publishedAt)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}