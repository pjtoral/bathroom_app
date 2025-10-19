import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'reviews.dart';

class PlaceInfoPage extends StatefulWidget {
  const PlaceInfoPage({super.key});

  @override
  State<PlaceInfoPage> createState() => _PlaceInfoPageState();
}

class _PlaceInfoPageState extends State<PlaceInfoPage> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              // Main photo placeholder
              Container(
                height: 180,
                color: Colors.grey[300],
                child: Center(
                  child: Icon(Icons.image, size: 80, color: Colors.grey[600]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Ayala - CBlock",
                          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red[400],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Negative",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                        Spacer(),
                        // Directions icon in orange circle, now clickable
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Feature coming soon')),
                            );
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 26, 130, 195), //chech itttttttttttttttttttt
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.directions, color: Colors.white, size: 24),
                          ),
                        ),
                        SizedBox(width: 8),
                        // Favorite icon in red-orange circle, now clickable
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isFavorited = !_isFavorited;
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _isFavorited ? Colors.red : Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _isFavorited ? Icons.favorite : Icons.favorite_border,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      "2nd Floor, Ayala Central Bloc Cebu, Cebu City",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        _chip("bidet"),
                        SizedBox(width: 4),
                        _chip("soap"),
                        SizedBox(width: 4),
                        _chip("water"),
                        SizedBox(width: 4),
                        _chip("tissue"),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Photos", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Feature coming soon')),
                            );
                          },
                          child: const Text(
                            "see all",
                            style: TextStyle(color: Color.fromARGB(255, 26, 130, 195), fontSize: 14),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 110,
                        enableInfiniteScroll: false,
                        viewportFraction: 0.45,
                      ),
                      items: List.generate(3, (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Icon(Icons.image, size: 40, color: Colors.grey[600]),
                        ),
                      )),
                    ),
                    SizedBox(height: 16),
                    // Make the Reviews section tappable
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => ReviewsScreen()),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Reviews", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              // Rating and text in a column, centered
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("4.93", style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold)),
                                  SizedBox(height: 2),
                                  Text("out of 5", style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                                  SizedBox(height: 2),
                                  // Make the (30 reviews) text also clickable
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (_) => ReviewsScreen()),
                                      );
                                    },
                                    child: Text(
                                      "(30 reviews)",
                                      style: TextStyle(fontSize: 18, color: Colors.grey[500], decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 16),
                              Spacer(),
                              SizedBox(
                                width: 220,
                                height: 70,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 8,
                                      child: LinearProgressIndicator(
                                        value: 0.8,
                                        color: Color.fromARGB(255, 26, 130, 195),
                                        backgroundColor: Colors.grey[300],
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    SizedBox(
                                      height: 8,
                                      child: LinearProgressIndicator(
                                        value: 0.5,
                                        color: Color.fromARGB(255, 26, 130, 195),
                                        backgroundColor: Colors.grey[300],
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    SizedBox(
                                      height: 8,
                                      child: LinearProgressIndicator(
                                        value: 0.2,
                                        color: Color.fromARGB(255, 26, 130, 195),
                                        backgroundColor: Colors.grey[300],
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    SizedBox(
                                      height: 8,
                                      child: LinearProgressIndicator(
                                        value: 0.2,
                                        color: Color.fromARGB(255, 26, 130, 195),
                                        backgroundColor: Colors.grey[300],
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    SizedBox(
                                      height: 8,
                                      child: LinearProgressIndicator(
                                        value: 0.2,
                                        color: Color.fromARGB(255, 26, 130, 195),
                                        backgroundColor: Colors.grey[300],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    // Make each review card in the carousel clickable
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 160,
                        enableInfiniteScroll: false,
                        viewportFraction: 0.95,
                      ),
                      items: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => ReviewsScreen()),
                            );
                          },
                          child: _reviewCard(
                            name: "Jen wildoson",
                            rating: 5,
                            time: "1 month ago",
                            review: "Love the food and atmosphere here, very cozy",
                            avatarUrl: "https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=facearea&w=80&h=80&facepad=2",
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => ReviewsScreen()),
                            );
                          },
                          child: _reviewCard(
                            name: "Peler Newman",
                            rating: 5,
                            time: "1 month ago",
                            review: "This is my favorite place to work, I really like the vibe and location!",
                            avatarUrl: "https://randomuser.me/api/portraits/men/32.jpg",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Back button (top left)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 26, 130, 195),  // check itttttttttttttttttttt
        borderRadius: BorderRadius.circular(30), // pill shape
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _reviewCard({
    required String name,
    required int rating,
    required String time,
    required String review,
    String? avatarUrl,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: avatarUrl != null
                      ? NetworkImage(avatarUrl)
                      : null,
                  child: avatarUrl == null
                      ? Icon(Icons.person, size: 28)
                      : null,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        children: [
                          ...List.generate(
                            rating,
                            (i) => Icon(Icons.star, color: Color.fromARGB(255, 26, 130, 195), size: 20),
                          ),
                          SizedBox(width: 8),
                          Text(
                            time,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              review,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
