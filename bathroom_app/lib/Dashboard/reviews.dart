import 'package:flutter/material.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reviews = [
      {
        "name": "Jen wildoson",
        "rating": 5,
        "time": "1 month ago",
        "review": "Love the food and atmosphere here, very cozy",
        "avatarUrl": "https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=facearea&w=80&h=80&facepad=2",
      },
      {
        "name": "Peler Newman",
        "rating": 5,
        "time": "1 month ago",
        "review": "This is my favorite place to work, I really like the vibe and location!",
        "avatarUrl": "https://randomuser.me/api/portraits/men/32.jpg",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFFFFB13C),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Reviews',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 40),
                ],
              ),
            ),
            // Rating summary
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Average rating
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '4.93',
                        style: TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 0),
                      Text(
                        'out of 5',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '(30 reviews)',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 32), // Increase spacing to match image
                  // Rating bars (right-aligned, vertically centered with rating)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ratingBar(0.93),
                      SizedBox(height: 8),
                      _ratingBar(0.45),
                      SizedBox(height: 8),
                      _ratingBar(0.2),
                      SizedBox(height: 8),
                      _ratingBar(0.2),
                      SizedBox(height: 8),
                      _ratingBar(0.2),
                    ],
                  ),
                ],
              ),
            ),
            Divider(height: 32),
            // Reviews list
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: reviews.length,
                separatorBuilder: (_, __) => Divider(height: 24, thickness: 1, color: Colors.grey[200]),
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                    child: _reviewCard(
                      name: review['name'] as String,
                      rating: review['rating'] as int,
                      time: review['time'] as String,
                      review: review['review'] as String,
                      avatarUrl: review['avatarUrl'] as String?,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ratingBar(double value) {
    return Container(
      width: 200, // Wider bar to match the image
      height: 16,
      alignment: Alignment.centerLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: LinearProgressIndicator(
          value: value,
          minHeight: 14,
          color: Color(0xFFFFB13C),
          backgroundColor: Colors.grey[200],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFFFFB13C),
              backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
              child: avatarUrl == null ? Icon(Icons.person, color: Colors.white, size: 24) : null,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      ...List.generate(
                        rating,
                        (i) => Icon(Icons.star, color: Color(0xFFFFB13C), size: 16),
                      ),
                      SizedBox(width: 4),
                      Text(
                        time,
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.more_vert, color: Colors.grey[700]),
          ],
        ),
        SizedBox(height: 8),
        Text(
          review,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
