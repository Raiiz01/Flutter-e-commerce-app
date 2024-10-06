import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:myapp/Controller/Card_Controller.dart';
import 'package:myapp/constants/ThemeManager.dart';
import 'package:myapp/constants/themes.dart';
import 'package:myapp/views/login.dart';

import '../Widgets/card_widget.dart';
import '../constants/Thems.dart';
import 'DetailsPage.dart';
import 'chip_widget.dart';

ThemeManager obj = ThemeManager();

class CardApp extends ConsumerWidget {
  CardApp({super.key,
   });

  
  
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Cards = ref.watch(cardNotifierProvider);
    return MaterialApp(
      theme: LightTheme,
      darkTheme: DarkTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Card Page",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
        centerTitle: true,
        elevation: 0,
        actions: [
         Padding(padding: EdgeInsets.all(8),
          child: IconButton(onPressed: (){},
            icon: const Icon(Icons.notification_add_outlined, size: 30,),),),
        const Padding(padding: EdgeInsets.all(10),
        child:  Icon(Icons.search_outlined, size: 30,),),
        ],
        leading: IconButton(onPressed: (){
          Get.off(AuthScreen());
        },
        icon: Icon(Icons.arrow_back_ios)),
        ),
          body: SingleChildScrollView(
            child: Container(
              decoration:const BoxDecoration(image: 
              DecorationImage(image: AssetImage("assets/all/m.jpeg"),
              fit: BoxFit.cover,
              ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                    Colors.white.withOpacity(0.9),
                    Colors.white.withOpacity(0.9)
                  ])
                ),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text("Raiiz Commerce", style: TextStyle(
                          fontSize: 26, fontWeight: FontWeight.bold),),
                        Text("See More", style: TextStyle(
                          fontSize: 18, color: Colors.blue,
                          decoration: TextDecoration.underline,
                          ),
                          ),
                      ],),
                     const SizedBox(height: 12,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(image: AssetImage("assets/general/landing.png"),
                          fit: BoxFit.cover,
                          ),
                        ),
                        height: 200,
                        width: double.infinity,
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child:  Padding(
                            padding:  EdgeInsets.all(12),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  shape: StadiumBorder(),
                                ),
                                onPressed: (){},
                              child:  Text("Louch Here", 
                              style: AppTheme.kCardtext.copyWith(
                                decoration: TextDecoration.underline),),),
                              const SizedBox(height: 12,),
                              const Text("Here you can learn more about us",
                              style: TextStyle(fontSize: 26, color: Colors.white,
                              ),),
                              const   SizedBox(height: 12,),
                             const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Follow Us: ",
                                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold,
                                  color: Colors.white, decoration: TextDecoration.underline),),
                                  SizedBox(width: 12,),
                                  Icon(Icons.facebook, color: Colors.white,),
                                  SizedBox(width: 4,),
                                  Icon(Icons.discord, color: Colors.white),
                                  SizedBox(width: 4,),
                                  Icon(Icons.email, color: Colors.white,),
                                  SizedBox(width: 4,),
                                  Icon(Icons.call, color: Colors.white,)
                                ],
                              ),
                              
                            ],),
                          ),
                        ),
                        ),
                        Container(
                          height: 70,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              ChipWidget(ChipLable: "Computers", avatar: Icon(Icons.computer)
                              ),
                              ChipWidget(ChipLable: "Cameras", avatar: Icon(Icons.camera)
                              ),
                              ChipWidget(ChipLable: "Printers", avatar: Icon(Icons.print_rounded)
                              ),
                              ChipWidget(ChipLable: "Headsets", avatar: Icon(Icons.headset)
                              ),
                              ChipWidget(ChipLable: "Mobile", avatar: Icon(Icons.mobile_screen_share)
                              ),
                            ],
                          ),
                        ),
                        const Gap(8),
                        const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text("Card List", style: TextStyle(
                          fontSize: 26, fontWeight: FontWeight.bold),),
                        Text("See More", style: TextStyle(
                          fontSize: 18, color: Colors.blue,
                          decoration: TextDecoration.underline,
                          ),
                          ),
                      ],),
                      const Gap(8),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: Cards.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(getIndex: index))),
                          child: SizedBox(
                            height: 300,
                            child: CardWidget(CardIndex: index),
                          ),
                        )
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}

