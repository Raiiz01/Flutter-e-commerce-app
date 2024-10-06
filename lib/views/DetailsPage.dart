import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:myapp/Controller/Card_Controller.dart';

import '../constants/Thems.dart';
import 'CardPage.dart';

class DetailsPage extends ConsumerWidget {
  const DetailsPage({super.key,
  required this.getIndex,
  });

  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Cards = ref.watch(cardNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: Text(Cards[getIndex].title, overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
        centerTitle: true,
        elevation: 0,
        actions: [
         Padding(padding: EdgeInsets.all(8),
          child: IconButton(onPressed: (){},
            icon: const Icon(Icons.notification_add_outlined, size: 30,),),),
        const Padding(padding: EdgeInsets.all(10),
        child:  Icon(Icons.search_outlined, size: 30,),)],
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (constex) => CardApp()));
        },
        icon: Icon(Icons.arrow_back_ios)),
        ),
        drawer: const Drawer(
          backgroundColor: Colors.black,),
      body: SingleChildScrollView(
        child: Container(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image(image: AssetImage(Cards[getIndex].imgUrl),
                fit: BoxFit.cover,
                ),
              ),
              Gap(4),
             Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Cards[getIndex].title, style: AppTheme.KCardTitle.copyWith(fontSize: 30),),
                    Text(Cards[getIndex].longDescription, style: AppTheme.KBodyText.copyWith(fontSize: 18),),
                    Text('\$ ${Cards[getIndex].price}', style: AppTheme.KCardTitle.copyWith(fontSize: 30),),
                    Row(children: [
                    RatingBar(
                      initialRating: Cards[getIndex].rating,
                      maxRating: 5,
                      minRating: 1,
                      allowHalfRating: true,
                      itemSize: 20,
                      ratingWidget: RatingWidget(
                      full: Icon(Icons.star),
                      half: Icon(Icons.star_half,),
                      empty: Icon(Icons.star_border)),
                      onRatingUpdate: ((value) => null),  
                    ),   
                    Gap(6),
                    Text(Cards[getIndex].review.toString() + " revies", style: AppTheme.KCardTitle.copyWith(fontSize: 15),),
                    ],)   
                  ],
                ),
              ),
              Gap(8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Color.fromARGB(255, 227, 207, 135),
                  foregroundColor: Colors.black,
                  shape: StadiumBorder()
                ),
                onPressed: (){},
              child: Text("Submit"))
          ],),
        ),
      ),
    );
  }
}