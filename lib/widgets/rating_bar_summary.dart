import 'package:flutter/material.dart';

/// A small linear bar used to visualize a fraction. The parent supplies the value and sizing parameters.
///
/// Keep this widget purely presentational; parent must provide the numeric value (0..1).
/// Prefer passing explicit width/height so callers control layout in different contexts.
class RatingBarSummary extends StatelessWidget {
  /// Fractional value between 0 and 1 representing the filled portion.
  final double value;

  /// Width of the bar in logical pixels.
  final double width;

  /// Height of the bar in logical pixels.
  final double height;

  /// Color used for the filled portion of the bar.
  final Color color;

  const RatingBarSummary({
    Key? key,
    required this.value,
    this.width = 200,
    this.height = 12,
    this.color = const Color.fromARGB(255, 26, 130, 195),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clamped = value.clamp(0.0, 1.0);
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(height / 2),
        child: Stack(
          children: [
            Container(color: Colors.grey[200]),
            FractionallySizedBox(
              widthFactor: clamped,
              child: Container(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
