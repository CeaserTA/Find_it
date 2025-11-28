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
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Unified primary color
  static const Color primaryUnifiedColor = Color(0xFF42A5F5);

  final List<String> _categories = [
    'All',
    'Electronics',
    'Keys',
    'Wallets',
    'Bags',
  ];

  // Mock data
  final Map<String, List<Map<String, String>>> _mockData = {
    'Lost': [
      {
        'image': 'assets/images/wallet.jpg',
        'title': 'Black Leather Wallet',
        'location': 'ADB Lab1',
        'category': 'Wallets',
      },
      {
        'image': 'assets/images/phone.jpg',
        'title': 'iPhone 14 Pro',
        'location': 'Main Library Level2',
        'category': 'Electronics',
      },
      {
        'image': 'assets/images/keys.jpg',
        'title': 'Car and House Keys',
        'location': 'Block 12',
        'category': 'Keys',
      },
      {
        'image': 'assets/images/backpack.jpg',
        'title': 'Blue Backpack',
        'location': 'Demo Lab',
        'category': 'Bags',
      },
    ],
    'Found': [
      {
        'image': 'assets/images/wallet.jpg',
        'title': 'Leather Wallet Found',
        'location': 'ADB Lab3',
        'category': 'Wallets',
      },
      {
        'image': 'assets/images/phone.jpg',
        'title': 'iPhone 13 Found',
        'location': 'Main Library Level1',
        'category': 'Electronics',
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, String>> _getFilteredItems(String tab) {
    final items = _mockData[tab] ?? [];

    List<Map<String, String>> filteredItems = items;

    // Category filter
    if (_selectedCategoryIndex != 0) {
      filteredItems = items
          .where(
            (item) => item['category'] == _categories[_selectedCategoryIndex],
          )
          .toList();
    }

    // Search filter
    if (_searchQuery.isNotEmpty) {
      filteredItems = filteredItems.where((item) {
        final title = item['title']?.toLowerCase() ?? '';
        final location = item['location']?.toLowerCase() ?? '';
        final category = item['category']?.toLowerCase() ?? '';

        return title.contains(_searchQuery) ||
            location.contains(_searchQuery) ||
            category.contains(_searchQuery);
      }).toList();
    }

    return filteredItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Home Feed",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: primaryUnifiedColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: primaryUnifiedColor,
          tabs: const [
            Tab(text: "Lost"),
            Tab(text: "Found"),
          ],
        ),
      ),

      // ---------------- DRAWER ----------------
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text(
                "Nalubiri Victoria",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: const Text(
                "victoria@gmail.com",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/profile.jpg",
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _HomeFeedScreenState.primaryUnifiedColor,
                    _HomeFeedScreenState.primaryUnifiedColor,
                  ],
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
                Navigator.pop(context);
                Future.delayed(const Duration(milliseconds: 150), () {
                  Navigator.pushNamed(context, '/about');
                });
              },
            ),

            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text("Help & Feedback"),
              onTap: () {
                Navigator.pop(context);
                Future.delayed(const Duration(milliseconds: 150), () {
                  Navigator.pushNamed(context, '/help');
                });
              },
            ),

            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text("Settings"),
              onTap: () {
                Navigator.pop(context);
                Future.delayed(const Duration(milliseconds: 150), () {
                  Navigator.pushNamed(context, '/settings');
                });
              },
            ),

            const Divider(),
          ],
        ),
      ),

      // -------------- MAIN BODY --------------
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFeedTab("Lost"),
          _buildFeedTab("Found"),
        ],
      ),

      // FAB
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryUnifiedColor,
        onPressed: () {
          final currentTab = _tabController.index == 0 ? "Lost" : "Found";
          Navigator.pushNamed(context, '/post-item', arguments: currentTab);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),

      // Bottom Nav
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: primaryUnifiedColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() => _currentIndex = index);

          if (index == 1) {
            Navigator.pushNamed(context, '/notifications');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/profile');
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined),
              label: "Notifications"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }

  // ---------------- FEED TAB UI ----------------
  Widget _buildFeedTab(String tabName) {
    final filteredItems = _getFilteredItems(tabName);

    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: "Search items...",
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => _searchController.clear(),
                    )
                  : null,
            ),
          ),
        ),

        // Category chips
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
                  onSelected: (_) =>
                      setState(() => _selectedCategoryIndex = index),
                  selectedColor: primaryUnifiedColor,
                  backgroundColor: Colors.grey[200],
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              );
            },
          ),
        ),

        // Items list
        Expanded(
          child: filteredItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _searchQuery.isNotEmpty
                            ? Icons.search_off
                            : Icons.inbox_outlined,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _searchQuery.isNotEmpty
                            ? "No items found for '$_searchQuery'"
                            : "No items available",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          if (tabName == "Found") {
                            Navigator.pushNamed(
                              context,
                              '/item-detail',
                              arguments: item,
                            );
                          } else if (tabName == "Lost") {
                            Navigator.pushNamed(
                              context,
                              '/lost-item-detail',
                              arguments: item,
                            );
                          }
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image
                              Hero(
                                tag: 'item_${item['title']}',
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      item['image']!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Content
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Title
                                    Text(
                                      item['title']!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),
                                    // Location
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 16,
                                          color: Colors.grey[600],
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            item['location']!,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey[600],
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    // Category and Time
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: primaryUnifiedColor.withOpacity(0.15),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            item['category']!,
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: primaryUnifiedColor,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Icon(
                                          Icons.access_time,
                                          size: 14,
                                          color: Colors.grey[500],
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '2h ago',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
