import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  // ---------------- REUSABLE TILE WIDGET ----------------
  // Extracted this outside the build method for cleaner code structure
  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required Color textColor,
    required Color subtitleColor,
    VoidCallback? onTap,
    bool showArrow = false, // Added for clickable tiles
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0), // Increased padding for touch target
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(width: 16),

            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700, // Slightly bolder title
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: subtitleColor),
                    softWrap: true,
                  ),
                ],
              ),
            ),
            
            // Trailing Arrow for clickable items
            if (showArrow) 
              Icon(Icons.arrow_forward_ios, size: 16, color: subtitleColor.withOpacity(0.5)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const mainColor = Color(0xFF94A1DF);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : Colors.grey[50]; // Lighter background for less contrast
    final appBarBgColor = isDark ? Colors.grey[900] : Colors.white; // White/Dark AppBar
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.white70 : Colors.black54;
    final iconColor = mainColor; // Primary color for icons

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        // Improved: Use transparent/white AppBar for modern look
        backgroundColor: appBarBgColor, 
        elevation: 0.5, // Subtle shadow
        title: Text(
          "About Find It",
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center the main elements
          children: [
            // ---------------- APP ICON/LOGO ----------------
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: mainColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                Icons.search, // Placeholder for App Icon
                size: 64,
                color: mainColor,
              ),
            ),
            const SizedBox(height: 16),

            // ---------------- APP NAME & VERSION ----------------
            Text(
              "Find It",
              style: TextStyle(
                fontSize: 28, // Larger title
                fontWeight: FontWeight.w900,
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),

            Text(
              "Version 1.0.0",
              style: TextStyle(fontSize: 14, color: subtitleColor),
            ),
            const SizedBox(height: 32),

            // ---------------- APP DESCRIPTION ----------------
            Text(
              "A simple tool to help users post and find lost items within MUBS. We connect lost and found items quickly and efficiently.",
              textAlign: TextAlign.center, // Center text for better presentation
              style: TextStyle(
                fontSize: 16,
                color: subtitleColor,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 40),

            // ---------------- DEVELOPER INFO GROUP ----------------
            Divider(color: subtitleColor.withOpacity(0.15)), // Visual separation
            
            _buildInfoTile(
              icon: Icons.developer_mode, // Updated icon
              title: "Developed by",
              subtitle: "CeaserTA, VictoriaN, SiscoC, SamuelBA, SylviaN",
              iconColor: iconColor,
              textColor: textColor,
              subtitleColor: subtitleColor,
            ),

            Divider(color: subtitleColor.withOpacity(0.15)),
            
            _buildInfoTile(
              icon: Icons.support_agent_outlined, // Updated icon
              title: "Contact Support",
              subtitle: "support@findit.com",
              iconColor: iconColor,
              textColor: textColor,
              subtitleColor: subtitleColor,
              onTap: () {
                // TODO: Implement email launch
              },
              showArrow: true,
            ),

            Divider(color: subtitleColor.withOpacity(0.15)),
            
            _buildInfoTile(
              icon: Icons.privacy_tip_outlined,
              title: "Privacy Policy",
              subtitle: "Read how we protect your data",
              iconColor: iconColor,
              textColor: textColor,
              subtitleColor: subtitleColor,
              onTap: () {
                // TODO: Implement URL launch
              },
              showArrow: true,
            ),

            Divider(color: subtitleColor.withOpacity(0.15)),
            
            const SizedBox(height: 50),

            // ---------------- COPYRIGHT ----------------
            Text(
              "© 2025 Find It. All rights reserved.",
              style: TextStyle(fontSize: 12, color: subtitleColor.withOpacity(0.7)),
            ),
          ],
        ),
      ),
    );
  }
}