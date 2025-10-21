import 'package:flutter/material.dart';

/// Search bar with a filter button that opens a bottom-sheet filter dialog.
///
/// This presentational widget forwards search changes via [onSearchChanged] and
/// selected filters via [onRatingFilterChanged] and [onTagsChanged].
class SearchFilterBar extends StatelessWidget {
  /// Controller for the search input.
  final TextEditingController controller;

  /// Focus node for the search input (optional).
  final FocusNode? focusNode;

  /// Whether a rating filter is currently selected (nullable).
  final double? selectedRating;

  /// Currently selected tags.
  final List<String> selectedTags;

  /// Called when the search text changes.
  final ValueChanged<String> onSearchChanged;

  /// Called when the rating filter changes.
  final ValueChanged<double?> onRatingFilterChanged;

  /// Called when the selected tags list changes.
  final ValueChanged<List<String>> onTagsChanged;

  const SearchFilterBar({
    super.key,
    required this.controller,
    this.focusNode,
    required this.selectedRating,
    required this.selectedTags,
    required this.onSearchChanged,
    required this.onRatingFilterChanged,
    required this.onTagsChanged,
  });

  /// Show the filter bottom sheet and allow temporary edits before applying.
  void _showFilterSheet(BuildContext context) {
    final tags = [
      'Bidet', 'Soap', 'Clean', 'Bad', 'LGBT-Friendly',
      'Accessible', 'Toilet Paper', 'Air Freshener',
      'Sink', 'Mirror', 'Hand Dryer', 'Tissue',
      'Trash Bin', 'Urinal'
    ];

    List<String> tempSelectedTags = List.from(selectedTags);
    double? tempRating = selectedRating;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(builder: (ctx, setSheetState) {
          const double boxHeight = 56.0;
          final decoration = InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          );

          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Filter',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),

                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text('Sort by',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: boxHeight,
                  child: InputDecorator(
                    decoration: decoration,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<double>(
                        isExpanded: true,
                        value: tempRating,
                        hint: const Text('None'),
                        icon: const Icon(Icons.arrow_drop_down),
                        items: [null, 1, 2, 3, 4, 5].map((value) {
                          if (value == null) {
                            return const DropdownMenuItem<double>(
                              value: null,
                              child: Text('None'),
                            );
                          }
                          return DropdownMenuItem<double>(
                            value: value.toDouble(),
                            child: Row(
                              children: List.generate(
                                value,
                                (_) => const Icon(Icons.star, color: Color.fromARGB(255, 26, 130, 195), size: 16),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (v) => setSheetState(() => tempRating = v),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text('Include Tags',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: boxHeight,
                  child: InputDecorator(
                    decoration: decoration,
                    isEmpty: tempSelectedTags.isEmpty,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: null,
                        hint: Text(
                          tempSelectedTags.isEmpty
                              ? 'None'
                              : tempSelectedTags.join(', '),
                          overflow: TextOverflow.ellipsis,
                        ),
                        icon: const Icon(Icons.arrow_drop_down),
                        items: tags.map((tag) {
                          final isSel = tempSelectedTags.contains(tag);
                          return DropdownMenuItem<String>(
                            value: tag,
                            child: Row(
                              children: [
                                Checkbox(
                                  value: isSel,
                                  onChanged: (_) {
                                    setSheetState(() {
                                      if (isSel) {
                                        tempSelectedTags.remove(tag);
                                      } else {
                                        tempSelectedTags.add(tag);
                                      }
                                    });
                                  },
                                ),
                                Expanded(child: Text(tag)),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (tag) {
                          if (tag == null) return;
                          setSheetState(() {
                            if (tempSelectedTags.contains(tag)) {
                              tempSelectedTags.remove(tag);
                            } else {
                              tempSelectedTags.add(tag);
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    onRatingFilterChanged(tempRating);
                    onTagsChanged(tempSelectedTags);
                    Navigator.pop(ctx);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 26, 130, 195),
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Apply',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color.fromARGB(255, 26, 130, 195), width: 1),
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
              onChanged: onSearchChanged,
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
          IconButton(
            icon: const Icon(Icons.tune, color: Color.fromARGB(255, 26, 130, 195)),
            onPressed: () => _showFilterSheet(context),
          ),
        ],
      ),
    );
  }
}
