import 'dart:convert';

import '../models/article_model.dart';
import 'package:http/http.dart' as http;

class News{
  List<ArticleModel>news =[];

  Future<void> getNews()async{
    String url='https://newsapi.org/v2/everything?q=tesla&from=2024-01-23&sortBy=publishedAt&apiKey=cc9bbfb63a7e42749325276e4e2761f2';
    var response= await http.get(Uri.parse(url));
    var jsonData =jsonDecode(response.body);
    if(jsonData['status']=='ok'){
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = new ArticleModel(
              title: element['title'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content'],
            author:element['author'],
          );
              news.add(articleModel);
        }
      }
        );
      }
    }
  }