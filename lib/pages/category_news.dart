
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_reading_app/services/show_category_news.dart';

import '../models/show_category.dart';
class CategoryNews extends StatefulWidget {
  String name;
   CategoryNews({required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categories =[];
  bool _loading=true;


  getCategory()async{
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    await showCategoryNews.getCategoryNews(widget.name.toLowerCase());
    categories=showCategoryNews.categories;
    setState(() {
      _loading=false;
    });
  }
  @override
  void initState() {
    super.initState();
    getCategory();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text(widget.name,style: const TextStyle(
                fontWeight: FontWeight.bold),
            ),
          ],
        ),
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (context, index){
              return Showcategory(title: categories[index].title!, desc: categories[index].description!, Image: categories[index].urlToImage!);
            }),
      ),
    );
  }
}
class Showcategory extends StatelessWidget {
  String Image,desc,title;
   Showcategory({required this.Image,required this.title,required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(imageUrl: Image,width: MediaQuery.of(context).size.width,height: 200,fit: BoxFit.cover,)),
          SizedBox(height: 5,),
          Text(title,maxLines:2,style: TextStyle(fontSize:18,fontWeight: FontWeight.bold,color: Colors.black),),
          Text(desc,maxLines: 3,),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
