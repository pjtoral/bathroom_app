import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:bathroom_app/views/search_utils.dart'; 

=======
import 'recommendations_carrousel.dart';

// Change to StatefulWidget
>>>>>>> 29b26b8dcd3f98bf0bf2eb9c96b5f618d386d84e
class MainDashboardWidget extends StatefulWidget {
  const MainDashboardWidget({super.key});

  @override
  State<MainDashboardWidget> createState() => _MainDashboardWidgetState();
}

class _MainDashboardWidgetState extends State<MainDashboardWidget> {
<<<<<<< HEAD
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  String searchText = '';
<<<<<<< Updated upstream
  List<String> comfortRooms = [
    'CR - Ground Floor',
    'CR - 2nd Floor',
    'CR - Near Cafeteria',
    'CR - Library Side',
    'CR - Admin Wing',
=======
  double? _selectedRating;
  List<String> _selectedTags = [];
  List<Map<String, dynamic>> filteredBathrooms = [];
  bool _showAllRecents = false;
  bool _isSearchFocused = false;

  static final List<Map<String, dynamic>> recentBathrooms = [
    {
      'name': 'Ayala Central BLoc',
      'location': '2nd Floor',
      'rating': 4.5,
      'tags': ['Clean', 'Soap']
    },
    {
      'name': 'iAcademy Comfort Room',
      'location': 'Filinvest 5th Floor',
      'rating': 4.0,
      'tags': ['Soap', 'Accessible']
    },
    {
      'name': 'Sugbu Mercado Comfort Room',
      'location': 'Sugbo Mercado It Park',
      'rating': 3.8,
      'tags': ['Bad', 'Toilet Paper']
    },
    {
      'name': 'SM City Cebu Restroom',
      'location': '2rd Floor',
      'rating': 4.2,
      'tags': ['Mirror', 'Sink']
    },
    // ...add tags for each entry as needed
>>>>>>> Stashed changes
  ];

  List<String> searchResults = [];

  @override
  void initState() {
    super.initState();
<<<<<<< Updated upstream
    searchResults = comfortRooms;
=======
    filteredBathrooms = recentBathrooms;
    _searchFocusNode.addListener(() {
      setState(() => _isSearchFocused = _searchFocusNode.hasFocus);
    });
>>>>>>> Stashed changes
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchText = value;
<<<<<<< Updated upstream
      searchResults = filterSearchResults(value, comfortRooms); // 🔍 Uses function from search_utils.dart
=======
      _applyAllFilters();
>>>>>>> Stashed changes
    });
  }
=======
  bool _showAllRecents = false;

<<<<<<< Updated upstream
  // Static list of recent bathrooms
  static final List<Map<String, dynamic>> recentBathrooms = [
    {
      'name': 'Ayala Central BLoc',
      'location': '2nd Floor',
      'rating': 4.5,
    },
    {
      'name': 'iAcademy Comfort Room',
      'location': 'Filinvest 5th Floor',
      'rating': 4.0,
    },
    {
      'name': 'Sugbu Mercado Comfort Room',
      'location': 'Sugbo Mercado It Park',
      'rating': 3.8,
    },
    {
      'name': 'SM City Cebu Restroom',
      'location': '2rd Floor',
      'rating': 4.2,
    },
    {
      'name': 'SM City Consolacion Restroom',
      'location': '2rd Floor, Food court',
      'rating': 4.1,
    },
    {
      'name': 'Ayala Center Cebu Restroom',
      'location': 'Upper Ground Floor',
      'rating': 3.9,
    },
    {
      'name': 'Jollibee Filinvest',
      'location': 'Filinvest Tower 2nd Floor',
      'rating': 4.3,
    },
    {
      'name': 'Sindos Comfort Room',
      'location': 'Canduman, Mandaue City',
      'rating': 4.0,
    },
  ];
>>>>>>> 29b26b8dcd3f98bf0bf2eb9c96b5f618d386d84e
=======
  void _onRatingFilterChanged(double? value) {
    setState(() {
      _selectedRating = value;
      _applyAllFilters();
    });
  }
>>>>>>> Stashed changes

  void _onTagsChanged(List<String> tags) {
    setState(() {
      _selectedTags = tags;
      _applyAllFilters();
    });
  }

  void _applyAllFilters() {
    filteredBathrooms = filterSearchResults(
      query: searchText,
      data: recentBathrooms,
      minRating: _selectedRating,
      tags: _selectedTags,
    );
  }

  @override
  Widget build(BuildContext context) {
    final recentsToShow = _showAllRecents
        ? recentBathrooms
        : recentBathrooms.take(4).toList();
    final showSearchResults =
        _isSearchFocused && searchText.trim().isNotEmpty;

    return DraggableScrollableSheet(
      initialChildSize: 0.101,
      minChildSize: 0.101,
      maxChildSize: 0.9,
      snap: true,
      snapSizes: const [0.101, 0.55, 0.9],
      builder: (context, scrollController) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(66, 138, 138, 138),
                    blurRadius: 10),
              ],
            ),
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 12),
                Center(
                  child: Container(
                    width: 52,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

<<<<<<< Updated upstream
                // ✅ Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.orange, width: 1),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Icon(Icons.search, color: Colors.orange),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: _onSearchChanged,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Find nearest comfort room',
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 138, 138, 138),
                              ),
                              isDense: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Icon(Icons.tune, color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 21),
<<<<<<< HEAD

                // 🔍 Display Results
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: searchResults.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(item, style: const TextStyle(fontSize: 16)),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 21),
=======
                // Recommendations header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Recommendations near you",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 19),
                SizedBox(
                  height: 340, // Adjust height as needed
                  child: PageView(
                    controller: PageController(viewportFraction: 0.85),
                    children: [
                      RecommendationCard(
                        title: "Stephen cr",
                        rating: 4.8,
                        reviews: 31,
                        photos: 18,
                        description:
                            "wow! so clean and so fresh! the albratoss provided was scrumptious!",
                        author: "anonymous",
                      ),
                      RecommendationCard(
                        title: "mjart cr",
                        rating: 3.8,
                        reviews: 311,
                        photos: 26,
                        description:
                            "why is it raining so hard today, I cant go to the gym",
                        author: "anonymous",
                      ),
                      RecommendationCard(
                        title: "rafile cr",
                        rating: 100.8,
                        reviews: 571,
                        photos: 8153,
                        description:
                            "wowowowowowowoowowowowoowowowowowoowowowowowowooowwoowo",
                        author: "anonymous",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Recents header with See More or Back
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _showAllRecents
                          ? Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.arrow_back, color: Colors.orange),
                                  onPressed: () {
                                    setState(() {
                                      _showAllRecents = false;
                                    });
                                  },
                                ),
                                const Text(
                                  "Recents",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            )
                          : const Text(
                              "Recents",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                      !_showAllRecents
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showAllRecents = true;
                                });
                              },
                              child: const Text(
                                "See More",
                                style: TextStyle(color: Colors.orange, fontSize: 16),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Recents list
                ...recentsToShow.map(
                  (bathroom) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 6.0),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.wc, color: Colors.orange),
                        title: Text(bathroom['name']),
                        subtitle: Text(bathroom['location']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            SizedBox(width: 4),
                            Text(bathroom['rating'].toString()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // ...existing code...
>>>>>>> 29b26b8dcd3f98bf0bf2eb9c96b5f618d386d84e
=======
                // Search + Filter Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: SearchFilterBar(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    selectedRating: _selectedRating,
                    selectedTags: _selectedTags,
                    onSearchChanged: _onSearchChanged,
                    onRatingFilterChanged: _onRatingFilterChanged,
                    onTagsChanged: _onTagsChanged,
                  ),
                ),

                const SizedBox(height: 16),

                // 🔍 Search Results
                if (showSearchResults)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      children: filteredBathrooms.map((item) {
                        return Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: 6.0),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              leading: const Icon(Icons.place,
                                  color: Colors.orange, size: 28),
                              title: Text(item['name'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(item['location']),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.star,
                                      color: Colors.amber, size: 18),
                                  const SizedBox(width: 4),
                                  Text(item['rating'].toString()),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                // 🏠 Recommendations + Recents
                if (!showSearchResults) ...[
                  const SizedBox(height: 21),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text("Recommendations near you",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                  const SizedBox(height: 19),
                  SizedBox(
                    height: 340,
                    child: PageView(
                      controller:
                          PageController(viewportFraction: 0.85),
                      children: const [
                        RecommendationCard(
                          title: "Stephen cr",
                          rating: 4.8,
                          reviews: 31,
                          photos: 18,
                          description:
                              "wow! so clean and so fresh! the albratoss provided was scrumptious!",
                          author: "anonymous",
                        ),
                        RecommendationCard(
                          title: "mjart cr",
                          rating: 3.8,
                          reviews: 311,
                          photos: 26,
                          description:
                              "why is it raining so hard today, I cant go to the gym",
                          author: "anonymous",
                        ),
                        RecommendationCard(
                          title: "rafile cr",
                          rating: 5.8,
                          reviews: 571,
                          photos: 8153,
                          description:
                              "wowowowowowowoowowowowoowowowowowoowowowowowowooowwoowo",
                          author: "anonymous",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        _showAllRecents
                            ? Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.arrow_back,
                                        color: Colors.orange),
                                    onPressed: () => setState(
                                        () => _showAllRecents = false),
                                  ),
                                  const Text("Recents",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ],
                              )
                            : const Text("Recents",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                        !_showAllRecents
                            ? GestureDetector(
                                onTap: () => setState(() =>
                                    _showAllRecents = true),
                                child: const Text("See More",
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 16)),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...recentsToShow.map((bathroom) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 6.0),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading:
                                const Icon(Icons.wc, color: Colors.orange),
                            title: Text(bathroom['name']),
                            subtitle: Text(bathroom['location']),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.amber, size: 20),
                                const SizedBox(width: 4),
                                Text(bathroom['rating'].toString()),
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
>>>>>>> Stashed changes
              ],
            ),
          ),
        );
      },
    );
  }
}
