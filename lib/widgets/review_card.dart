import 'package:flutter/material.dart';

/// Presentational widget that displays a single review (avatar, name, stars, time and review text).
///
/// Keep this widget presentation-only; callers pass already-loaded data.
/// Prefer accepting a typed model (e.g., Review) in the future for better typing.
/// Offer `compact` mode for use in carousels or tight UIs.
class ReviewCard extends StatelessWidget {
  /// Reviewer's display name.
  final String name;

  /// Integer rating (e.g., 1..5).
  final int rating;

  /// Human-readable time (e.g., '1 month ago').
  final String time;

  /// Review text content.
  final String review;

  /// Optional avatar image URL.
  final String? avatarUrl;

  /// When true, use a compact layout suitable for carousels.
  final bool compact;

  const ReviewCard({
    Key? key,
    required this.name,
    required this.rating,
    required this.time,
    required this.review,
    this.avatarUrl,
    this.compact = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatar = avatarUrl != null
        ? CircleAvatar(radius: compact ? 18 : 24, backgroundImage: NetworkImage(avatarUrl!))
        : CircleAvatar(radius: compact ? 18 : 24, backgroundColor: Colors.grey[300], child: Icon(Icons.person, size: compact ? 16 : 24));

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(compact ? 8 : 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                avatar,
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: compact ? 14 : 16)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          ...List.generate(
                            rating,
                            (i) => const Icon(Icons.star, color: Color.fromARGB(255, 26, 130, 195), size: 16),
                          ),
                          const SizedBox(width: 8),
                          Text(time, style: TextStyle(color: Colors.grey[600], fontSize: compact ? 11 : 12)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.more_vert, color: Colors.grey),
              ],
            ),
            if (!compact) const SizedBox(height: 8),
            if (!compact)
              Text(
                review,
                style: TextStyle(fontSize: 14, color: Colors.grey[800]),
              ),
            if (compact)
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  review,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
