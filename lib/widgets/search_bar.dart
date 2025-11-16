import 'package:flutter/material.dart';

/// Reusable search input with a leading icon and a filter button callback.
///
/// Provide the controller from the parent so it can read/clear the text.
/// The parent should handle debouncing and filtering results.
class SearchBarWidget extends StatelessWidget {
  /// Controller for the text input.
  final TextEditingController controller;

  /// Optional focus node to control focus externally.
  final FocusNode? focusNode;

  /// Hint text displayed when input is empty.
  final String hintText;

  /// Called when the input text changes.
  final ValueChanged<String> onChanged;

  /// Callback invoked when the filter button is tapped.
  final VoidCallback onFilterTap;

  const SearchBarWidget({
    Key? key,
    required this.controller,
    this.focusNode,
    this.hintText = 'Find nearest comfort room',
    required this.onChanged,
    required this.onFilterTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color.fromARGB(255, 26, 130, 195), width: 1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(Icons.search, color: Color.fromARGB(255, 26, 130, 195)),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              onChanged: onChanged,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(color: Color(0xFF8A8A8A)),
                isDense: true,
              ),
            ),
          ),
          GestureDetector(
            onTap: onFilterTap,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Icon(Icons.tune, color: Color.fromARGB(255, 26, 130, 195)),
            ),
          ),
        ],
      ),
    );
  }
}
