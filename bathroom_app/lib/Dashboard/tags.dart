import 'package:flutter/material.dart';

class TagWidget extends StatefulWidget {
  final String text;
  final ValueChanged<bool>? onToggle;

  const TagWidget({Key? key, required this.text, this.onToggle})
    : super(key: key);

  @override
  State<TagWidget> createState() => _TagWidgetState();
}

class _TagWidgetState extends State<TagWidget> {
  bool enabled = false;

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
