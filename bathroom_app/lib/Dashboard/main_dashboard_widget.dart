import 'package:flutter/material.dart';
import 'package:bathroom_app/views/search_utils.dart';
import 'recommendations_carrousel.dart';
import 'package:bathroom_app/Dashboard/filter_popup.dart';
import 'place_info.dart';

class MainDashboardWidget extends StatefulWidget {
  const MainDashboardWidget({super.key});

  @override
  State<MainDashboardWidget> createState() => _MainDashboardWidgetState();
}

class _MainDashboardWidgetState extends State<MainDashboardWidget> {
  final TextEditingController _searchController = TextEditingController();
  String searchText = '';
  List<String> comfortRooms = [
    'CR - Ground Floor',
    'CR - 2nd Floor',
    'CR - Near Cafeteria',
    'CR - Library Side',
    'CR - Admin Wing',
  ];

  bool _showAllRecents = false;

  static final List<Map<String, dynamic>> recentBathrooms = [
    {
      'name': 'Ayala - CBlock',
      'location': '2nd Floor, Ayala Central Bloc Cebu, Cebu City',
      'rating': 4.5
    },
    {
      'name': 'The walk',
      'location': 'Ayala Central Bloc Cebu, Cebu City',
      'rating': 4.0,
    },
    {
      'name': 'IT Park Terminal',
      'location': 'IT Park, Cebu City',
      'rating': 3.8,
    },
    {
      'name': 'iAcademy Comfort Room',
      'location': '5th Floor, Filinvest Tower 2, Cebu City',
      'rating': 4.2
    },
  ];

  void _onSearchChanged(String value) {
    setState(() {
      searchText = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final recentsToShow =
        _showAllRecents ? recentBathrooms : recentBathrooms.take(4).toList();
    final filteredResults = comfortRooms
        .where((item) => item.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

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

                // 🔍 Search Bar
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
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.vertical(top: Radius.circular(16)),
                              ),
                              builder: (context) => const FilterPopup(),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Icon(Icons.tune, color: Colors.orange),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 21),

                // 🔍 Search Results
                if (searchText.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      children: filteredResults.map((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                            child: ListTile(
                              leading: const Icon(Icons.location_on,
                                  color: Colors.orange),
                              title: Text(item,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle: const Text(
                                  'Block 11, Garden Row, Abad St, Cebu City, 6000 Cebu'),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => const PlaceInfoPage()),
                                );
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                if (searchText.isEmpty) ...[
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
                      children: [
                        const RecommendationCard(
                          title: "Stephen cr",
                          rating: 4.8,
                          reviews: 31,
                          photos: 18,
                          description:
                              "wow! so clean and so fresh! the albratoss provided was scrumptious!",
                          author: "anonymous",
                        ),
                        const RecommendationCard(
                          title: "mjart cr",
                          rating: 3.8,
                          reviews: 311,
                          photos: 26,
                          description:
                              "why is it raining so hard today, I cant go to the gym",
                          author: "anonymous",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Recents Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Recents",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        if (!_showAllRecents)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _showAllRecents = true;
                              });
                            },
                            child: const Text(
                              "See More",
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 16,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Recents List
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
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const PlaceInfoPage()),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
