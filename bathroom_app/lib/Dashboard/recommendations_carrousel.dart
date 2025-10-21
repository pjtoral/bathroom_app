import 'package:flutter/material.dart';

class RecommendationCard extends StatelessWidget {
  final String title;
  final double rating;
  final int reviews;
  final int photos;
  final String description;
  final String author;

  const RecommendationCard({
    super.key,
    required this.title,
    required this.rating,
    required this.reviews,
    required this.photos,
    required this.description,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Placeholder for image
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: Color.fromARGB(255, 26, 130, 195), size: 18),
              Text(
                rating.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Text(
                "$reviews reviews | $photos photos",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 6),
          Text(description),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              "-$author",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget? toList() {}
}
