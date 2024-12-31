import 'package:db_miner/screen/detail_screen.dart';
import 'package:db_miner/screen/fav_screen.dart';
import 'package:db_miner/screen/home_screen.dart';
import 'package:db_miner/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quote App',
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/', page: () => HomeScreen()),
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(name: '/details', page: () => DetailScreen()),
        GetPage(name: '/favorites', page: () => FavoritesScreen()),
      ],
    );
  }
}
