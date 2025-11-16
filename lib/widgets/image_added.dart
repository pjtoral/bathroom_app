import 'package:flutter/material.dart';

/// A row showing an uploaded image item with a name, size and progress bar.
///
/// Use this widget as a presentational item in upload lists. The parent should
/// manage upload state and pass the current progress via [progressPercent].
class ImageAddedWidget extends StatelessWidget {
  /// The displayed filename for the uploaded image.
  final String imageName;

  /// Upload progress percentage (0-100).
  final int progressPercent;

  /// Callback invoked when the user requests removal of this image.
  final VoidCallback onRemove;

  const ImageAddedWidget({
    Key? key,
    required this.imageName,
    required this.progressPercent,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double barWidth = 110;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.image, size: 28, color: Colors.black),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                imageName,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const Text(
                "51tb",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Stack(
                children: [
                  Container(
                    width: barWidth,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  Container(
                    width: barWidth * (progressPercent / 100),
                    height: 6,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 26, 130, 195),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close, color: Colors.red, size: 22),
          ),
        ],
      ),
    );
  }
}
