List<Map<String, dynamic>> filterSearchResults({
  required String query,
  required List<Map<String, dynamic>> data,
  double? minRating,
}) {
  return data.where((item) {
    final name = item['name'].toString().toLowerCase();
    final matchesName = name.contains(query.toLowerCase());
    final matchesRating = minRating == null || item['rating'] >= minRating;
    return matchesName && matchesRating;
  }).toList();
}
