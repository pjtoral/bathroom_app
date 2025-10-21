import 'package:bathroom_app/widgets/review_card.dart';
import 'package:bathroom_app/widgets/rating_bar_summary.dart';
import 'package:flutter/material.dart';

/// Screen showing a list of reviews and a rating distribution summary.
///
/// Use [ReviewCard] for each review item and [RatingBarSummary] for the
/// distribution bars.
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
                    backgroundColor: Color.fromARGB(255, 26, 130, 195),
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
                    children: const [
                      RatingBarSummary(value: 0.93, width: 200, height: 14),
                      SizedBox(height: 8),
                      RatingBarSummary(value: 0.45, width: 200, height: 14),
                      SizedBox(height: 8),
                      RatingBarSummary(value: 0.2, width: 200, height: 14),
                      SizedBox(height: 8),
                      RatingBarSummary(value: 0.12, width: 200, height: 14),
                      SizedBox(height: 8),
                      RatingBarSummary(value: 0.08, width: 200, height: 14),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 32),
            // Reviews list
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: reviews.length,
                separatorBuilder: (_, __) => Divider(height: 24, thickness: 1, color: Colors.grey[200]),
                itemBuilder: (context, index) {
                  final r = reviews[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: ReviewCard(
                      name: r['name'] as String,
                      rating: r['rating'] as int,
                      time: r['time'] as String,
                      review: r['review'] as String,
                      avatarUrl: r['avatarUrl'] as String?,
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
}
