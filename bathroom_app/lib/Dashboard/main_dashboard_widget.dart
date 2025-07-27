import 'package:flutter/material.dart';
import 'package:bathroom_app/views/search_utils.dart';
import 'package:bathroom_app/views/search_filter_bar.dart';
import 'recommendations_carrousel.dart';

class MainDashboardWidget extends StatefulWidget {
  const MainDashboardWidget({super.key});

  @override
  State<MainDashboardWidget> createState() => _MainDashboardWidgetState();
}

class _MainDashboardWidgetState extends State<MainDashboardWidget> {
  final TextEditingController _searchController = TextEditingController();
  String searchText = '';
  double? _selectedRating;
  List<Map<String, dynamic>> filteredBathrooms = [];

  bool _showAllRecents = false;

  static final List<Map<String, dynamic>> recentBathrooms = [
    {'name': 'Ayala Central BLoc', 'location': '2nd Floor', 'rating': 4.5},
    {'name': 'iAcademy Comfort Room', 'location': 'Filinvest 5th Floor', 'rating': 4.0},
    {'name': 'Sugbu Mercado Comfort Room', 'location': 'Sugbo Mercado It Park', 'rating': 3.8},
    {'name': 'SM City Cebu Restroom', 'location': '2rd Floor', 'rating': 4.2},
    {'name': 'SM City Consolacion Restroom', 'location': '2rd Floor, Food court', 'rating': 4.1},
    {'name': 'Ayala Center Cebu Restroom', 'location': 'Upper Ground Floor', 'rating': 3.9},
    {'name': 'Jollibee Filinvest', 'location': 'Filinvest Tower 2nd Floor', 'rating': 4.3},
    {'name': 'Sindos Comfort Room', 'location': 'Canduman, Mandaue City', 'rating': 4.0},
  ];

  @override
  void initState() {
    super.initState();
    filteredBathrooms = recentBathrooms;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchText = value;
      filteredBathrooms = filterSearchResults(
        query: value,
        data: recentBathrooms,
        minRating: _selectedRating,
      );
    });
  }

  void _onRatingFilterChanged(double? value) {
    setState(() {
      _selectedRating = value;
      filteredBathrooms = filterSearchResults(
        query: searchText,
        data: recentBathrooms,
        minRating: _selectedRating,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final recentsToShow = _showAllRecents ? recentBathrooms : recentBathrooms.take(4).toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.101,
      minChildSize: 0.101,
      maxChildSize: 0.9,
      snap: true,
      snapSizes: const [0.101, 0.55, 0.9],
      builder: (context, scrollController) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(66, 138, 138, 138),
                  blurRadius: 10,
                ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: SearchFilterBar(
                    controller: _searchController,
                    selectedRating: _selectedRating,
                    onSearchChanged: _onSearchChanged,
                    onRatingFilterChanged: _onRatingFilterChanged,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    children: filteredBathrooms.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.place, color: Colors.deepPurple, size: 28),
                            title: Text(
                              item['name'],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(item['location']),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 18),
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
                const SizedBox(height: 21),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Recommendations near you",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 19),
                SizedBox(
                  height: 340,
                  child: PageView(
                    controller: PageController(viewportFraction: 0.85),
                    children: const [
                      RecommendationCard(
                        title: "Stephen cr",
                        rating: 4.8,
                        reviews: 31,
                        photos: 18,
                        description: "wow! so clean and so fresh! the albratoss provided was scrumptious!",
                        author: "anonymous",
                      ),
                      RecommendationCard(
                        title: "mjart cr",
                        rating: 3.8,
                        reviews: 311,
                        photos: 26,
                        description: "why is it raining so hard today, I cant go to the gym",
                        author: "anonymous",
                      ),
                      RecommendationCard(
                        title: "rafile cr",
                        rating: 5.8,
                        reviews: 571,
                        photos: 8153,
                        description: "wowowowowowowoowowowowoowowowowowoowowowowowowooowwoowo",
                        author: "anonymous",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _showAllRecents
                          ? Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back, color: Colors.orange),
                                  onPressed: () {
                                    setState(() {
                                      _showAllRecents = false;
                                    });
                                  },
                                ),
                                const Text("Recents", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              ],
                            )
                          : const Text("Recents", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      !_showAllRecents
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showAllRecents = true;
                                });
                              },
                              child: const Text("See More", style: TextStyle(color: Colors.orange, fontSize: 16)),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ...recentsToShow.map(
                  (bathroom) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: const Icon(Icons.wc, color: Colors.orange),
                        title: Text(bathroom['name']),
                        subtitle: Text(bathroom['location']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                            const SizedBox(width: 4),
                            Text(bathroom['rating'].toString()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
