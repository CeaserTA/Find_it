import 'package:flutter/material.dart';

class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({super.key});

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedCategoryIndex = 0;
  bool _isDarkMode = false;
  int _currentIndex = 0; // Track the selected bottom navigation item

  final List<String> _categories = ['All', 'Electronics', 'Keys', 'Wallets', 'Bags'];

  // Mock Data
  final Map<String, List<Map<String, String>>> _mockData = {
    'Lost': [
      {'image': 'assets/images/wallet.jpg', 'title': 'Black Leather Wallet', 'location': 'ADB  Lab1', 'category': 'Wallets'},
      {'image': 'assets/images/phone.jpg', 'title': 'iPhone 14 Pro', 'location': 'Main Library Level2', 'category': 'Electronics'},
      {'image': 'assets/images/keys.jpg', 'title': 'Car and House Keys', 'location': 'Block 12', 'category': 'Keys'},
      {'image': 'assets/images/backpack.jpg', 'title': 'Blue Backpack', 'location': 'Demo Lab', 'category': 'Bags'},
    ],
    'Found': [
      {'image': 'assets/images/wallet.jpg', 'title': 'Leather Wallet Found', 'location': 'ADB Lab3', 'category': 'Wallets'},
      {'image': 'assets/images/phone.jpg', 'title': 'iPhone 13 Found', 'location': 'Main Library Level1 ', 'category': 'Electronics'},
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  List<Map<String, String>> _getFilteredItems(String tab) {
    final items = _mockData[tab] ?? [];
    if (_selectedCategoryIndex == 0) return items; // "All"
    return items
        .where((item) => item['category'] == _categories[_selectedCategoryIndex])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        backgroundColor: _isDarkMode ? Colors.black : Colors.white,
        appBar: AppBar(
          backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.white,
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Home Feed",
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            labelColor: const Color(0xFF94A1DF),
            unselectedLabelColor: Colors.grey,
            indicatorColor: const Color(0xFF94A1DF),
            tabs: const [
              Tab(text: "Lost"),
              Tab(text: "Found"),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text("Nalubiri Victoria"),
                accountEmail: const Text("victoria@gmail.com"),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/profile.jpg"),
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF94A1DF), Color(0xFF94A1DF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text("Home"),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text("About"),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("About page coming soon...")),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.help_outline),
                title: const Text("Help & Feedback"),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Help & Feedback page coming soon...")),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings_outlined),
                title: const Text("Settings"),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Settings coming soon...")),
                  );
                },
              ),
              const Divider(),
              SwitchListTile(
                secondary: const Icon(Icons.dark_mode_outlined),
                title: const Text("Dark Mode"),
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildFeedTab("Lost"),
            _buildFeedTab("Found"),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF94A1DF),
          onPressed: () {
            final currentTab = _tabController.index == 0 ? "Lost" : "Found";
            Navigator.pushNamed(context, '/post-item', arguments: currentTab);
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex, // Track the selected index
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            if (index == 2) { // Index 2 is the Profile item
              Navigator.pushNamed(context, '/profile');
            }
            else if (index == 1) { // Index 1 is the Notifications item
              Navigator.pushNamed(context, '/notifications');
            }
          },
          selectedItemColor: const Color(0xFF94A1DF),
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.notifications_outlined), label: "Notifications"),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
          ],
        ),
      ),
    );
  }

  // 🧩 Feed Tab Builder
  Widget _buildFeedTab(String tabName) {
    final filteredItems = _getFilteredItems(tabName);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: "Search items...",
              filled: true,
              fillColor: _isDarkMode ? Colors.grey[850] : Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Container(
          height: 45,
          margin: const EdgeInsets.only(bottom: 8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final isSelected = _selectedCategoryIndex == index;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ChoiceChip(
                  label: Text(_categories[index]),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      _selectedCategoryIndex = index;
                    });
                  },
                  selectedColor: const Color(0xFF94A1DF),
                  backgroundColor: _isDarkMode ? Colors.grey[800] : Colors.grey[200],
                  labelStyle: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : _isDarkMode
                            ? Colors.white70
                            : Colors.black,
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: filteredItems.isEmpty
              ? const Center(child: Text("No items available"))
              : ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return Card(
                      color: _isDarkMode ? Colors.grey[900] : Colors.white,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            item['image']!,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          item['title']!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['location']!),
                            const SizedBox(height: 4),
                            Chip(
                              label: Text(item['category']!),
                              backgroundColor: const Color(0xFF94A1DF).withOpacity(0.2),
                              labelStyle: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Posted 2 hours ago',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                        onTap: () {
                          if (tabName == "Found") {
                            Navigator.pushNamed(context, '/item-detail', arguments: item);
                          } else if (tabName == "Lost") {
                            Navigator.pushNamed(context, '/lost-item-detail', arguments: item);
                          }
                        },
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}