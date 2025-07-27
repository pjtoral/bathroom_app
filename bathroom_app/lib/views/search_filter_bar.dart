import 'package:flutter/material.dart';

class SearchFilterBar extends StatelessWidget {
  final TextEditingController controller;
  final double? selectedRating;
  final Function(String) onSearchChanged;
  final Function(double?) onRatingFilterChanged;

  const SearchFilterBar({
    super.key,
    required this.controller,
    required this.selectedRating,
    required this.onSearchChanged,
    required this.onRatingFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.orange, width: 1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(Icons.search, color: Colors.orange),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onSearchChanged,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Find nearest comfort room',
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 138, 138, 138),
                ),
                isDense: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Theme(
              data: Theme.of(context).copyWith(
                dropdownMenuTheme: DropdownMenuThemeData(
                  menuStyle: MenuStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(160, 40),
                    ),
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                  ),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<double>(
                  value: selectedRating,
                  icon: const Icon(Icons.tune, color: Colors.orange),
                  alignment: AlignmentDirectional.centerEnd,
                  isDense: true,
                  items: [null, 1, 2, 3, 4, 5].map((value) {
                    if (value == null) {
                      return const DropdownMenuItem<double>(
                        value: null,
                        child: Text("All"),
                      );
                    } else {
                      return DropdownMenuItem<double>(
                        value: value.toDouble(),
                        child: Row(
                          children: List.generate(
                            value,
                            (_) => const Icon(Icons.star, color: Colors.orange, size: 16),
                          ),
                        ),
                      );
                    }
                  }).toList(),
                  onChanged: onRatingFilterChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
