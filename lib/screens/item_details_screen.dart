import 'package:flutter/material.dart';
import 'in_app_chat_screen.dart';
class FoundItemDetailScreen extends StatelessWidget {
  final Map<String, String> item;

  const FoundItemDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF94A1DF)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Item Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),

      // 🧾 Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🖼️ Item Image with Hero Animation
            Hero(
              tag: item['image'] ?? '',
              child: Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(
                      item['image'] ?? 'assets/images/backpack.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🏷️ Title
            Text(
              item['title'] ?? 'Found Item',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // 📋 Info Card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    _buildInfoRow(
                      Icons.category,
                      'Category',
                      item['category'] ?? 'N/A',
                    ),
                    const Divider(),
                    _buildInfoRow(
                      Icons.location_on,
                      'Location',
                      item['location'] ?? 'N/A',
                    ),
                    const Divider(),
                    _buildInfoRow(
                      Icons.email,
                      'Poster',
                      item['poster'] ?? 'cza@gmail.com',
                    ),
                    const Divider(),
                    _buildInfoRow(
                      Icons.calendar_today,
                      'Posted Date',
                      'Nov 12, 2025',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            //  Claim Item Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Claim This Item?"),
                      content: const Text(
                        "This will start a private chat with the person who found it.",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => InAppChatScreen(
                                  itemTitle: item['title'] ?? 'Item',
                                  otherUserName: item['poster'] ?? 'Finder',
                                  autoFirstMessage:
                                      "Hi! I believe this is my lost ${item['title'] ?? 'item'}. Can we arrange pickup? 💜",
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Yes, It's Mine",
                            style: TextStyle(color: Color(0xFF94A1DF)),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.handshake_outlined, color: Colors.white),
                label: const Text(
                  'Claim Item',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF94A1DF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🧩 Helper widget for info rows
  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: const Color(0xFF94A1DF)),
            const SizedBox(width: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
