import 'package:flutter/material.dart';

/// A small pill-shaped tag or badge.
///
/// Use [PillChip] for non-interactive badges or wire [onTap] for tappable chips.
class PillChip extends StatelessWidget {
  /// The text label displayed inside the pill.
  final String label;

  /// Background color of the pill.
  final Color backgroundColor;

  /// Optional text style for the label.
  final TextStyle? textStyle;

  /// Called when the user taps the pill.
  final VoidCallback? onTap;

  /// Padding inside the pill.
  final EdgeInsets padding;

  const PillChip({
    Key? key,
    required this.label,
    this.backgroundColor = const Color.fromARGB(255, 26, 130, 195),
    this.textStyle,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        margin: const EdgeInsets.only(right: 8, bottom: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          style: textStyle ?? const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
        ),
      ),
    );
  }
}
