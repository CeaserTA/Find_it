import 'package:find_it/screens/home_screen.dart';
import 'package:find_it/screens/splash_screen.dart';
import 'package:flutter/material.dart';
void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Find-it",
      theme: ThemeData(primarySwatch: Colors.blue),

      initialRoute: '/',
      routes: {
        '/': (context) =>  SplashScreen(), 
        '/home': (context) =>  HomeFeedScreen(), 
        
      },
      //home: HomeFeedScreen(),

    );
  }
}


