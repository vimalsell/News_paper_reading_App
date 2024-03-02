import 'package:flutter/material.dart';
import 'package:news_reading_app/pages/home.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          children: [
            Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset('images/building.jpg',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/1.5,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text('News from around the\n      world for you',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: Colors.black),),
            SizedBox(height: 20,),
            Text('Best time to read, Take your time to read\n              a little more of the world',
                style: TextStyle(color:Colors.black26,fontSize: 18,fontWeight: FontWeight.bold)),
             SizedBox(height: 40,),
             GestureDetector(
               onTap: (){
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()
                 ));
               },
               child: Container(
                 width: MediaQuery.of(context).size.width/1.2,
                 child: Material(
                   borderRadius: BorderRadius.circular(30),
                   elevation: 5,
                   child: Container(
                     padding: EdgeInsets.symmetric(vertical: 15),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(30),
                       color: Colors.blue,
                     ),
                     child: Center(child: Text('Get Started',
                       style: TextStyle(fontSize: 16,
                           color: Colors.white,
                           fontWeight: FontWeight.w500),)),
                   ),
                 ),
               ),
             )
          ],
        ),
      ),
    );
  }
}
