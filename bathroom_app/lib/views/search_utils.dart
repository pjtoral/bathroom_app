List<Map<String, dynamic>> filterSearchResults({
  required String query,
  required List<Map<String, dynamic>> data,
  double? minRating,
  List<String>? tags,
}) {
  return data.where((item) {
    // 1) Name match
    final name = (item['name'] as String).toLowerCase();
    final matchesQuery = query.trim().isEmpty
        ? true
        : name.contains(query.toLowerCase().trim());

    // 2) Rating match
    final rating = (item['rating'] as num).toDouble();
    final matchesRating = minRating == null ? true : (rating >= minRating);

    // 3) Tags match: if tags list is empty or null, accept all;
    //    otherwise, every selected tag must be present in item's tags.
    final itemTags = (item['tags'] as List<dynamic>?)
            ?.map((t) => t.toString())
            .toList() ??
        [];
    final matchesTags = (tags == null || tags.isEmpty)
        ? true
        : tags.every((tag) => itemTags.contains(tag));

    return matchesQuery && matchesRating && matchesTags;
  }).toList();
}
