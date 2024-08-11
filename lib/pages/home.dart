import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_reading_app/models/article_model.dart';
import 'package:news_reading_app/models/show_category.dart';
import 'package:news_reading_app/pages/all_news.dart';
import 'package:news_reading_app/pages/category_news.dart';
import 'package:news_reading_app/services/getCategories.dart';
import 'package:news_reading_app/services/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../models/category_model.dart';
import '../models/slider_model.dart';
import '../services/news.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories =[];
  List<SliderModel> sliders =[];
  List<ArticleModel>articles=[];
  bool _loading = true;
  int activeIndex=0;
  @override
  void initState() {
    categories=getCategories();
    getSlider();
    getNews();
    super.initState();
  }

  getNews()async{
    News newsclass = News();
    await newsclass.getNews();
    articles=newsclass.news;
    setState(() {
      _loading=false;
    });
  }
  getSlider()async {
    Sliders slider = Sliders();
    await slider.getSlider();
    sliders = slider.sliders;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text('Flutter',style: TextStyle(
                fontWeight: FontWeight.bold),
            ),
            Text('News',style:TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold),
            )
          ],
        ),
        elevation: 0.0,
      ),
      body: _loading ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left:10),
                height: 70,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                    itemBuilder: (context,index){
                    return CategoryTile(categoryName: categories[index].categoryName,image:categories[index].image,);
                    }),
              ),
              SizedBox(height: 30,),
               Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Breaking News!',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AllNews(news: 'Breaking')));
                      },
                        child: Text('View All',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),)),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              CarouselSlider.builder(itemCount: 5, itemBuilder: (context,index,realIndex){
                  String? res =sliders[index].urlToImage;
                  String? res1 = sliders[index].title;
                  return buildImage(res!, index, res1!);
              }, options: CarouselOptions(
                  height: 250,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (index,reason){
                    setState(() {
                      activeIndex=index;
                    });
                }
              )),
              SizedBox(height: 30,),
              Center(child: buildIndicator()),
              SizedBox(height: 30,),
               Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Trending News!',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AllNews(news: 'Trending')));
                      },
                        child: Text('View All',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),)),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: articles.length,
                    itemBuilder: (context, index){
                    return BlocTile(title: articles[index].title!, desc: articles[index].description!, ImageToUrl: articles[index].urlToImage!);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildImage(String image,int index,String name)=>Container(
    margin: EdgeInsets.symmetric(horizontal: 5 ),
    child: Stack(
      children:[ClipRRect(
        borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(imageUrl: image,height:250,fit: BoxFit.cover,width: MediaQuery.of(context).size.width,)),
        Container(
          height: 250,
          margin: EdgeInsets.only(top: 170),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
          ),
          child: Text(name,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
        )
    ]),
  );
  Widget buildIndicator()=>AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: 5,
    effect:  SlideEffect(dotWidth: 15,dotHeight: 15,activeDotColor: Colors.blue),
  );
}
class BlocTile extends StatelessWidget {
  String ImageToUrl,title,desc;
   BlocTile({required this.title,required this.desc,required this.ImageToUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: (){

        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
              child: Row(
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(imageUrl: ImageToUrl,height: 120,width: 120,fit: BoxFit.cover,),
                    ),
                  ),
                  SizedBox(width: 8,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width/1.8,
                          child: Text(title,
                            maxLines: 2,
                            style:
                          TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                          )
                      ),
                      SizedBox(height: 8,),
                      Container(
                          width: MediaQuery.of(context).size.width/1.8,
                          child: Text(desc,
                            maxLines: 3,
                            style:
                          TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                          )
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final image,categoryName;
  const CategoryTile({this.image,this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
          CategoryNews(name: categoryName)));
      },
      child: Container(
        margin: const EdgeInsets.only(right:16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius:BorderRadius.circular(6),
                child: Image.asset(image,width: 120,height: 70,fit: BoxFit.cover,)),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black38,
              ),
            width: 120,
                height: 70,
                child: Center(
                  child: Text(categoryName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                )
            )
          ],
        ),

      ),
    );
  }
}

