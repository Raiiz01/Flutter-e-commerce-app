import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:myapp/Controller/Card_Controller.dart';

import '../constants/Thems.dart';

class CardWidget extends ConsumerWidget {
  CardWidget({
    super.key,
    required this.CardIndex,
  });

  final int CardIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Cards = ref.watch(cardNotifierProvider);
    return Container(
      height: 300,
        margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 240, 231, 231),
        borderRadius: BorderRadius.circular(8),
        boxShadow:[
          BoxShadow(
            offset: Offset(2, 2.5),
            color: Colors.black.withOpacity(0.7),
            spreadRadius: 2,
            blurRadius: 3,
          )
        ]
        ),
        width: MediaQuery.of(context).size.width*0.9,    
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Color.fromRGBO(238, 237, 230, 1),
              margin: EdgeInsets.all(4),
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image(image: AssetImage(Cards[CardIndex].imgUrl),
                fit: BoxFit.fill,
                ),
              ),
            ),
          ),
           SingleChildScrollView(
             child: Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Cards[CardIndex].title, style: AppTheme.KCardTitle, overflow: TextOverflow.ellipsis,),
                    Gap(4),
                    Text(Cards[CardIndex].shortDescription, style: AppTheme.KBodyText,),
                    Gap(4),
                    Text('\$${Cards[CardIndex].price}', style: AppTheme.kCardtext,),
                    Gap(4),
                    RatingBar(
                      initialRating: Cards[CardIndex].rating,
                      maxRating: 5,
                      minRating: 1,
                      allowHalfRating: true,
                      itemSize: 20,
                      ratingWidget: RatingWidget(
                      full: Icon(Icons.star),
                      half: Icon(Icons.star_half),
                      empty: Icon(Icons.star_border)),
                      onRatingUpdate: ((value) => null),  
                    ),      
                  ],
                ),
              )
                     ),
           ),
        // Expanded(child: Padding(
        //   padding: EdgeInsets.only(right: 20, bottom: 10),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     crossAxisAlignment: CrossAxisAlignment.end,
        //     children: [
        //     IconButton(onPressed: (){},
        //     icon: Icon(Icons.do_not_disturb_on)),
        //     IconButton(onPressed: (){},
        //     icon: Icon(Icons.add_circle)),
        //   ],),
        // ))
        ],
        ),
    );
  }
}