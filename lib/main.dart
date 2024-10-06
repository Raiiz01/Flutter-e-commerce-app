import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:myapp/firebase_options.dart';
import 'views/login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform
);
  runApp(ProviderScope(
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthScreen(),
    ),
  ));
}