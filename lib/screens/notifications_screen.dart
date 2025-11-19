import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const mainColor = Color(0xFF94A1DF); // Your app's main color

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: mainColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image with white background
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10), // space around the image
              child: Image.asset(
                'assets/images/notification.jpg',
                height: 250,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 30),

            // Text
            const Text(
              "No notifications yet",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "We will update you here in case of any activity.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
