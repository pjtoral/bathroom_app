import 'package:flutter/material.dart';

/// Reusable star row for showing or setting integer ratings.
///
/// Implement as a controlled component: parent passes `rating` and receives changes through `onChanged`.
/// Provide `maxStars` and sizing so the widget adapts to different UIs.
class StarRating extends StatelessWidget {
  /// Current integer rating (e.g., 0..maxStars).
  final int rating;

  /// Maximum number of stars to display.
  final int maxStars;

  /// Icon size in logical pixels.
  final double size;

  /// Color used for active/filled stars.
  final Color activeColor;

  /// Called when the user taps a star; provides the new rating value.
  final ValueChanged<int>? onChanged;

  const StarRating({
    Key? key,
    required this.rating,
    this.maxStars = 5,
    this.size = 28,
    this.activeColor = const Color.fromARGB(255, 26, 130, 195),
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxStars, (index) {
        final filled = index < rating;
        return GestureDetector(
          onTap: onChanged != null ? () => onChanged!(index + 1) : null,
          child: Icon(
            Icons.star,
            color: filled ? activeColor : Colors.grey,
            size: size,
          ),
        );
      }),
    );
  }
}
