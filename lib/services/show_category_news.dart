import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_reading_app/models/show_category.dart';

class ShowCategoryNews{
  List<ShowCategoryModel>categories =[];

  Future<void> getCategoryNews(String category)async{
    String url='https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=cc9bbfb63a7e42749325276e4e2761f2';
    var response= await http.get(Uri.parse(url));
    var jsonData =jsonDecode(response.body);
    if(jsonData['status']=='ok'){
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ShowCategoryModel categoryModel= new ShowCategoryModel(
            title: element['title'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            author:element['author'],
          );
          categories.add(categoryModel);
        }
      }
      );
    }
  }
}