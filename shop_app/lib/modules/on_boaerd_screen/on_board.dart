import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/shared_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  List<BoardingDetails>boardingDetails=[
    BoardingDetails(image: 'assets/images/b1.jpg', title: 'You Don\'t Have To Go Shopping', body: 'In past you had to go shopping but it waste your time'),
    BoardingDetails(image: 'assets/images/b2.jpg', title: 'Now The Life Is Easy', body: 'you can buy anything without going out your home anymore'),
    BoardingDetails(image: 'assets/images/b3.jpg', title: 'Stay Home, Stay Safe', body: 'During covid19, you shouldn\'t risk your life and going out'),
    BoardingDetails(image: 'assets/images/b4.jpg', title: 'Your Order Welcome To Your Home', body: 'it\'s easy now , you receive your order faster by using drones delivery'),
  ];

  var controller=PageController();

  int idx=0;
 @override

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          actions: [
            actionBarSkip(context),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index){
                   idx=index;
                },
                controller: controller,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => pageViewItem(boardingDetails[index]),
                itemCount: boardingDetails.length,
              ),
            ),
            restOnBoardingScreen(context),
          ],
        ));
  }
  Widget pageViewItem(BoardingDetails board) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image(
                image: AssetImage('${board.image}'),
              ),
            ),
            Text(
              '${board.title}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: HexColor('180040')
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '${board.body}',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
  Widget actionBarSkip(context) =>Padding(
    padding: const EdgeInsets.all(9.0),
    child: TextButton(
      onPressed: (){
        SharedHelper.Save(value: true, key:'onBoarding').then((value){
          if(value){
            navigateToWithoutReturn(context, LogInScreen());
          }
        });
      },
      child:  Text(
        'SKIP',
        style: TextStyle(
          color: HexColor('180040'),
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
  Widget restOnBoardingScreen(context) => Padding(
   padding: EdgeInsets.all(15.0),
   child: Row(
     children: [
       SmoothPageIndicator(
           controller: controller,
           count: boardingDetails.length,
           effect: ExpandingDotsEffect(
           activeDotColor: HexColor('180040'),
         ),
       ),
       const Spacer(),
       FloatingActionButton(
         onPressed: () {
           if(idx==boardingDetails.length-1){
             SharedHelper.Save(value: true, key:'onBoarding').then((value){
               if(value){
                 navigateToWithoutReturn(context, LogInScreen());
               }
             });
           }else{
             controller.nextPage(
                 duration:const Duration(seconds: 1) ,
                 curve: Curves.fastLinearToSlowEaseIn);
           }
         },
         child: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
       ),
     ],
   ),
 );
}

class BoardingDetails{
  String image;
  String title;
  String body;
  BoardingDetails({required this.image,required this.title,required this.body});
}
