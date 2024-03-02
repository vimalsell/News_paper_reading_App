import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/article_model.dart';
import '../models/slider_model.dart';
import '../services/news.dart';
import '../services/slider_data.dart';
class AllNews extends StatefulWidget {
  String news;
   AllNews({required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<SliderModel> sliders =[];
  List<ArticleModel>articles=[];
  void initState() {
    getSlider();
    getNews();
    super.initState();
  }
  getNews()async{
    News newsclass = News();
    await newsclass.getNews();
    articles=newsclass.news;
    setState(() {

    });
  }
  getSlider()async {
    Sliders slider = Sliders();
    await slider.getSlider();
    sliders = slider.sliders;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text(widget.news+' News',style: const TextStyle(
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
            itemCount: widget.news=='Breaking'? sliders.length:articles.length,
            itemBuilder: (context, index){
              return AllNewsSection(
                  title: widget.news=='Breaking' ? sliders[index].title! : articles[index].title!,
                  desc: widget.news=='Breaking' ? sliders[index].description! : articles[index].description!,
                  Image: widget.news=='Breaking' ? sliders[index].urlToImage! : articles[index].urlToImage!);
            }),
      ),
    );
  }
}

class AllNewsSection extends StatelessWidget {
  String Image,desc,title;
  AllNewsSection({required this.Image,required this.title,required this.desc});

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