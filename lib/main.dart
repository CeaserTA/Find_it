import 'package:find_it/screens/about_screen.dart';
import 'package:find_it/screens/home_screen.dart';
import 'package:find_it/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:find_it/screens/item_details_screen.dart';
import 'package:find_it/screens/lost_item_details_screen.dart';
import 'package:find_it/screens/post_item_screen.dart';
import 'package:find_it/screens/profile_screen.dart';
import 'package:find_it/screens/help_screen.dart';
import 'package:find_it/screens/settings.dart';
import 'package:find_it/screens/notifications_screen.dart';

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

        '/item-detail': (context) =>  FoundItemDetailScreen(item: ModalRoute.of(context)!.settings.arguments as Map<String, String>), 
        '/lost-item-detail': (context) =>  LostItemDetailScreen(item: ModalRoute.of(context)!.settings.arguments as Map<String, String>),
        '/profile': (context) =>  ProfileScreen(),

        '/post-item': (context) => PostItemScreen(
            tab: ModalRoute.of(context)!.settings.arguments as String?), 


        '/notifications': (context) => const NotificationScreen(),
        '/about': (context)  => const AboutScreen(),
        '/help': (context)  => const HelpScreen(),
        '/settings': (context)  => const SettingsScreen(),
      },
      //home: HomeFeedScreen(),

    );
  }
}


