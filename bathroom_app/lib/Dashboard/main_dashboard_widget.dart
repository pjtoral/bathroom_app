import 'package:flutter/material.dart';
import 'package:bathroom_app/views/search_utils.dart'; 

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

  List<String> searchResults = [];

  @override
  void initState() {
    super.initState();
    searchResults = comfortRooms;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchText = value;
      searchResults = filterSearchResults(value, comfortRooms); // 🔍 Uses function from search_utils.dart
    });
  }

  @override
  Widget build(BuildContext context) {
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
              ],
            ),
          ),
        );
      },
    );
  }
}
