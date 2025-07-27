import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PlaceInfoPage extends StatelessWidget {
  const PlaceInfoPage({super.key});

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
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
                        // Directions icon in orange circle
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.orange[700],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.directions, color: Colors.white, size: 24),
                        ),
                        SizedBox(width: 8),
                        // Favorite icon in red-orange circle
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.favorite_border, color: Colors.white, size: 24),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      "2nd Floor, Ayala Central Bloc Cebu, Cebu City",
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
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
                            style: TextStyle(color: Colors.orange, fontSize: 14),
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
                    Text("Reviews", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text("4.93", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("out of 5", style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                            Text("(30 reviews)", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                          ],
                        ),
                        Spacer(),
                        SizedBox(
                          width: 100,
                          height: 40,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LinearProgressIndicator(value: 0.8, color: Colors.orange, backgroundColor: Colors.grey[300]),
                              SizedBox(height: 4),
                              LinearProgressIndicator(value: 0.5, color: Colors.orange, backgroundColor: Colors.grey[300]),
                              SizedBox(height: 4),
                              LinearProgressIndicator(value: 0.2, color: Colors.orange, backgroundColor: Colors.grey[300]),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 90,
                        enableInfiniteScroll: false,
                        viewportFraction: 0.95,
                      ),
                      items: [
                        _reviewCard(
                          name: "Jen wildoson",
                          rating: 5,
                          time: "1 month ago",
                          review: "Love the food and atmosphere here, very cozy",
                        ),
                        _reviewCard(
                          name: "Peler Newman",
                          rating: 5,
                          time: "1 month ago",
                          review: "This is my favorite place to work, I really like the vibe and location!",
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
        color: Colors.orange[700],
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

  Widget _reviewCard({required String name, required int rating, required String time, required String review}) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(child: Icon(Icons.person)),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Row(
                        children: List.generate(rating, (i) => Icon(Icons.star, color: Colors.orange, size: 14)),
                      ),
                      SizedBox(width: 8),
                      Text(time, style: TextStyle(fontSize: 10, color: Colors.grey[500])),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(review, style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
