import 'package:flutter/material.dart';
import 'recommendations_carrousel.dart';

// Change to StatefulWidget
class MainDashboardWidget extends StatefulWidget {
  const MainDashboardWidget({super.key});

  @override
  State<MainDashboardWidget> createState() => _MainDashboardWidgetState();
}

class _MainDashboardWidgetState extends State<MainDashboardWidget> {
  bool _showAllRecents = false;

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
                // Simpler drag handle
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
                // Search bar
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
                        const Expanded(
                          child: TextField(
                            enabled: false,
                            decoration: InputDecoration(
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
                          child: Icon(Icons.tune, color: Colors.orange[400]),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 21),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
