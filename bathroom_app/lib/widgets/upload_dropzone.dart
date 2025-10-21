import 'package:flutter/material.dart';

/// Reusable tappable area for adding media.
///
/// Keep this widget presentation-only; the parent should handle file picking
/// when [onTap] is invoked.
class UploadDropZone extends StatelessWidget {
  /// Called when the user taps the drop zone.
  final VoidCallback? onTap;

  /// Height of the drop zone.
  final double height;

  /// Hint text shown below the icon.
  final String hint;

  /// Icon shown in the center.
  final IconData icon;

  const UploadDropZone({
    Key? key,
    this.onTap,
    this.height = 140,
    this.hint = 'Add your images here!\nBrowse and add images to be posted',
    this.icon = Icons.add,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: const Color.fromARGB(255, 26, 130, 195), size: 36),
              const SizedBox(height: 8),
              Text(
                hint,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
