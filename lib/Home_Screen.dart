import 'package:flutter/material.dart';
import 'Api/ApiManger.dart';  // Import the ApiManager
import 'jsonFiles/Response/GetAllCatResponse.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
  static String homeScreenRoute = "/Home";
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // This is for the BottomNavigationBar
  int _currentBannerIndex = 0; // This is for the PageView
  final PageController _pageController = PageController();  // Initialize the PageController

  List<Data> _categories = [];  // Store categories data
  bool _isLoadingCategories = true;  // Loading state

  final List<Map<String, String>> banners = [
    {
      'image': 'lib/Images/HomeScreen/headphones.png',
      'title': 'UP TO',
      'discount': '25% OFF',
      'description': 'For all Headphones & AirPods',
    },
    {
      'image': 'lib/Images/HomeScreen/makeup.png',
      'title': 'UP TO',
      'discount': '30% OFF',
      'description': 'For all Makeup & Skincare',
    },
    {
      'image': 'lib/Images/HomeScreen/laptop.png',
      'title': 'UP TO',
      'discount': '20% OFF',
      'description': 'For Laptops & Mobiles',
    },
  ];

  @override
  void initState() {
    super.initState();
    _fetchCategories(); // Fetch categories when the screen loads
  }

  @override
  void dispose() {
    _pageController.dispose();  // Dispose of the PageController
    super.dispose();
  }

  Future<void> _fetchCategories() async {
    final response = await ApiManager.getAllCategories();
    if (response != null && response.data != null) {
      setState(() {
        _categories = response.data!;
        _isLoadingCategories = false;
      });
    } else {
      setState(() {
        _isLoadingCategories = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Text(
              'Route',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003366),
              ),
            ),
            Spacer(),
            Icon(Icons.shopping_cart, color: Color(0xFF003366)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            _buildSearchBar(),
            SizedBox(height: 20),
            _buildBanner(), // This controls the banner
            SizedBox(height: 20),
            _buildCategorySection(),  // Updated Category Section
            SizedBox(height: 20),
            _buildHomeApplianceSection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(), // This controls the BottomNavigationBar
    );
  }

  // Search bar widget
  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'What do you search for?',
          icon: Icon(Icons.search, color: Color(0xFF003366)),
        ),
      ),
    );
  }

  // Promotional banner PageView widget
  Widget _buildBanner() {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: constraints.maxWidth * 0.6,  // Set height based on screen width
              child: PageView.builder(
                controller: _pageController,  // Assign the controller here
                itemCount: banners.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentBannerIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildBannerItem(banners[index]);
                },
              ),
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: banners.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _pageController.animateToPage(  // Change page on dot tap
                entry.key,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentBannerIndex == entry.key
                      ? Color(0xFF003366)
                      : Colors.grey.withOpacity(0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Individual banner item widget
  Widget _buildBannerItem(Map<String, String> banner) {
    bool isMiddleBanner = banner['image']!.contains('makeup.png');

    return AspectRatio(
      aspectRatio: 16 / 9,  // Maintain consistent aspect ratio
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(banner['image']!),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: isMiddleBanner ? null : 20,
              right: isMiddleBanner ? 20 : null, // Align right for the middle banner
              bottom: 30,  // Position closer to the bottom
              child: Column(
                crossAxisAlignment: isMiddleBanner
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    banner['title']!,
                    style: TextStyle(
                      color: isMiddleBanner ? Colors.white : Color.fromRGBO(0, 65, 130, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    banner['discount']!,
                    style: TextStyle(
                      color: isMiddleBanner ? Colors.white : Color.fromRGBO(0, 65, 130, 1),
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    banner['description']!,
                    style: TextStyle(
                      color: isMiddleBanner ? Colors.white : Color.fromRGBO(0, 65, 130, 1),
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      backgroundColor: Color(0xFF003366),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Shop Now',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Updated category section widget with proper circular layout
  Widget _buildCategorySection() {
    if (_isLoadingCategories) {
      return Center(child: CircularProgressIndicator());
    }

    if (_categories.isEmpty) {
      return Center(child: Text("No categories available"));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Categories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003366),
              ),
            ),
            Text(
              'View all',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF003366),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        GridView.builder(
          shrinkWrap: true,  // Ensure it doesn't scroll inside the parent scroll view
          physics: NeverScrollableScrollPhysics(),  // Disable scrolling inside the grid
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,  // Four items per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,  // Adjust the ratio to fit text
          ),
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            return _buildCategoryItem(_categories[index]);
          },
        ),
      ],
    );
  }

  // Individual category item widget
  Widget _buildCategoryItem(Data category) {
    return Column(
      children: [
        ClipOval(
          child: Image.network(
            category.image ?? 'https://via.placeholder.com/150',  // Fallback for null image
            height: 70,
            width: 70,
            fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              // Display a fallback image if the image fails to load
              return Image.asset(
                'lib/Images/fallback_image.png',  // Add a local fallback image to your assets
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        SizedBox(height: 8),
        Text(
          category.name ?? 'Unknown',
          style: TextStyle(fontSize: 14, color: Colors.black),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ],
    );
  }

  // Home appliance section widget
  Widget _buildHomeApplianceSection() {
    return Container(); // Replace with your home appliance implementation
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 65, 130, 1),  // rgba(0, 65, 130, 1)
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: _buildBottomNavigationItem(Icons.home, 0),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _buildBottomNavigationItem(Icons.grid_view, 1),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: _buildBottomNavigationItem(Icons.favorite, 2),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: _buildBottomNavigationItem(Icons.person, 3),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationItem(IconData icon, int index) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_currentIndex == index)  // If the item is selected, show the background circle
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          Icon(
            icon,
            color: _currentIndex == index ? Color.fromRGBO(0, 65, 130, 1) : Colors.white70,
          ),
        ],
      ),
    );
  }
}
