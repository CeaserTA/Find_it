import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black87,
        ),
        elevation: 0,
      ),

      body: ListView(
        children: [
          // SECTION — Privacy
          const SizedBox(height: 16),
          _sectionTitle("Privacy", isDarkMode),

          _navTile(
            title: "Permissions",
            icon: Icons.security_outlined,
            isDarkMode: isDarkMode,
            onTap: () {},
          ),

          // SECTION — Preferences
          const SizedBox(height: 16),
          _sectionTitle("Preferences", isDarkMode),

          _navTile(
            title: "Language",
            icon: Icons.language_outlined,
            isDarkMode: isDarkMode,
            onTap: () {},
          ),

          // SECTION — Storage
          const SizedBox(height: 16),
          _sectionTitle("Storage", isDarkMode),

          _navTile(
            title: "Clear App Cache",
            icon: Icons.storage_outlined,
            isDarkMode: isDarkMode,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Cache cleared.")),
              );
            },
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // SECTION HEADER
  Widget _sectionTitle(String title, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
        ),
      ),
    );
  }

  // NAVIGATION TILE
  Widget _navTile({
    required String title,
    required IconData icon,
    required bool isDarkMode,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: isDarkMode ? Colors.white70 : Colors.black54),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          color: isDarkMode ? Colors.white : Colors.black87,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: isDarkMode ? Colors.white54 : Colors.black38,
      ),
      onTap: onTap,
    );
  }
}
