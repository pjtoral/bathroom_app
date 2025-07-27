List<Map<String, dynamic>> filterSearchResults({
  required String query,
  required List<Map<String, dynamic>> data,
}) {
  final rating = double.tryParse(query);
  if (rating == null) return [];

  return data.where((item) {
    final itemRating = item['rating'];
    return itemRating >= rating && itemRating < rating + 1;
  }).toList();
}
