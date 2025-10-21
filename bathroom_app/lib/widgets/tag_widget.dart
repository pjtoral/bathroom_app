import 'package:flutter/material.dart';

/// A small selectable tag used in tag pickers and tag lists.
///
/// The widget manages its own toggle state by default. Provide [onToggle] to
/// receive selection updates from the parent.
class TagWidget extends StatefulWidget {
  /// The text label shown inside the tag.
  final String text;

  /// Callback invoked when the tag toggles. The boolean parameter indicates
  /// the new enabled state.
  final ValueChanged<bool>? onToggle;

  const TagWidget({Key? key, required this.text, this.onToggle}) : super(key: key);

  @override
  State<TagWidget> createState() => _TagWidgetState();
}

/// Toggles the tag state and notifies [onToggle] if present.
class _TagWidgetState extends State<TagWidget> {
  // Whether this tag is enabled.
  bool enabled = false;

  /// Toggle the enabled state of this tag.
  void toggle() {
    setState(() {
      enabled = !enabled;
      if (widget.onToggle != null) widget.onToggle!(enabled);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: enabled ? const Color.fromARGB(255, 26, 130, 195) : Colors.grey[400],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 6),
          ],
        ),
      ),
    );
  }
}
