import 'package:flutter/material.dart';
import 'home_screen.dart'; 


// to add a smooth fade in animation when navigating to HomeScreen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 2 seconds then navigate to the Home screen
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamed(
        context, '/home',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color mainColor = Color(0xFF94A1DF);

    return Scaffold(
      backgroundColor: mainColor,
      body: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Find-it",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.search,
              color: Colors.white,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
